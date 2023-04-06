import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String textcontext = "Oyun ve Uygulama Akademisi’nde, gençlere yeni dijital beceriler edinmelerini sağlayacak eğitimler sunarak Türkiye’deki nitelikli iş gücünün yetiştirilmesine katkı sunuyoruz. Gençlerin hızla gelişen Bilgi İletişim Teknolojileri çağında talep gören yazılım, oyun tasarımı, uygulama geliştirme, proje yönetimi, girişimcilik gibi farklı alanlarda yetkinlik kazanmasını ve böylece Türkiye’nin dijitalleşme sürecini hızlandırmayı hedefliyoruz.";
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: Container(color: Colors.white,child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstants.logoPath)
                  )
                ),
              ),
            ),)),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.only(topLeft: AppConstants.singleBorderRadius, topRight: AppConstants.singleBorderRadius)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Akademi'ye Hoşgeldin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                  const SizedBox(height: 10,),
                  Text(textcontext, style: TextStyle(color: Colors.white.withAlpha(150)),),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: loginRegisterButton(true)),
                      const SizedBox(width: 10,),
                      Expanded(child: loginRegisterButton(false)),
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

  Container loginRegisterButton(bool isLogin) {
    return Container(
                      height: 55,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: (isLogin) ? AppColors.red : Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextButton(
                        onPressed: () => Get.to(() => const LoginPage()),
                        style: ButtonStyle(
                            overlayColor:
                            MaterialStateProperty.all((isLogin) ? AppColors.lightRed : null),
                        ),
                        child: Center(child:
                        (isLogin) ? const Text('Giriş Yap', style: TextStyle(color: Colors.white, fontSize: 16),)
                        : const Text('Kayıt Ol', style: TextStyle(color: Colors.black, fontSize: 16),)
                        ),
                      ),
                    );
  }
}
