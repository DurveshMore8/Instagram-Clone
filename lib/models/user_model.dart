class UserModel {
  final String uid;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String gender;
  final String profilePic;
  final String bio;
  final int posts;

  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.gender,
    required this.profilePic,
    required this.bio,
    required this.posts,
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
        'posts': posts,
      };
}
