import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:piqo/utils/timestamp_formatter.dart';

void main() {
  String formatAgo(Duration ago) {
    return TimestampFormatter.format(
        Timestamp.fromDate(DateTime.now().subtract(ago)));
  }

  test('formats a moment in the past few seconds in seconds', () {
    expect(formatAgo(const Duration(seconds: 5)), endsWith('s'));
  });

  test('formats a moment an hour ago in hours', () {
    expect(formatAgo(const Duration(hours: 3)), '3sa');
  });

  test('formats a moment days ago in days', () {
    expect(formatAgo(const Duration(days: 2)), '2g');
  });

  test('formats a moment over a year ago in years', () {
    expect(formatAgo(const Duration(days: 400)), '1y');
  });
}
