import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampFormatter {
  static String format(Timestamp timestamp) {
    var duration = DateTime.now().difference(timestamp.toDate());
    int inYears = duration.inDays ~/ 365;
    if (inYears > 0) return '${inYears}y';
    if (duration.inDays > 0) return '${duration.inDays}g';
    if (duration.inHours > 0) return '${duration.inHours}sa';
    if (duration.inMinutes > 0) return '${duration.inMinutes}dk';
    return '${duration.inSeconds}s';
  }
}
