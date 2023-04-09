import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/dashboard_page.dart';
import 'package:oyunveuygulamaakademisi/register_config_page.dart';
import 'package:oyunveuygulamaakademisi/services/firebase_preferences.dart';
import 'package:oyunveuygulamaakademisi/services/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/phoneauth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Telefonunu Doğrula",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Lütfen telefonuna gönderdiğimiz doğrulama kodunu aşağıdaki alana gir",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              OTPTextField(
                controller: phoneCodeController,
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: MediaQuery.of(context).size.width/10,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  smsCode = pin;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Telefonuna kod gelmedi mi?"),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Text(
                  "TEKRAR GÖNDER",
                  style: TextStyle(color: AppColors.red),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextButton(
                  onPressed: () async {
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifyId, smsCode: smsCode);
                    try {
                      await _auth.signInWithCredential(credential).then((value) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Giriş Başarılı!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        final String userId = FirebaseAuth.instance.currentUser!.uid;
                        final DocumentSnapshot ouaDoc = await FirebaseFirestore.instance.collection('oua').doc(userId).get();

                        if (ouaDoc.exists) {
                          firebaseToShared();
                          Get.offAll(const DashboardPage());
                        } else {
                          Get.offAll(const RegisterConfig());
                        }
                      });
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(AppColors.lightRed),
                  ),
                  child: const Center(
                      child: Text(
                    'Doğrula',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
