
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../video_api/models/Videos_list.dart';
import '../video_api/models/channel_info.dart';
import 'consts.dart';



class Services {
  static const  CHANNAEL_ID='UC0ArlFuFYMpEewyRBzdLHiw';


/*  static const  CHANNAEL_ID=[
    'UC0ArlFuFYMpEewyRBzdLHiw'
  ,'UCW5YeuERMmlnqo4oq8vwUpg'];*/


  static const _baseUrl = 'www.googleapis.com';



  static Future<Channelinfo> getChannelInfo() async {
    Map<String ,String> prameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': CHANNAEL_ID,
      'key': Constants.API_KEY,
    };

    Map<String ,String> headers={

      HttpHeaders.contentTypeHeader:'application/json',

    };

    Uri uri = Uri.https (_baseUrl , '/youtube/v3/channels',
      prameters,
    );
    Response response =await http.get(uri,headers:headers);

    print(response.body);
    Channelinfo channelinfo =channelinfoFromJson(response.body);
    return channelinfo ;


  }


  static Future<VideosList> getVideosList({required String playListId ,required String pageToken})async{
    Map<String ,String> prameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults':'30',
      'pageToken':pageToken,
      'key':Constants.API_KEY,

    };
    Map<String ,String> headers={

      HttpHeaders.contentTypeHeader:'application/json',

    };

    Uri uri = Uri.https (_baseUrl , '/youtube/v3/playlistItems',
      prameters,
    );
    Response response =await http.get(uri,headers:headers);

   // print(response.body);
    VideosList videosList =videosListFromJson(response.body);
    return videosList;




  }
  }



