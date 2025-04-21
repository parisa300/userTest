import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String token}) : super(token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token']);
  }

  User toEntity() => this;
}
