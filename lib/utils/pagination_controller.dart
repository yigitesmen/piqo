import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

typedef PageFetcher = Future<QuerySnapshot> Function({
  required int limit,
  DocumentSnapshot? startAfter,
});

typedef DocMapper<T> = Future<T> Function(DocumentSnapshot doc);

/// Shared infinite-scroll pagination for Firestore-backed lists.
///
/// Owns the fetched [items] plus the loading/error/hasNext state, and drives
/// [fetchNextPage] both on first load and whenever the attached
/// [ScrollController] nears the bottom of the list.
class PaginationController<T> {
  final List<T> items = [];
  final int initialPageSize;
  final int nextPageSize;
  final PageFetcher fetchPage;
  final DocMapper<T> mapDoc;
  final VoidCallback onChange;

  /// When set, [onChange] is also invoked every N items while a page is
  /// still being mapped, so a large page can render progressively instead
  /// of appearing all at once.
  final int? notifyEvery;

  DocumentSnapshot? _lastDoc;
  bool hasNext = true;
  bool isFetching = false;
  Object? error;

  PaginationController({
    required this.initialPageSize,
    required this.nextPageSize,
    required this.fetchPage,
    required this.mapDoc,
    required this.onChange,
    this.notifyEvery,
  });

  Future<void> fetchNextPage() async {
    if (isFetching || !hasNext) return;
    final limit = items.isEmpty ? initialPageSize : nextPageSize;
    isFetching = true;
    error = null;
    onChange();
    try {
      final snapshot = await fetchPage(limit: limit, startAfter: _lastDoc);
      if (snapshot.docs.isEmpty) {
        hasNext = false;
        return;
      }
      _lastDoc = snapshot.docs.last;
      hasNext = snapshot.docs.length == limit;
      final docs = snapshot.docs;
      for (var i = 0; i < docs.length; i++) {
        items.add(await mapDoc(docs[i]));
        if (notifyEvery != null && i % notifyEvery! == notifyEvery! - 1) {
          onChange();
        }
      }
    } catch (e) {
      error = e;
    } finally {
      isFetching = false;
      onChange();
    }
  }

  void attachScrollController(ScrollController controller) {
    controller.addListener(() {
      final position = controller.position;
      final nearBottom = controller.offset >=
          position.maxScrollExtent - kInfiniteScrollLoadMoreThreshold;
      if (!nearBottom || position.outOfRange) return;
      if (hasNext) fetchNextPage();
    });
  }
}
