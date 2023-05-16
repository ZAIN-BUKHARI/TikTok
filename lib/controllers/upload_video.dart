import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/models/video.dart';
import 'package:tiktok_tutorial/views/screens/video_screen.dart';
import 'package:video_compress/video_compress.dart';

import '../views/screens/add_video_screen.dart';

class UploadVideoController extends GetxController {
  // static UploadVideoController instance = Get.find();

//   //_thumbNailGenerator
  getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

//   //gen thumbanil
  Future<String> _videoThumbnail(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnail').child(id);
    // compress video
    UploadTask uploadTask = ref.putFile(await getThumb(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
     
    // UploadTask uploadTask = ref.putString(videoPath);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    // UploadTask uploadTask = ref.putFile(videoPath as File);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void uploadVideo(String caption, String songname, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userCollection =
          await fireStore.collection('users').doc(uid).get();

      // making id of videos
      var alldocs = await fireStore.collection('videos').get();
      int len = alldocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('Video $len', videoPath);

      // Video tumbnail autogen from video
      String thumbail = await _videoThumbnail('$len', videoPath);
      Video video = Video(
          // thumbail:(userCollection.data()! as Map<String, dynamic>)['thumbail'],
          thumbail:thumbail,
          videoUrl: videoUrl,
          uid: uid,
          id: '$len',
          profilePhoto:
              (userCollection.data()! as Map<String, dynamic>)['profilePhoto'],
          caption: caption,
          songname: songname,
          username:(userCollection.data()! as Map<String, dynamic>)['name'],
          likes: [],
          commentcount: 0,
          sharecount: 0);
      print('video map $video');
      await fireStore.collection('videos').doc('$len').set(video.fileJson());
      Get.snackbar('Success', 'Video uploaded');
      // Get.offAll((AddVideoScreen()));
    } catch (e) {
      Get.snackbar('Error uploading', e.toString());
      print(e);
    }
  }
}
