import 'package:flutter/material.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class youtubeVid extends StatelessWidget {
  const youtubeVid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dersler'),
        actions: [
          IconButton(
            onPressed: () {
              YoutubeDataApi youtubeDataApi = YoutubeDataApi();
              Future<List<Video>> videoResult = youtubeDataApi.fetchPlayListVideos('PLCx8WctAcmdDjCsrka8dLGbeMWdrbP6vY',5);
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Container(
            child: VideoPlayer(videoId:'YMx8Bbev6T4'),
          ),
        ],
      ),

    );
  }
}

class VideoPlayer extends StatefulWidget {
  final String videoId;

  const VideoPlayer({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}