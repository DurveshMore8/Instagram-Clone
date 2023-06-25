class FollowModel {
  final String uid;
  final String name;
  final String username;
  final String profilePic;
  final DateTime date;

  FollowModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.profilePic,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'username': username,
        'profilePic': profilePic,
        'date': date
      };
}
