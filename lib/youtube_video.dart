import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/widgets/alert.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoId;

  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  late Future<Video> _video;
  bool _isNearEnd = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _video = _getVideoDetails();
  }

  Future<Video> _getVideoDetails() async {
    final yt = YoutubeExplode();
    final video = await yt.videos.get(widget.videoId);
    yt.close();
    return video;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Video>(
          future: _video,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const Text('Loading...');
            }
          },
        ),
      ),
      body: FutureBuilder<Video>(
        future: _video,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    // do something
                  },
                ),
                const SizedBox(height: 16),
                Text(snapshot.data!.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                const Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 25, height: 25,child: CircleAvatar(backgroundColor: AppColors.green,child: const Icon(Icons.person, size: 20,),)),
                                  const SizedBox(width: 20,),
                                  const Expanded(child: TextField(
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Yorum ekleyin...',
                                    ),
                                  )
                                  ),
                                  const SizedBox(width: 20,),
                                  TextButton(onPressed: (){}, child: const Text("Yorum yap")),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          commentTile("Burak Taha", "(4 gün önce)", "Dakika 3'teki kodun mantığı ne? Anlayamadım..", 5),
                          const Divider(thickness: .5,),
                          commentTile("Enes Cevher", "(5 saat önce)", "Bu ders izlediğim en iyi derslerden biriydi", 1),
                          const Divider(thickness: .5,),
                          commentTile("Selen Ela", "(2 hafta önce)", "State managementa geçmek için sabırsızlanıyorum", 4),
                          const Divider(thickness: .5,),
                          commentTile("Yağmur Şeker", "(3 gün önce)", "güzeldi", 2),

                        ]
                      ),
                    ),
                  ),
                )

              ],
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

  Container commentTile(String name, String time, String text, int comment) {
    return Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 25, height: 25,child: CircleAvatar(child: Icon(Icons.person, size: 20,),)),
                        const SizedBox(width: 5,),
                        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        const SizedBox(width: 5,),
                        Text(time, style: const TextStyle(color: Colors.grey),)
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Text(text),
                    TextButton(onPressed: (){}, child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_drop_down),
                        Text("$comment yanıt")
                      ],
                    ))
                  ],
                ),
              );
  }
}
