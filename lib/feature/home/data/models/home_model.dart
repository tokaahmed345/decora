import 'package:decora/feature/home/domain/entity/home_entity.dart';

class HomeModel {
  final List<Items> items;

  HomeModel({required this.items});
}

class Items extends HomeEntity {
  final String id;
  final bool isFavorite;

  Items({
    required this.id,
    required super.title,
    required super.category,
    required super.image,
    this.isFavorite = false,
  });

  factory Items.fromMap(Map<String, dynamic> data, String docId) {
    return Items(
      id: docId,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      image: data['imageUrl'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'imageUrl': image,
      'isFavorite': isFavorite,
    };
  }
}