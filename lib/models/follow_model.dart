class FollowModel {
  final String uid;
  final String name;
  final String username;
  final String profilePic;
  final DateTime date;

  FollowModel(
    this.uid,
    this.name,
    this.username,
    this.profilePic,
    this.date,
  );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'username': username,
        'profilePic': profilePic,
        'date': date
      };
}
