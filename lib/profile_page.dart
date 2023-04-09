import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/important_links.dart';
import 'package:oyunveuygulamaakademisi/menu_page.dart';
import 'package:oyunveuygulamaakademisi/services/capitalize.dart';
import 'package:oyunveuygulamaakademisi/webview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/courseline.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key, required this.isFromDashboard}) : super(key: key);

  final bool isFromDashboard;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {

  late SharedPreferences prefs;
  late String phoneNumber;
  String name="";
  String surname="";
  bool isFieldFlutter = true;
  bool isEnglish = false;

  @override
  void initState() {
    // TODO: implement initState
    loadSharedPreferences();
    super.initState();
  }

  Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phoneNumber')!;
      name = prefs.getString('name')!;
      surname = prefs.getString('surname')!;
      isFieldFlutter = prefs.getBool('isFieldFlutter')!;
      isEnglish = prefs.getBool('english')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: profileLeadingButton(ref, widget.isFromDashboard),
        surfaceTintColor: Colors.transparent,
        title: const Text("Profil"),
        actions: [
          IconButton(onPressed: () => Get.to(() => const ImportantLinks()), icon: const Icon(Icons.link, size: 30,)),
          const SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.userPicture))),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "${capitalize(name)} ${capitalize(surname)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text((isFieldFlutter) ? "Flutter İle Uygulama Geliştirme" :  "Unity İle Oyun Geliştirme"),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const WebviewPage(
                    title: "Slack Kanalı",
                    url:
                        "https://join.slack.com/t/oyunveuygulama/shared_invite/zt-zv9d1lsn-njscscSjYoD~fk_hA84PHA"));
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: AppConstants.borderRadius,
                    color: AppColors.grey),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Image.asset(AppImages.slack),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Topluluğa Katıl",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                  (isFieldFlutter) ? infoTile("Flutter İle", "Uygulama Geliştirme", AppImages.code)
                  : infoTile("Unity İle", "Oyun Geliştirme", AppImages.code),
                  (isEnglish) ? infoTile("Yazılımcılar", "İçin İngilizce", AppImages.ingilizce) : const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bitirilen Kurslar',
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
                          description: "Unity ile oyun geliştirmeye başlayın.",
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
    );
  }
}

IconButton profileLeadingButton(WidgetRef ref, bool isFromDashboard) {
  if (isFromDashboard) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.chevron_left,
        size: 30,
        color: Colors.black,
      ),
    );
  } else {
    return IconButton(
      onPressed: () => Get.to(() => const MenuPage(),
          transition: Transition.leftToRightWithFade, fullscreenDialog: true),
      icon: const Icon(
        Icons.menu,
        size: 30,
        color: Colors.black,
      ),
    );
  }
}

Expanded infoTile(String text1, String text2, String image) {
  return Expanded(
      child: Column(
    children: [
      SizedBox(
        width: 50,
        height: 50,
        child: Image.asset(
          image,
          fit: BoxFit.fitWidth,
        ),
      ),
      Text(
        text1,
        style: TextStyle(
            color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        text2,
        style: TextStyle(color: AppColors.blue),
      ),
    ],
  ));
}
