import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/services/provider.dart';
import 'package:oyunveuygulamaakademisi/widgets/colored_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30,),
        ),
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
                      image: AssetImage(AppImages.logo),
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
                customTextField(Icons.phone, "Telefon Numarası"),
                const SizedBox(height: 40,),
                const ColoredButtonWidget(type: ColoredButtonEnums.login),
                const SizedBox(height: 20,),
                const Text('Hesabın yok mu?'),
                const SizedBox(width: 5,),
                Text('Kayıt olmak için devam et', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),)

              ],
            ),
          ))
        ],
      ),

    );
  }

  Container customTextField(IconData icon, String title) {
    return Container(
                width: double.infinity,
                height: 65,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20,),
                    const SizedBox(
                      height: 65,
                      child: Center(child: Text("+90", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 25),
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            //obscuringCharacter: '●',
                            //obscureText: !isEmail,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: title, //(isEmail) ? "Email" : "Şifre",
                              //prefixIcon: Icon(icon)//(isEmail) ? const Icon(Icons.email_outlined) : const Icon(Icons.lock_outline),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
