class User {
  final int id;
  final String fname;
  final String lname;
  final String email;
  // final String password;

  const User({
    required this.email,
    required this.fname,
    required this.id,
    required this.lname,
    // required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      fname: json['fname'],
      id: json['uid'],
      lname: json['lname'],
    );
  }
}
