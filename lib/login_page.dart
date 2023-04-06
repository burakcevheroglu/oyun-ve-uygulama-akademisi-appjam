import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/widgets/colored_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30) + const EdgeInsets.only(bottom: 40),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage(AppConstants.logoPath),
                      scale: 5
                    )
                  ),
                ),
                const Expanded(child: Text("Google Oyun\nve Uygulama\nAkademisi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),))
              ],
            ),
          ),
          Expanded(child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: AppConstants.singleBorderRadius, topLeft: AppConstants.singleBorderRadius),
              color: Colors.white
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                customTextField(true),
                const SizedBox(height: 20,),
                customTextField(false),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(),
                    Text('Şifreni mi unuttun?', style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                const SizedBox(height: 50,),
                const ColoredButtonWidget(type: ColoredButtonEnums.login),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Hesabın yok mu?'),
                    const SizedBox(width: 5,),
                    Text('Kayıt ol.', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),)
                  ],
                )

              ],
            ),
          ))
        ],
      ),

    );
  }

  Container customTextField(bool isEmail) {
    return Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 25),
                    child: TextField(
                      obscuringCharacter: '●',
                      obscureText: !isEmail,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: (isEmail) ? "Email" : "Şifre",
                        prefixIcon: (isEmail) ? const Icon(Icons.email_outlined) : const Icon(Icons.lock_outline),
                      ),
                    ),
                  ),
                ),
              );
  }
}
