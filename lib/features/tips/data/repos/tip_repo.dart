import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../data_sources/tip_local_data_source.dart';
import '../data_sources/tip_remote_data_source.dart';

abstract class TipRepo {
  Future<Either<Failure, List<Map<String, dynamic>>>> getTips(); // Use Map instead of a model
}

class TipRepoImpl implements TipRepo {
  final TipLocalDataSource _localDataSource = TipLocalDataSourceImpl();
  final TipRemoteDataSource _remoteDataSource = TipRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getTips() async {
    try {
      // Try fetching tips from the remote source
      final remoteTips = await _remoteDataSource.getRemoteTips();
      debugPrint('Tips fetched from remote source: $remoteTips');

      // Cache the fetched tips to local SQLite for future offline use
      await _localDataSource.getTips();
      debugPrint('Remote tips cached locally');

      return Right(remoteTips); // Return the remote tips
    } catch (e) {
      debugPrint('Failed to fetch remote tips, trying local. Error: $e');
      final localTips = await _localDataSource.getTips();
      return localTips.isNotEmpty
          ? Right(localTips)
          : Left(Failure(message: 'Failed to fetch tips from both remote and local sources.'));
    }
  }
}
