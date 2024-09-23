import 'package:dartz/dartz.dart';

import 'package:interview_preparation/core/errors/failures.dart';
import 'package:interview_preparation/features/auth/data/models/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uid});
  Future<Either<Failure, void>> logout();
}
