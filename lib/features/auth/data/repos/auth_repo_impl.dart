import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interview_preparation/core/services/data_services.dart';
import 'package:interview_preparation/core/utils/backend_endpoints.dart';
import 'package:interview_preparation/features/auth/data/models/user_entity.dart';
import 'package:interview_preparation/features/auth/data/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/cache_services.dart';
import '../../../../core/services/firebase_auth_services.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService authService;
  final DatabaseService databaseService;
  final CacheService cacheService = CacheService();
  AuthRepoImpl({required this.authService, required this.databaseService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    User? user;
    try {
      user = await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(
        name: username,
        email: email,
        uId: user.uid,
      );
      await addUserData(user: userEntity);
 
    var userModel = UserModel.fromEntity(userEntity);
    await cacheService.cacheUserData(userModel); 
      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = await getUserData(uid: user.uid);
       await cacheService.cacheUserData(userEntity); // Cache user data
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await authService.signInWithGoogle();
      var userEntity = UserModel.fromFirebaseUser(user);
       var isUserExist = await databaseService.checkIfDataExists(
          path: BackendEndpoint.isUserExists, docuementId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid);
      } else {
         await cacheService.cacheUserData(userEntity); // Cache user data
        await addUserData(user: userEntity);
      }
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(Failure(message: 'Unknown error occurred'));
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserModel> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUserData, docuementId: uid, documentId: uid);
    return UserModel.fromJson(userData);
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await authService.deleteUser();
    }
  }
  
  /// Logout function
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Sign out from Firebase
      await authService.logout();

      // Clear cached user data
      await cacheService.clearUserData();

      return const Right(null);
    } catch (e) {
      return Left(Failure(message: 'Logout failed: ${e.toString()}'));
    }
  }


}
