import 'package:cloud_firestore/cloud_firestore.dart';

String getPeriod(int difference) {
  if (difference < 60) {
    if (difference == 1) {
      return '1 second ago';
    } else {
      return '$difference second ago';
    }
  } else if (difference < 3600) {
    if (difference ~/ 60 <= 1) {
      return '1 minute ago';
    } else {
      return '${difference ~/ 60} minutes ago';
    }
  } else if (difference < 86400) {
    if (difference ~/ 3600 <= 1) {
      return '1 hour ago';
    } else {
      return '${difference ~/ 3600} hours ago';
    }
  } else if (difference < 604800) {
    if (difference ~/ 86400 <= 1) {
      return '1 day ago';
    } else {
      return '${difference ~/ 86400} days ago';
    }
  } else {
    if (difference ~/ 604800 <= 1) {
      return '1 week ago';
    } else {
      return '${difference ~/ 604800} weeks ago';
    }
  }
}

String getShortPeriod(Timestamp timeStamp) {
  DateTime published =
      DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  int difference = DateTime.now().difference(published).inSeconds;

  if (difference < 60) {
    return '${difference}s';
  } else if (difference < 3600) {
    return '${difference ~/ 60}m';
  } else if (difference < 86400) {
    return '${difference ~/ 3600}h';
  } else if (difference < 604800) {
    return '${difference ~/ 86400}d';
  } else {
    return '${difference ~/ 604800}w';
  }
}
