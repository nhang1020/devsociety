import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MyVideo extends StatefulWidget {
  const MyVideo({super.key, required this.path});
  final String path;
  @override
  State<MyVideo> createState() => _VideoPLayerState();
}

class _VideoPLayerState extends State<MyVideo> {
  late ChewieController _chewieController;
  VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("");
  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.path));
    _videoPlayerController.setVolume(1);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController
        ..initialize().then((_) {
          setState(() {});
        }),
      // autoInitialize: true,
      materialProgressColors:
          ChewieProgressColors(playedColor: myColor, handleColor: Colors.white),
      draggableProgressBar: true,
      allowPlaybackSpeedChanging: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _videoPlayerController.value.isInitialized
          ? Container(
              clipBehavior: Clip.hardEdge,
              // height: 400,
              // margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Chewie(controller: _chewieController),
              ),
            )
          : Loading(),
    );
  }
}
