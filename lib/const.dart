import 'package:flutter/material.dart';

class AppColors{
  static Color get blue => const Color.fromARGB(255, 66, 131, 241);
  
  static Color get red => const Color.fromARGB(255, 232, 67, 53);
  static Color get lightRed => const Color.fromARGB(255, 249, 98, 83);
  
  
  static Color get yellow => const Color.fromARGB(255, 250, 188, 5);
  static Color get green => const Color.fromARGB(255, 60, 186, 84);
  static Color get grey => const Color.fromARGB(255, 245, 245, 245);
}

class AppConstants{
  static BorderRadius get borderRadius => BorderRadius.circular(20);
  static Radius get singleBorderRadius => const Radius.circular(20);

}

class AppImages{
  static String get logo => "assets/oyunveuygulamaakademisi.png";
  static String get userPicture => "assets/user.png";

  static String get code => "assets/lesson/code.png";
  static String get girisimcilik => "assets/lesson/girisimcilik.png";
  static String get hukuk => "assets/lesson/hukuk.png";
  static String get ingilizce => "assets/lesson/ingilizce.png";
  static String get oyunsanati => "assets/lesson/oyunsanati.png";
  static String get insankaynaklari => "assets/lesson/insankaynaklari.png";
}