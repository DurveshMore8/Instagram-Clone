class UserModel {
  final String uid;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String gender;
  final String profilePic;
  final String bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.gender,
    required this.profilePic,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'username': username,
        'phone': phone,
        'email': email,
        'gender': gender,
        'profilePic': profilePic,
        'bio': bio,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      username: map['username'],
      phone: map['phone'],
      email: map['email'],
      gender: map['gender'],
      profilePic: map['profilePic'],
      bio: map['bio'],
    );
  }
}
