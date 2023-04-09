import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';

import 'widgets/colored_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String textContext = "Oyun ve Uygulama Akademisi’nde, gençlere yeni dijital beceriler edinmelerini sağlayacak eğitimler sunarak Türkiye’deki nitelikli iş gücünün yetiştirilmesine katkı sunuyoruz. Gençlerin hızla gelişen Bilgi İletişim Teknolojileri çağında talep gören yazılım, oyun tasarımı, uygulama geliştirme, proje yönetimi, girişimcilik gibi farklı alanlarda yetkinlik kazanmasını ve böylece Türkiye’nin dijitalleşme sürecini hızlandırmayı hedefliyoruz.";

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: Container(color: Colors.white,child: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.logo)
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
                  Text(textContext, style: TextStyle(color: Colors.white.withAlpha(150)),),
                  const SizedBox(height: 20,),
                  Row(
                    children: const [
                      Expanded(child: ColoredButtonWidget(type: ColoredButtonEnums.introLogin,)),
                      SizedBox(width: 10,),
                      Expanded(child: ColoredButtonWidget(type: ColoredButtonEnums.introRegister,)),
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

