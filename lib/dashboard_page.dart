import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/menu_page.dart';
import 'package:oyunveuygulamaakademisi/qanda_page.dart';
import 'package:oyunveuygulamaakademisi/services/capitalize.dart';
import 'package:oyunveuygulamaakademisi/services/phoneauth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'course_headers_page.dart';
import 'profile_page.dart';
import 'widgets/courseline.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  late SharedPreferences prefs;
  late String phoneNumber;
  String name="";
  String surname="";
  late bool isFieldFlutter;
  late bool isEnglish;
  String? documentId;
  String? header;
  String? subtitle;

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
    FirebaseFirestore.instance
        .collection('oua')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      setState(() {
        name = documentSnapshot.get('name');
        surname = documentSnapshot.get('surname');
        globalUserName = capitalize("$name $surname");
      });
    });
    getLastDocumentTitle();
  }

  Future<DocumentSnapshot> getLastDocumentTitle() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('questionandanswer')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    setState(() {
      documentId = querySnapshot.docs.first.id;
      header = querySnapshot.docs.first['header'];
      subtitle = querySnapshot.docs.first['subtitle'];
    });

    return querySnapshot.docs.first;
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
      appBar: customAppBar(capitalize(name)),
      body: Container(
        clipBehavior: Clip.none,
        width: double.infinity,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              qandaCard(capitalize("$name $surname"), header ?? "", subtitle ?? "", documentId ?? ""),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    monthlySumWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Teknoloji Girişimciliği',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: ListView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        children: [
                          GirisimcilikWidget(
                              title: "Girişimcilik",
                              percent: 100,
                              image: AppImages.girisimcilik,
                              color: AppColors.yellow),
                          GirisimcilikWidget(
                              title: "Finans",
                              percent: 23,
                              image: AppImages.finans,
                              color: AppColors.blue),
                          GirisimcilikWidget(
                              title: "Hukuk",
                              percent: 70,
                              image: AppImages.hukuk,
                              color: AppColors.red),
                          GirisimcilikWidget(
                              title: "İnsan Kaynakları",
                              percent: 70,
                              image: AppImages.insankaynaklari,
                              color: AppColors.green),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                            title: "Flutter Hazırlık",
                            description:
                                "Flutter ile mobil, web ve masaüstü uygulamaları geliştirmeye başlayın.",
                            image: AppImages.code,
                            color: AppColors.blue,
                            percent: 77,
                            videoUrl: "https://www.youtube.com/playlist?list=PLCx8WctAcmdDjCsrka8dLGbeMWdrbP6vY",
                        ),
                        CourseLineWidget(
                            title: "Oyun Sanati",
                            description:
                                "2D ve 3D tasarım için en popüler uygulamaları kullanarak oyun sanatını öğrenin.",
                            image: AppImages.oyunsanati,
                            color: AppColors.blue,
                            percent: 13),
                        CourseLineWidget(
                            title: "Yazılımcılar İçin İngilizce",
                            description:
                                "Mesleki terimleri öğrenerek hem Flutter hem Unity için gerekli olan dil yeterliliklerini öğrenin.",
                            image: AppImages.ingilizce,
                            color: AppColors.green,
                            percent: 56),
                        CourseLineWidget(
                            title: "Girişimcilik",
                            description:
                                "Flutter ile mobil, web ve masaüstü uygulamaları geliştirmeye başlayın.",
                            image: AppImages.girisimcilik,
                            color: AppColors.yellow,
                            percent: 100)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell qandaCard(String userName, String header, String subtitle, String documentId) {
    return InkWell(
      onTap: () => Get.to(() => QAndAPage(userName: userName, documentId: documentId, showOldList: true,)),
      child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(AppImages.qanda),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(child: Text(header, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Text(subtitle, style: TextStyle(color: Colors.white.withAlpha(200)),)
                    ],
                  ),
                ),
              ),
    );
  }

  Container monthlySumWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: AppConstants.borderRadius, color: AppColors.blue),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: .55,
                  strokeWidth: 10,
                  color: AppColors.yellow,
                  backgroundColor: AppColors.grey,
                ),
              ),
              const Text(
                '55%',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  "Nisan Ayı Başladı!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Text(
                  'Nisan ayı görevlerini tamamlamana çok az kaldı',
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar customAppBar(String name) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Get.to(() => const MenuPage(), transition: Transition.leftToRightWithFade, fullscreenDialog: true),
        icon: const Icon(Icons.menu, size: 30, color: Colors.black,),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Selam, ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
      actions: [
        InkWell(
          onTap: () => Get.to(() => const ProfilePage(isFromDashboard: true), transition: Transition.rightToLeft, fullscreenDialog: true),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: AssetImage(AppImages.userPicture))),
          ),
        ),
        const SizedBox(width: 10,),
      ],
    );
  }
}



class GirisimcilikWidget extends StatelessWidget {
  const GirisimcilikWidget({
    super.key,
    required this.title,
    required this.percent,
    required this.image,
    required this.color,
  });

  final String title;
  final int percent;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(5) + const EdgeInsets.only(right: 10),
        width: 180,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppConstants.borderRadius,
            boxShadow: const [
              BoxShadow(blurRadius: 10, spreadRadius: -5, offset: Offset(0, 4))
            ]),
        child: InkWell(
          onTap: () => Get.to(() => const MyPlaylistPage(playlistUrl: "https://www.youtube.com/playlist?list=PLeqL-9zPf1PQxdGvLsLbJhQ6lzfqV5aIt",)),
          borderRadius: BorderRadius.circular(100),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(image))),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            color: color,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Tamamlanan: $percent%',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: percent,
                                child: Container(
                                  color: color,
                                )),
                            Expanded(
                                flex: (100 - percent),
                                child: Container(
                                  color: AppColors.grey,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
