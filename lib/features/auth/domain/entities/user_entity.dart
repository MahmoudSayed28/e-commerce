class UserEntity {
  final String name, email, uId;

  UserEntity({required this.name, required this.email, required this.uId});
  Map<String, dynamic> toMap() => {'name': name, 'email': email, 'uId': uId};
}
