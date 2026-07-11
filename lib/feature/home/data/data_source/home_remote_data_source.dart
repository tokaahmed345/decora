import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/feature/home/data/models/home_model.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource({
    required this.firestore,
   
  });

  static const String _collectionName = 'products';


  Future<List<Items>> fetchData() async {
    final querySnapshot = await firestore.collection(_collectionName).get();
    return querySnapshot.docs
        .map((e) => Items.fromMap(e.data(), e.id))
        .toList();

  }
}