import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';
import '../../../utils/constants.dart';
import '../../../utils/pagination_controller.dart';

class PostGridViewModel with ChangeNotifier {
  String uid = '';
  late final PaginationController<Post> _pagination;
  StreamSubscription<QuerySnapshot>? _changesSubscription;

  @override
  void dispose() {
    _changesSubscription?.cancel();
    super.dispose();
  }

  PostGridViewModel.explore(ScrollController scrollController) {
    _pagination = PaginationController<Post>(
      initialPageSize: 24,
      nextPageSize: 6,
      notifyEvery: 12,
      fetchPage: ({required limit, startAfter}) {
        var query = kCollectionPosts
            .orderBy('timestamp', descending: true)
            .limit(limit);
        if (startAfter != null) query = query.startAfterDocument(startAfter);
        return query.get();
      },
      mapDoc: Post.fromDoc,
      onChange: notifyListeners,
    );
    _pagination.fetchNextPage();
    _pagination.attachScrollController(scrollController);
  }

  PostGridViewModel.profile(this.uid, ScrollController scrollController) {
    listenForChanges();
    _pagination = PaginationController<Post>(
      initialPageSize: 12,
      nextPageSize: 6,
      fetchPage: ({required limit, startAfter}) {
        var query = kCollectionPosts
            .where('ownerUid', isEqualTo: uid)
            .orderBy('timestamp', descending: true)
            .limit(limit);
        if (startAfter != null) query = query.startAfterDocument(startAfter);
        return query.get();
      },
      mapDoc: Post.fromDoc,
      onChange: notifyListeners,
    );
    _pagination.fetchNextPage();
    _pagination.attachScrollController(scrollController);
  }

  List<Post> get posts => _pagination.items;
  bool get isFetching => _pagination.isFetching;
  Object? get error => _pagination.error;

  void listenForChanges() {
    _changesSubscription = kCollectionPosts
        .where('ownerUid', isEqualTo: uid)
        .snapshots()
        .listen((event) {
      var docChanges =
          event.docChanges.where((e) => e.type == DocumentChangeType.removed);
      if (docChanges.isEmpty) return;
      var docChange = docChanges.first;
      _pagination.items.removeWhere((post) => post.id == docChange.doc.id);
      notifyListeners();
    }, onError: (error) {
      debugPrint('DEBUG: Error listening for post changes $error');
    });
  }
}
