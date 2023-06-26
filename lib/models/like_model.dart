class LikeModel {
  final String uid;
  final String profilePic;
  final String name;
  final String username;
  final DateTime dateLiked;

  LikeModel({
    required this.uid,
    required this.profilePic,
    required this.name,
    required this.username,
    required this.dateLiked,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'profilePic': profilePic,
        'name': name,
        'username': username,
        'dateLiked': dateLiked,
      };
}
