import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:oyunveuygulamaakademisi/dashboard_page.dart';
import 'package:oyunveuygulamaakademisi/intro_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _initOneSignal();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: primarySwatchBlue
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme()
      ).copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle.dark
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return const DashboardPage();
          } else {
            return const IntroPage();
          }
        },
      ),
    );
  }
}

MaterialColor primarySwatchBlue = MaterialColor(_bluePrimaryValue, <int, Color>{
  50: Color(_bluePrimaryValue).withOpacity(0.1),
  100: Color(_bluePrimaryValue).withOpacity(0.2),
  200: Color(_bluePrimaryValue).withOpacity(0.3),
  300: Color(_bluePrimaryValue).withOpacity(0.4),
  400: Color(_bluePrimaryValue).withOpacity(0.5),
  500: Color(_bluePrimaryValue).withOpacity(0.6),
  600: Color(_bluePrimaryValue).withOpacity(0.7),
  700: Color(_bluePrimaryValue).withOpacity(0.8),
  800: Color(_bluePrimaryValue).withOpacity(0.9),
  900: Color(_bluePrimaryValue).withOpacity(1.0),
});

int _bluePrimaryValue = 0xFF4283F1;

void _initOneSignal() async {
  await OneSignal.shared.setAppId("b2b6aef0-5b19-44a8-badc-624ed9a51108");
  await OneSignal.shared.promptUserForPushNotificationPermission();
}