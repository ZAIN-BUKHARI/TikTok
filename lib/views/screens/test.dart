import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok_tutorial/controllers/comment_controller.dart';
import 'package:tiktok_tutorial/controllers/video_controller.dart';

import '../../controllers/search_controller.dart';

class Test extends StatelessWidget {
  final VideoController video = Get.put(VideoController());
  final SearchController con = Get.put(SearchController());
  final CommentController com = Get.put(CommentController());
  Test({super.key});

  @override
  Widget build(BuildContext context) {
    // final data = video.videoList.length;
    final data = com.comments.length;
    return Scaffold(
      body: ListView.builder(
          itemCount: data,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('hello'),
            );
          }),
    );
  }
}
