import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
                return ListTile(
                  leading: CircleAvatar(child: Text("${index+1}"),),
                  title: Text(video.title),
                  onTap: () {
                    // do something with the tapped video
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(videoId: video.id.value),
                      ),
                    );

                  },
                );
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
}
