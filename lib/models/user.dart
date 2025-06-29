class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? imagemPath;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.imagemPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'imagemPath': imagemPath
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      imagemPath: map['imagemPath']
    );
  }
}
