class PostModel {
  final String uid;
  final String username;
  final String profilePic;
  final String postId;
  final String description;
  final DateTime published;
  final String url;

  PostModel({
    required this.uid,
    required this.username,
    required this.profilePic,
    required this.postId,
    required this.description,
    required this.published,
    required this.url,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'profilePic': profilePic,
        'postId': postId,
        'description': description,
        'published': published,
        'url': url,
      };
}
