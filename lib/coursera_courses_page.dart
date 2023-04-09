import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/webview_page.dart';

import 'const.dart';
import 'widgets/square_course.dart';

class CourseraCourses extends StatelessWidget {
  const CourseraCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.chevron_left, size: 30, color: Colors.black,),
        ),
        title: const Text("Coursera Eğitimleri"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              SquareCourseWidget(title: "Proje Yönetim Temelleri", desc: "Proje yönetimi kariyerine adım atmayı; etkili bir proje yöneticisi olmayı; proje yönetimi döngüsü ve metodolojilerini öğren.", time: 0, color: AppColors.red, func: () => Get.to(() => const WebviewPage(title: "Proje Yönetiminin Temelleri", url: "https://www.coursera.org/learn/proje-yonetiminin-temelleri")), width: double.infinity, rightMargin: 0,),
              const SizedBox(height: 15,),
              SquareCourseWidget(title: "Proje Başlatma: Başarılı Bir Proje Tasarlama", desc: "Projeyi başlatmanın temellerini; proje hedeflerini, kapsamı ve başarı hedeflerini tanımlamayı; paydaşlarla verimli çalışmanın yollarını; projeyi başarıya ulaştırmak için kaynaklardan ve araçlardan faydalanmayı öğren.", time: 0, color: AppColors.red, func: () => Get.to(() => const WebviewPage(title: "Proje Başlatma", url: "https://www.coursera.org/learn/projeyi-baslatma-projeye-basariyla-adim-atma")), width: double.infinity, rightMargin: 0,),
              const SizedBox(height: 15,),
              SquareCourseWidget(title: "Proje Başlatma: Tüm Süreçleri Bir Araya Getirmek", desc: "Planlama aşamasına başlamayı; proje planı oluşturmayı; bütçe hazırlama ve satın alma süreçlerini yönetmeyi riskleri etkili bir şekilde yönetmeyi öğren.", time: 0, color: AppColors.red, func: () => Get.to(() => const WebviewPage(title: "Proje Planlaması ", url: "https://www.coursera.org/learn/proje-planlamasi-her-seyi-bir-araya-getirmek")), width: double.infinity, rightMargin: 0,),
              const SizedBox(height: 15,),
              SquareCourseWidget(title: "Proje Başlatma: Proje Süreçlerini Yürütme", desc: "Proje yürütmeyi; kalite yönetimi ve sürekli iyileştirmeyi; veriler ışığında karar almayı öğren ve liderlik becerilerini geliştir.", time: 0, color: AppColors.red, func: () => Get.to(() => const WebviewPage(title: "Projeyi Yürütme ", url: "https://www.coursera.org/learn/projeyi-yurutme-projeyi-hayata-gecirme")), width: double.infinity, rightMargin: 0,),
              const SizedBox(height: 15,),
              SquareCourseWidget(title: "Agile (Çevik) Proje Yönetimi", desc: "Agile, çevik proje yönetiminin temellerini; Scrum metodolojisini öğren ve organizasyonlarda Agile uygulamaları hakkında bilgi sahibi ol.", time: 0, color: AppColors.red, func: () => Get.to(() => const WebviewPage(title: "Çevik Proje Yönetimi", url: "https://www.coursera.org/learn/cevik-proje-yonetimi")), width: double.infinity, rightMargin: 0,),
              const SizedBox(height: 15,),
              SquareCourseWidget(title: "Gerçek Dünyada Proje Yönetimini Uygulama", desc: "Bir projeyi başlatmayı; proje planı oluşturmayı; kaliteyi korumayı ve etkili paydaş iletişimini sağlamayı öğren.", time: 0, color: AppColors.red, func: () => Get.to(() => const WebviewPage(title: "Bitirme Projesi", url: "https://www.coursera.org/learn/bitirme-projesi-proje-yonetimini-gercek-dunyada-uygulamak")), width: double.infinity, rightMargin: 0,),
            ],
          ),
        ),
      ),
    );
  }
}
