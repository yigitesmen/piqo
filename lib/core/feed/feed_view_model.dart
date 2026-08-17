import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../api/user_service.dart';
import '../../models/post.dart';
import '../../utils/constants.dart';
import '../../utils/pagination_controller.dart';

class FeedViewModel extends ChangeNotifier {
  final List<Post>? _fixedPosts;
  PaginationController<Post>? _pagination;

  FeedViewModel(List<Post>? posts, ScrollController scrollController)
      : _fixedPosts = posts {
    if (posts != null) return;
    _pagination = PaginationController<Post>(
      initialPageSize: 3,
      nextPageSize: 2,
      fetchPage: ({required limit, startAfter}) {
        Query query = kCollectionFeeds
            .doc(UserService.currentUid)
            .collection('user-feeds')
            .orderBy('timestamp', descending: true)
            .limit(limit);
        if (startAfter != null) query = query.startAfterDocument(startAfter);
        return query.get();
      },
      mapDoc: (doc) async =>
          Post.fromDoc(await kCollectionPosts.doc(doc.id).get()),
      onChange: notifyListeners,
    );
    _pagination!.attachScrollController(scrollController);
    _pagination!.fetchNextPage();
  }

  List<Post> get posts => _fixedPosts ?? _pagination!.items;
  bool get isFetching => _pagination?.isFetching ?? false;
  Object? get error => _pagination?.error;
}
