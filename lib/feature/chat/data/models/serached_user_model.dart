import 'package:decora/feature/chat/domain/entity/app_user_entity.dart';

class SearchedUserModel extends SearchedUserEntity {
  SearchedUserModel({
    required super.id,
    required super.name,
  });

  factory SearchedUserModel.fromJson(Map<String, dynamic> json, String id) {
    return SearchedUserModel(
      id: id,
      name: json['name'] as String? ?? 'Unknown',
    );
  }
}