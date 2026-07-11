import 'package:decora/feature/auth/domain/entity/signup_entity.dart';

class SignUpModel extends SignUpEntity{
  final String id;



  SignUpModel({
    required this.id,
    required super.fullName,
    required super.email,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': fullName,
      'email': email,

    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      id: map['id'] ?? '',
      fullName: map['name'] ?? '',
      email: map['email'] ?? '',
 
    );
  }
}
