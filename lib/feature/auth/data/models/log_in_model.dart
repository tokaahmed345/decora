import 'package:decora/feature/auth/domain/entity/log_in_entity.dart';

class LogInModel  extends LogInEntity{
  final String id;


  LogInModel({
    required this.id,
    required super.email,
 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
   
      'email': email,

    };
  }

  factory LogInModel.fromMap(Map<String, dynamic> map) {
    return LogInModel(
      id: map['id'] ?? '',

      email: map['email'] ?? '',
   
    );
  }
}
