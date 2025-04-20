import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteDataService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  });
}

class FirestoreService implements RemoteDataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(path).add(data);
  }
}
