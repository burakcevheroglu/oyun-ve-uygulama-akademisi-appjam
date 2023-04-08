import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/coursera_courses_page.dart';

import 'menu_page.dart';
import 'widgets/square_course.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.to(() => const MenuPage(), transition: Transition.leftToRightWithFade, fullscreenDialog: true),
          icon: const Icon(Icons.menu, size: 30, color: Colors.black,),
        ),
        title: const Text("Eğitimler"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Oyun ve Uygulama Geliştirme Eğitimleri", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              Text("Hayalindeki oyunu veya uygulamayı tasarlamak için ihtiyacın olan eğitimler 1 Aralık’ta başlıyor. Eğitimlerin yanı sıra eğitmenlerle gerçekleşecek seanslarda merak ettiklerini sorabileceksin ve bu alanlarda uzmanlaşma fırsatın olacak!", style: TextStyle(color: Colors.black.withAlpha(100), fontSize: 12),),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ListView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  children: [
                    SquareCourseWidget(title: "Flutter İle Uygulama Geliştirme", desc: "Flutter ile Android ve iOS uygulamaları geliştirmeyi öğrenin.", time: 1679, color: AppColors.blue, func: (){}),
                    SquareCourseWidget(title: "Unity İle Oyun Geliştirme", desc: "Unity kullanarak mobil ve PC platformları için oyun geliştirmeyi öğrenin.", time: 1092, color: AppColors.blue, func: (){}),
                    SquareCourseWidget(title: "Oyun Sanatı", desc: "2D ve 3D tasarım için en popüler uygulamaları kullanarak oyun sanatını öğrenin", time: 2072, color: AppColors.blue, func: (){})
                  ],
                )
              ),
              const SizedBox(height: 30,),
              const Text("Google Proje Yönetimi Programı (Coursera)*", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              Text("Coursera’da yer alan ve Türkiye’de ilk defa Türkçe olarak hazırlanan bu programa Akademi bursiyeri olarak hiçbir ücret ödemeden katılarak proje yönetimi konusunda uzmanlaşabilecek ve bu alanda bir kariyer sertifikası sahibi olabileceksin!", style: TextStyle(color: Colors.black.withAlpha(100), fontSize: 12),),
              const SizedBox(height: 10,),
              SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SquareCourseWidget(title: "Proje Yönetim Temelleri", desc: "Proje yönetimi kariyerine adım atmayı; etkili bir proje yöneticisi olmayı... ", time: 0, color: AppColors.red, func: (){}),
                      SquareCourseWidget(title: "Proje Başlatma: Başarılı Bir Proje Tasarlama", desc: "Proje yönetimi kariyerine adım atmayı; etkili bir proje yöneticisi olmayı", time: 0, color: AppColors.red, func: (){}),
                      Container(
                        padding: const EdgeInsets.all(15) + const EdgeInsets.only(bottom: 5),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: AppConstants.borderRadius,
                          color: AppColors.red
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            const Text("Diğer Coursera\nDerslerini Görmek İçin Tıkla", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            InkWell(
                              onTap: () => Get.to(() => const CourseraCourses()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text("Hepsini Gör", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  Icon(Icons.chevron_right, color: Colors.white,)
                                ],
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  )
              ),
              const SizedBox(height: 30,),
              const Text("Teknoloji Girişimciliği Eğitimleri", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              Text("Ocak’ta başlayan Girişimcilik Eğitimleri kapsamında bir teknoloji girişimcisinin ihtiyaç duyabileceği tüm finans, hukuk, temel girişimcilik gibi eğitimlerin tamamına erişebileceksin.", style: TextStyle(color: Colors.black.withAlpha(100), fontSize: 12),),
              const SizedBox(height: 10,),
              SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SquareCourseWidget(title: "Temel Girişimcilik", desc: "Yeni nesil girişim dünyasında var olmak için çıkacağın bu yolculukta ihtiyacın olacak...", time: 338, color: AppColors.yellow, func: (){}),
                      SquareCourseWidget(title: "Girişimciler İçin Hukuk", desc: "Yeni nesil girişim dünyasında var olmak için çıkacağın bu yolculukta ihtiyacın olacak...", time: 104, color: AppColors.red, func: (){}),
                      SquareCourseWidget(title: "Girişimciler İçin Finans", desc: "2D ve 3D tasarım için en popüler uygulamaları kullanarak oyun sanatını öğrenin", time: 177, color: AppColors.blue, func: (){}),
                      SquareCourseWidget(title: "Girişimciler İçin İK", desc: "İş hayatınızı yeniden inşa ederken ihtiyacınız olan becerileri kazanacak, başarılı...", time: 77, color: AppColors.green, func: (){}),
                    ],
                  )
              ),
              const SizedBox(height: 30,),
              const Text("Yazılımcılar İçin İngilizce", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              Text("Kariyerini teknoloji sektöründe kurarken faydalanabileceğin, oyun ve uygulama geliştirme alanında uluslararası standart ve trendleri takip edebilmeni kolaylaştıracak İngilizce eğitimlerine katıl.", style: TextStyle(color: Colors.black.withAlpha(100), fontSize: 12),),
              const SizedBox(height: 10,),
              SquareCourseWidget(title: "Yazılımcılar İçin İngilizce Eğitimi", desc: "Kariyerini teknoloji sektöründe kurarken faydalanabileceğin, oyun ve uygulama geliştirme alanında uluslararası standart ve trendleri takip edebilmeni kolaylaştıracak İngilizce eğitimlerine katıl.", time: 1693, color: AppColors.green, func: (){}, width: double.infinity,)
            ],
          ),
        ),
      ),
    );
  }
}
