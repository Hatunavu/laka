import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen({Key? key, required this.path, required this.index})
      : super(key: key);
  final String path;
  final int index;
  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController chewieController;

  @override
  void dispose() {
    chewieController.pause();
    chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _videoPlayerController = VideoPlayerController.file(File(widget.path));
    chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        showControls: true);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.router.pop();
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(defaultPaddingItem.w),
                margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
                child: const Icon(
                  Ionicons.close,
                  size: 26,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
                child: Chewie(
              controller: chewieController,
            ))
          ],
        ),
      ),
    );
  }
}
