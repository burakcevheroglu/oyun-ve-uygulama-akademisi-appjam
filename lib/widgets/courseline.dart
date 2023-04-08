
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const.dart';
import '../course_headers_page.dart';

class CourseLineWidget extends StatelessWidget {
  const CourseLineWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.color,
    required this.percent,
  });

  final String title;
  final String description;
  final String image;
  final Color color;
  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: AppConstants.borderRadius,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 7, spreadRadius: -3, offset: Offset(0, 3))
          ]),
      child: InkWell(
        onTap: (){
          Get.to(() => const MyPlaylistPage(playlistUrl: "https://www.youtube.com/playlist?list=PLCx8WctAcmdDjCsrka8dLGbeMWdrbP6vY"));
        },
        borderRadius: BorderRadius.circular(100),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 10),
              width: 50,
              height: 90,
              decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(image))),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: color, fontSize: 18),
                      ),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                                flex: percent,
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: color),
                                )),
                            Expanded(
                                flex: 100 - percent,
                                child: Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(100),
                                          bottomRight: Radius.circular(100)),
                                      color: AppColors.grey),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "%$percent",
                              style: TextStyle(
                                  color: color, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}