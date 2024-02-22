import 'dart:io';

import 'package:devsociety/config/VideoHelper.dart';
import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PageChooseVideo extends StatefulWidget {
  const PageChooseVideo({super.key});

  @override
  State<PageChooseVideo> createState() => _PageChooseVideoState();
}

class _PageChooseVideoState extends State<PageChooseVideo> {
  ChewieController? _chewieController;
  VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("");
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Future<void> pickVideo() async {
    final path = await VideoHelper.pickVideo();
    if (path != null) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      setState(() {
        final video = File(path);
        _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
            "https://drive.google.com/uc?export=download&id=1PnCo3RXRn_bNMOg1EyCRywZyLxir_b8-"));
        _videoPlayerController.setVolume(1);
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController
            ..initialize().then((_) {
              setState(() {});
            }),
          // autoInitialize: true,
          materialProgressColors: ChewieProgressColors(
              playedColor: myColor, handleColor: Colors.white),
          draggableProgressBar: true,
          allowPlaybackSpeedChanging: true,
        );
        postProvider.updateContent([video]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyButton(
            onPressed: () {
              pickVideo();
            },
          ),
          _chewieController != null
              ? Container(
                  clipBehavior: Clip.hardEdge,
                  // height: 400,
                  // margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
