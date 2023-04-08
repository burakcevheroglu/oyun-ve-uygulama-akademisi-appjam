import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/services/provider.dart';
import 'package:oyunveuygulamaakademisi/widgets/appbar.dart';

import 'widgets/courseline.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
            ref.read(navigationIndex.notifier).update((state) => 0);

          },
          icon: const Icon(Icons.chevron_left, size: 35,),
        ),
        surfaceTintColor: Colors.transparent,
        title: const Text("Profil"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.userPicture)
                )
              ),
            ),
            const SizedBox(height: 20,),
            const Text("Burak Taha Cevheroğlu", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            const SizedBox(height: 5,),
            const Text("Flutter İle Uygulama Geliştirme"),
            const SizedBox(height: 30,),
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: AppConstants.borderRadius,
                color: AppColors.grey
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 30,),
                  Image.asset(AppImages.slack),
                  const SizedBox(width: 20,),
                  const Text("Topluluğa Katıl", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  const SizedBox(width: 30,),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: AppConstants.borderRadius,
              ),
              child: Row(
                children: [
                  InfoTile("Flutter İle", "Uygulama Geliştirme", AppImages.code),
                  InfoTile("Yazılımcılar", "İçin İngilizce", AppImages.ingilizce),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Devam Eden Kurslar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      CourseLineWidget(
                          title: "Unity İle Oyun Geliştirme",
                          description:
                          "Unity ile oyun geliştirmeye başlayın.",
                          image: AppImages.code,
                          color: AppColors.blue,
                          percent: 100),
                      CourseLineWidget(
                          title: "Oyun Sanati",
                          description:
                          "2D ve 3D tasarım için en popüler uygulamaları kullanarak oyun sanatını öğrenin.",
                          image: AppImages.oyunsanati,
                          color: AppColors.blue,
                          percent: 100),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

  Expanded InfoTile(String text1, String text2, String image) {
    return Expanded(child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(image, fit: BoxFit.fitWidth,),
                  ),
                  Text(text1, style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 16),),
                  Text(text2, style: TextStyle(color: AppColors.blue),),
                ],
              ));
  }
}
