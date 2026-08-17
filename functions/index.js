const functions = require('firebase-functions').region('europe-west6')
const admin = require('firebase-admin')

admin.initializeApp()

const db = admin.firestore()

exports.updateFeedsAfterSharingPost = functions.firestore
  .document('posts/{postId}').onCreate(async (snap, context) => {
    const postId = context.params.postId
    const { ownerUid, timestamp } = snap.data()
    const promises = []

    const userFollowersSnap = await db.collection('followers').doc(ownerUid).collection('user-followers').get()
    const followingList = userFollowersSnap.docs.map(doc => doc.id)
    followingList.push(ownerUid)
    followingList.forEach(uid => {
      promises.push(db.collection('feeds').doc(uid).collection('user-feeds').doc(postId).set({ timestamp }))
    })
    return await Promise.all(promises)
  })

exports.updateFeedsAfterDeletingPost = functions.firestore
  .document('posts/{postId}').onDelete(async (snap, context) => {
    const postId = context.params.postId
    const { ownerUid } = snap.data()
    const promises = []

    const userFollowersSnap = await db.collection('followers').doc(ownerUid).collection('user-followers').get()
    const followingList = userFollowersSnap.docs.map(doc => doc.id)
    followingList.push(ownerUid)
    followingList.forEach(uid => {
      promises.push(db.collection('feeds').doc(uid).collection('user-feeds').doc(postId).delete())
    })

    // Delete notifications
    const notifications = await db.collection('notifications').doc(ownerUid)
      .collection('user-notifications').where('postId', '==', postId).get()
    notifications.forEach(doc => promises.push(doc.ref.delete()))

    // Delete likes
    const postLikes = await db.collection('posts').doc(postId)
      .collection('post-likes').get()
    postLikes.forEach(doc => promises.push(doc.ref.delete()))

    // Delete comments
    const postComments = await db.collection('posts').doc(postId)
      .collection('post-comments').get()
    postComments.forEach(doc => promises.push(doc.ref.delete()))
    return await Promise.all(promises)
  })

exports.updateFeedsAfterFollowing = functions.firestore
  .document('following/{currUid}/user-following/{uid}').onCreate(async (_, context) => {
    const currUid = context.params.currUid
    const uid = context.params.uid
    const promises = []

    const posts = await db.collection('posts').where('ownerUid', '==', uid).get()
    posts.docs.forEach(doc => {
      const { timestamp } = doc.data()
      promises.push(db.collection('feeds').doc(currUid).collection('user-feeds').doc(doc.id).set({ timestamp }))
    })
    return await Promise.all(promises)
  })

exports.updateFeedsAfterUnfollowing = functions.firestore
  .document('following/{currUid}/user-following/{uid}').onDelete(async (_, context) => {
    const currUid = context.params.currUid
    const uid = context.params.uid
    const promises = []

    const posts = await db.collection('posts').where('ownerUid', '==', uid).get()
    posts.docs.forEach(doc => {
      promises.push(db.collection('feeds').doc(currUid).collection('user-feeds').doc(doc.id).delete())
    })
    return await Promise.all(promises)
  })
