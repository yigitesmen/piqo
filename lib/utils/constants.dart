import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore kFirestore = FirebaseFirestore.instance;

final CollectionReference kCollectionUsers = kFirestore.collection('users');

final CollectionReference kCollectionFollowers =
    kFirestore.collection('followers');

final CollectionReference kCollectionFollowing =
    kFirestore.collection('following');

final CollectionReference kCollectionPosts = kFirestore.collection('posts');

final CollectionReference kCollectionFeeds = kFirestore.collection('feeds');

final CollectionReference kCollectionNotifications =
    kFirestore.collection('notifications');

final CollectionReference kCollectionMessages =
    kFirestore.collection('messages');

final CollectionReference kCollectionReports = kFirestore.collection('reports');

/// Distance (in pixels) from the bottom of a scrollable list at which the
/// next page of results starts fetching.
const double kInfiniteScrollLoadMoreThreshold = 800;
