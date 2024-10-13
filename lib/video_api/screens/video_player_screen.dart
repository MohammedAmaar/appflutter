import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/Videos_list.dart';

class VideoPlayerScreen extends StatefulWidget {


   VideoPlayerScreen({required this.videoItem});

  final Videos_Item  videoItem;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late bool _isPlayerReader;


  @override
  void initState(){
    super.initState();
    _isPlayerReader =false;
    _controller =YoutubePlayerController(initialVideoId: widget.videoItem.video.resourceId.videoId,
   flags: const YoutubePlayerFlags (
        mute: false,
      autoPlay: true,
    ),
    )..addListener(_listener);


  }
  void _listener(){
    if(_isPlayerReader && mounted && !_controller.value.isFullScreen){

    }
  }

  @override
void deactivate() {
   _controller.pause();
    super.deactivate();
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(


        title: Container(
          color: Colors.red,
          child: Text(
            widget.videoItem.video.title
          ),
        ),
      ),
      body: Container(
        child: YoutubePlayer(
          controller: _controller,showVideoProgressIndicator: true,
          onReady: (){
            print('player is ready ..');
            _isPlayerReader =true;
            },
        ),
      ),
    );
  }
}
