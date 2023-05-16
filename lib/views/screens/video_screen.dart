// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok_tutorial/constants.dart';

import '../../controllers/video_controller.dart';
import '../widgets/circle_animation.dart';
import '../widgets/video_player.dart';
import 'comment_screen.dart';

// ignore: must_be_immutable
class VideoScreen extends StatefulWidget {
  // final String url;
  VideoScreen({
    super.key,
    // required this.url
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoController videoController = Get.put(VideoController());

  // List<QueryDocumentSnapshot> docs = [];

  // Future<void> getData() async {
  //   final CollectionReference usersCollection =
  //       FirebaseFirestore.instance.collection('videos');

  //   final QuerySnapshot Snapshot = await usersCollection.get();

  //   docs = Snapshot.docs;

  //   setState(() => docs = Snapshot.docs);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<VideoController>(
      init: VideoController(),
      builder: (controller) {
        return Scaffold(
          body: StreamBuilder(
              // itemCount: controller.videoList.length,
              // controller: PageController(initialPage: 0, viewportFraction: 1),
              // scrollDirection: Axis.vertical,
              // itemBuilder: (context, index) {
                , builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
                final data = controller.videoList[index];
                return Stack(
                  children: [
                    VideoPlayerItem(videoUrl: data.videoUrl),
                    Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.songname,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.caption,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.music_note,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          data.username,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(data.profilePhoto),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap: () =>
                                              videoController.like(data.id),
                                          child: Icon(
                                            Icons.favorite,
                                            size: 40,
                                            color: data.likes.contains(
                                                    firebaseAuth
                                                        .currentUser!.uid)
                                                ? Colors.red
                                                : Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.likes.length.toString(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommentScreen(
                                                        id: data.id,
                                                      ))),
                                          child: Icon(
                                            Icons.comment,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.commentcount.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.share,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.sharecount.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  CircleAnimation(
                                    child:
                                        buildMusicAlbum(data.profilePhoto),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                      ],
                    )
                  ],
                );
              }),
        );
      },
    );
  }
}
