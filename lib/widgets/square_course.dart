
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/course_headers_page.dart';

import '../const.dart';

class SquareCourseWidget extends StatelessWidget {
  const SquareCourseWidget({
    super.key, required this.title, required this.desc, required this.time, required this.color, this.func, this.width = 200,
    this.defaultUrl = "https://www.youtube.com/playlist?list=PLeqL-9zPf1PQxdGvLsLbJhQ6lzfqV5aIt"
  });

  final String title;
  final String desc;
  final int time;
  final Color color;
  final Function? func;
  final double width;
  final String defaultUrl;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 25),
      width: width,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: AppConstants.borderRadius,
          color: color
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("$time dk", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                const SizedBox(width: 5,),
                SizedBox(height: 23, width: 23,child: Image.asset(AppImages.time))
              ],
            ),
            const Text("Eğitim:", style: TextStyle(color: Colors.white),),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            Expanded(child: SingleChildScrollView(child: Text(desc, style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(150))))),
            InkWell(
              onTap: (func != null) ? () => func!() : () => Get.to(() => MyPlaylistPage(playlistUrl: defaultUrl)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text("Eğitime Git", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  Icon(Icons.chevron_right, color: Colors.white,)
                ],
              ),
            ),
            const SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
