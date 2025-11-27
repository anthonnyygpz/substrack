class SignUpEntity {
  final String email;
  final String password;
  final String username;
  final String? photoUrl;

  SignUpEntity({
    required this.email,
    required this.password,
    required this.username,
    this.photoUrl,
  });
}
