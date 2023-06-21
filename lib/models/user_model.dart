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
  final int followers;
  final int following;

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
    required this.followers,
    required this.following,
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
        'followers': followers,
        'following': following,
      };

  UserModel fromJson(Map<String, dynamic> user) {
    return UserModel(
      uid: user['uid'],
      name: user['name'],
      username: user['username'],
      phone: user['phone'],
      email: user['email'],
      gender: user['gender'],
      profilePic: user['profilePic'],
      bio: user['bio'],
      posts: user['posts'],
      followers: user['followers'],
      following: user['following'],
    );
  }
}
