import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/video_controller.dart';

class Player extends StatefulWidget {
  // final String videoPath;
  final File file;
  const Player({super.key,
  //  required this.videoPath,
    required this.file, 
    // required File videoFile
    });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController videoPlayerController;
  VideoController videoController = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.file(widget.file)
          ..initialize().then((value) {
            videoPlayerController.play();
            videoPlayerController.setVolume(1);
          });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
