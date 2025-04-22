
// domain/entities/user_entity.dart
class UserListEntity {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserListEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
}
