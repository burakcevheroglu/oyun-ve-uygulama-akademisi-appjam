
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/dashboard_page.dart';

import '../const.dart';
import '../login_page.dart';


class ColoredButtonWidget extends StatelessWidget {
  const ColoredButtonWidget({
    super.key, required this.type
  });

  final ColoredButtonEnums type;

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;
    if(type== ColoredButtonEnums.introLogin || type == ColoredButtonEnums.login) isLogin = true;

    return Container(
      height: 55,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: (isLogin) ? AppColors.red : Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          switch(type){
            case ColoredButtonEnums.introLogin:
              Get.to(() => const LoginPage());
              // TODO: Handle this case.
              break;
            case ColoredButtonEnums.introRegister:
              Get.to(() => const LoginPage());
              // TODO: Handle this case.
              break;
            case ColoredButtonEnums.login:
              Get.offAll(const DashboardPage());
              // TODO: Handle this case.
              break;
          }
        },
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

enum ColoredButtonEnums{ introLogin, introRegister, login}