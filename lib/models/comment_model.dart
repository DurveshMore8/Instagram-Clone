class CommentModel {
  final String uid;
  final String profilePic;
  final String username;
  final String comment;
  final DateTime commentedOn;

  CommentModel({
    required this.uid,
    required this.profilePic,
    required this.username,
    required this.comment,
    required this.commentedOn,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'profilePic': profilePic,
        'username': username,
        'comment': comment,
        'commentedOn': commentedOn,
      };
}
