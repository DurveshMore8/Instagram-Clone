class MessageModel {
  final String uid;
  final String message;
  final bool isMe;
  final DateTime timeStamp;

  MessageModel({
    required this.uid,
    required this.message,
    required this.isMe,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'message': message,
        'isMe': isMe,
        'timeStamp': timeStamp,
      };
}
