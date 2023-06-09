import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/services/phoneauth.dart';
import 'package:oyunveuygulamaakademisi/widgets/youtube_icon.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key, required this.videoId}) : super(key: key);


  final String videoId;



  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  late Future<Video> _video;
  bool _showAppBar = true;


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

    _comments = [
      Comment(name: "Burak Taha Cevheroğlu", time: "2 saat önce", text: "Süper videoydu"),
      Comment(name: "Nisasu Bozkurt", time: "5 saat önce", text: "Dakika 3'teki kodu yazdığımda hata alıyorum nasıl yapıcam."),
      Comment(name: "Emre Ermenek", time: "2 gün önce", text: "State management için sabırsızlanıyorum"),
    ];
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
    _comments = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar ? AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          youtubeIcon(),
          const SizedBox(width: 10,),
        ],
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
      ) : null,
      body: FutureBuilder<Video>(
        future: _video,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SafeArea(
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.blue,
                      topActions: <Widget>[
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            _controller.metadata.author,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                      bottomActions: [
                        CurrentPosition(),
                        const SizedBox(width: 10.0),
                        ProgressBar(
                          isExpanded: true,
                          colors: ProgressBarColors(
                            playedColor: AppColors.blue,
                            handleColor: AppColors.blue,
                          ),
                        ),
                        RemainingDuration(),
                      ],
                    ),
                    onEnterFullScreen: () {
                      setState(() {
                        _showAppBar = false;
                      });
                    },
                    onExitFullScreen: () {
                      setState(() {
                        _showAppBar = true;
                      });
                    },
                    builder: (context, player) {
                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: player,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: Text(snapshot.data!.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Opacity(opacity: 0.1, child: Image.asset(AppImages.logo)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
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
                                    Expanded(child: TextField(
                                      controller: _commentController,
                                      autocorrect: false,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Yorum ekleyin...',
                                      ),
                                    )
                                    ),
                                    const SizedBox(width: 20,),
                                    TextButton(onPressed: () {
                                      if (_commentController.text.isNotEmpty) {
                                        setState(() {
                                          _comments.insert(
                                            0,
                                            Comment(
                                              name: globalUserName,
                                              time: "Şimdi",
                                              text: _commentController.text,
                                            ),
                                          );
                                          _commentController.clear();
                                        });
                                      }
                                    },child: const Text("Yorum yap")),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _comments.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final comment = _comments[index];
                                  return Column(
                                    children: [
                                      commentTile(comment.name, comment.time, comment.text, index),
                                      const Divider(thickness: .5),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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

  SizedBox commentTile(String name, String time, String text, int comment) {
    return SizedBox(
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


class Comment {
  final String name;
  final String time;
  final String text;

  Comment({required this.name, required this.time, required this.text});
}

List<Comment> _comments = [];
final TextEditingController _commentController = TextEditingController();

