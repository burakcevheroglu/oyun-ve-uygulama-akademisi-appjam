import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/intro_page.dart';
import 'package:oyunveuygulamaakademisi/otp_page.dart';
import 'package:oyunveuygulamaakademisi/services/provider.dart';
import 'package:oyunveuygulamaakademisi/widgets/alert.dart';

import '../const.dart';
import '../login_page.dart';
import '../services/phoneauth.dart';


const int _smsCodeTimeout = 60; //seconds
FirebaseAuth _auth = FirebaseAuth.instance;


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
              if(phoneController.text.length == 10 && phoneController.text.substring(0,1) == "5"){
                _auth.verifyPhoneNumber(
                    phoneNumber: "+90${phoneController.text}",
                    verificationCompleted: (credential) => print("doğrulama başarılı"),
                    verificationFailed: (error) {
                      phoneController.text="";
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IntroPage()),
                              (Route<dynamic> route) => false);
                    },
                    codeSent: (id, token) {
                      verifyId = id;
                      //Navigator.of(context).pop();
                      phoneNumber = phoneController.text;
                      phoneController.text="";
                      Get.to(() => const OTPPage(), transition: Transition.cupertinoDialog);
                    },
                    codeAutoRetrievalTimeout: (id) => print("zaman aşımına uğradı"),
                    timeout: const Duration(seconds: _smsCodeTimeout)
                );
              }
              else{
                showSnackbar(context, "Lütfen numaranı düzgün bir biçimde gir.");
              }
              // TODO: Handle this case.
              break;
            case ColoredButtonEnums.otpVerify:
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

enum ColoredButtonEnums{ introLogin, introRegister, login, otpVerify}