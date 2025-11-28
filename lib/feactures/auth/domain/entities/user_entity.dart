class UserEntity {
  final String username;
  final String email;
  final String password;

  UserEntity({
    required this.username,
    required this.email,
    required this.password,
  });
}

class UpdateUserEntity {
  final String? username;
  final String? photoUrl;
  final String? password;

  UpdateUserEntity({this.username, this.password, this.photoUrl});
}
