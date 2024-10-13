import 'dart:developer';
import 'package:appflutter/video_api/screens/video_player_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constans_api/services.dart';
import '../models/Videos_list.dart';
import '../models/channel_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Channelinfo _channelinfo;
 late Item _item;
 late VideosList _videosList;
late bool _loading;
late String _playListId;
late String _nextPageToken;



  @override
  void initState(){
    super.initState();
    _loading= true;

     _videosList= VideosList.empty();
    _videosList.videos = [];
    _getChannalInfo();
    _nextPageToken ='';
  }
  _getChannalInfo()async{
    _channelinfo =await Services.getChannelInfo();
    _item =_channelinfo.items[0];
    _playListId =_item.contentDetails.relatedPlaylists.uploads;
    print('_playListId $_playListId');
    await _loadingVideos();

    setState(() {
      _loading =false;

    });
  }
  _loadingVideos()async{
     VideosList tempVideosList= await Services.getVideosList(
       playListId: _playListId,
       pageToken: _nextPageToken,
     );
     _nextPageToken =tempVideosList.nextPageToken;
     _videosList.videos.addAll(tempVideosList.videos);
     print('videos :${_videosList.videos.length}');
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('UV Videos')
        ,),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: ListView.builder(
                itemCount: _videosList.videos.length,
                  itemBuilder: (context, index){
                  Videos_Item videoItem =_videosList.videos[index];
                  return InkWell(
                    onTap:()async {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return VideoPlayerScreen(videoItem: videoItem);
                      }));
                    },
    child:Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: videoItem.video.thumbnails.thumbnailsDefault.url,
                          ),
                          const SizedBox(width: 20),
                          Flexible(child: Text(videoItem.video.title))
                          ,const SizedBox(width: 20)
                        ],
                      ),
                    ),
                  );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _buildInfoView(){

    return _loading ?const CircularProgressIndicator():
    Container(
      padding:const EdgeInsets.all(20.0) ,
      child: Card(
       child: Padding(
         padding: const EdgeInsets.all(10.0),
         child: Row(
           children: [
               CircleAvatar(
                 backgroundImage: CachedNetworkImageProvider(
                   _item.snippet.thumbnails.medium.url,
                 ),
               ),
               const SizedBox(width: 20),
               Expanded(
                 child: Text(_item.snippet.title,style: const TextStyle(fontSize: 20, fontWeight:FontWeight.w400,)
                   ,),
               ),
               Text(_item.statistics.videoCount),
               const SizedBox(width: 20),

           ],
         ),
       )

    ),
    );
  }
}
