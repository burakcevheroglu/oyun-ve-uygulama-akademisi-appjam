import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/all_qanda_page.dart';
import 'package:oyunveuygulamaakademisi/intro_page.dart';
import 'const.dart';
import 'courses_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text('Akademi Menü'),
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.chevron_right, size: 30, color: Colors.black,))
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              itemBuilder: (context, index){
                return ListTile(
                  onTap: menuItems[index]["function"],
                  leading: Icon(menuItems[index]["icon"], size: 30,),
                  title: Text(menuItems[index]["title"]),
                );
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.logo)
                  )
                ),
              ),
              const SizedBox(height: 30,),
              const Text('Bu uygulama\nF-31 takımı\ntarafından yapılmıştır', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              const SizedBox(height: 100,),
            ],
          )
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> menuItems = [
  {
    "title" : "Ana Sayfa",
    "icon" : Icons.home,
    "function" : () => Get.offAll(const DashboardPage(), transition: Transition.rightToLeft, fullscreenDialog: true)
  },
  {
    "title" : "Etkinlikler",
    "icon" : Icons.event,
    "function" : () => Get.offAll(const AllQAndAPage(isButtonBack: false,), transition: Transition.rightToLeft, fullscreenDialog: true)
  },
  {
    "title" : "Eğitimler",
    "icon" : Icons.stacked_bar_chart,
    "function" : () => Get.offAll(const CoursesPage(), transition: Transition.rightToLeft, fullscreenDialog: true)
  },
  {
    "title" : "Profil",
    "icon" : Icons.person,
    "function" : () => Get.offAll(const ProfilePage(isFromDashboard: false), transition: Transition.rightToLeft, fullscreenDialog: true)
  },
  {
    "title" : "Çıkış Yap",
    "icon" : Icons.logout,
    "function" : (){
      FirebaseAuth.instance.signOut();
      Get.offAll(const IntroPage(), transition: Transition.rightToLeft, fullscreenDialog: true);
    }
  }
];

