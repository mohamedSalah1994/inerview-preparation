import 'package:cloud_firestore/cloud_firestore.dart';

// Abstract class for remote data source
abstract class TipRemoteDataSource {
  Future<List<Map<String, dynamic>>> getRemoteTips();
  
}

// Firebase implementation for remote data source
class TipRemoteDataSourceImpl implements TipRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getRemoteTips() async {
    QuerySnapshot querySnapshot = await _firestore.collection('tips').get();

    // Converting the snapshot into a list of maps
    return querySnapshot.docs
        .map((doc) => {
              'id': doc.id,
              'tip': doc['tip'], // Adjust based on your Tip model
            })
        .toList();
  }


}
