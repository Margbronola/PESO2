class UserModel {
  final int id;
  final String fname;
  final String lname;
  final String email;

  const UserModel({
    required this.email,
    required this.fname,
    required this.id,
    required this.lname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      fname: json['fname'],
      id: json['uid'],
      lname: json['lname'],
    );
  }
}
