import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/trivia_page.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'widgets/youtube_icon.dart';
import 'youtube_video.dart';

class MyPlaylistPage extends StatefulWidget {
  final String playlistUrl;

  const MyPlaylistPage({Key? key, required this.playlistUrl}) : super(key: key);

  @override
  _MyPlaylistPageState createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  late List<Video> _videos;
  late Future<String> _playlistName;

  @override
  void initState() {
    super.initState();
    _playlistName = _getPlaylistName();
  }

  Future<String> _getPlaylistName() async {
    final yt = YoutubeExplode();
    final playlist = await yt.playlists.get(widget.playlistUrl);
    yt.close();
    return playlist.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: FutureBuilder<String>(
          future: _playlistName,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text("");
            }
          },
        ),
      ),
      body: FutureBuilder<List<Video>>(
        future: _loadPlaylist(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _videos = snapshot.data!;
            return ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                if(index%2==0){
                  return ListTile(
                    leading: youtubeIcon(),
                    title: Text(video.title),
                    subtitle: Text(videoLength(video.duration)),
                    trailing: const Icon(Icons.chevron_right, size: 30,),
                    onTap: () => Get.to(() => VideoPlayerPage(videoId: video.id.value))
                  );
                }
                else{
                  String title = 'Ders Videosu Soru ${(index/2+0.5).toString().replaceAll(".0", "")}';
                  return ListTile( // videoTitle: video.title, pageTitle: title
                    onTap: () => Get.to(() => TriviaPage(pageTitle: title,)),
                    leading: const Icon(Icons.question_mark),
                    title: Text(title),
                    subtitle: Text(video.title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }


  Future<List<Video>> _loadPlaylist() async {
    final playlistId = PlaylistId.parsePlaylistId(widget.playlistUrl);
    final yt = YoutubeExplode();
    final playlist = await yt.playlists.get(playlistId);
    final videos = await yt.playlists.getVideos(playlistId).toList();
    yt.close();
    return videos;
  }

  String videoLength(Duration? duration) {
    String minutes = "";
    String seconds = "";

    if (duration != null) {
      int totalMinutes = duration.inMinutes;
      int remainingSeconds = duration.inSeconds % 60;

      minutes = "${totalMinutes.toString().padLeft(2, '0')} dakika";
      seconds = "${remainingSeconds.toString().padLeft(2, '0')} saniye";
    } else {
      minutes = "00 dakika";
      seconds = "00 saniye";
    }

    return "$minutes  $seconds";
  }

}
