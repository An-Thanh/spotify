class UserEntity {
  String? userId;
  String? fullname;
  String? email;

  UserEntity({
    this.userId,
    this.fullname,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullname': fullname,
      'email': email,
    };
  }
}