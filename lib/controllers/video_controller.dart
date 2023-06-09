import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/views/screens/add_video_screen.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        fireStore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> returnAllvideos = [];
      for (var element in query.docs) {
        returnAllvideos.add(
          Video.fromSnap(element),
        );
      }
      return returnAllvideos;
    }));
  }
  // fetch()async{
  //   _videoList.bindStream(
  //       fireStore.collection('videos').snapshots().map((QuerySnapshot query) {
  //     List<Video> returnAllvideos = [];
  //     for (var element in query.docs) {
  //       returnAllvideos.add(
  //         Video.fromSnap(element),
  //       );
  //     }
  //     return returnAllvideos;
  //   }));
  // }

  void like(String id) async {
    print(id);
    DocumentSnapshot doc = await fireStore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    print(uid);
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await fireStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await fireStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }


}
