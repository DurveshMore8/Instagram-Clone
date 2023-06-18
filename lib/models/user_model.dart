class UserModel {
  final String uid;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String profilePic;
  final String bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.profilePic,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'username': username,
        'phone': phone,
        'email': email,
        'profilePic': profilePic,
        'bio': bio,
      };

  UserModel fromJson(Map<String, dynamic> user) {
    return UserModel(
      uid: user['uid'],
      name: user['name'],
      username: user['username'],
      phone: user['phone'],
      email: user['email'],
      profilePic: user['profilePic'],
      bio: user['bio'],
    );
  }
}
