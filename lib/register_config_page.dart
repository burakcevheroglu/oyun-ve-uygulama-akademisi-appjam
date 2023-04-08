import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/dashboard_page.dart';
import 'package:oyunveuygulamaakademisi/services/phoneauth.dart';
import 'package:oyunveuygulamaakademisi/widgets/alert.dart';
import 'package:oyunveuygulamaakademisi/widgets/custom_textfield.dart';

import 'const.dart';

TextEditingController _name = TextEditingController();
TextEditingController _surname = TextEditingController();
enum _ProgrammingLanguage { flutter, unity }

class RegisterConfig extends StatefulWidget {
  const RegisterConfig({Key? key}) : super(key: key);


  @override
  State<RegisterConfig> createState() => _RegisterConfigState();
}

class _RegisterConfigState extends State<RegisterConfig> {
  _ProgrammingLanguage _selectedLanguage = _ProgrammingLanguage.flutter;
  bool _wantEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text("Hoşgeldin!"),
      ),
      body: Column(
        children: [
          const Text("Aramıza hoşgeldin yeni akademili!"),
          const SizedBox(height: 10,),
          const Text("Sen eğitimlere geçmeden önce birkaç tercihini öğrenmemiz gerekiyor.", textAlign: TextAlign.center,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextfield(title: "İsmin", icon: Icons.person, controller: _name),
                    const SizedBox(height: 10,),
                    CustomTextfield(title: "Soyismin", icon: Icons.person, controller: _surname),
                    const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Flutter ile uygulama geliştirmek mi istersin yoksa Unity ile oyun geliştirmek mi?"),
                        ListTile(
                          title: const Text('Flutter ile uygulama'),
                          leading: Radio<_ProgrammingLanguage>(
                            value: _ProgrammingLanguage.flutter,
                            groupValue: _selectedLanguage,
                            onChanged: (_ProgrammingLanguage? value) {
                              setState(() {
                                _selectedLanguage = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Unity ile oyun'),
                          leading: Radio<_ProgrammingLanguage>(
                            value: _ProgrammingLanguage.unity,
                            groupValue: _selectedLanguage,
                            onChanged: (_ProgrammingLanguage? value) {
                              setState(() {
                                _selectedLanguage = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Yazılımcılar için İngilizce dersi almak ister misin? Eğer evet dersen tüm dersleri bitirmen gerekecek."),
                            ListTile(
                              title: const Text('Evet istiyorum'),
                              leading: Radio<bool>(
                                value: true,
                                groupValue: _wantEnglish,
                                onChanged: (value) {
                                  setState(() {
                                    _wantEnglish = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Hayır istemiyorum'),
                              leading: Radio<bool>(
                                value: false,
                                groupValue: _wantEnglish,
                                onChanged: (value) {
                                  setState(() {
                                    _wantEnglish = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 55,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextButton(
              onPressed: () async {
                final String userId = FirebaseAuth.instance.currentUser!.uid;
                final DocumentReference userDoc = FirebaseFirestore.instance.collection('oua').doc(userId);

                bool field = false;
                if(_selectedLanguage == _ProgrammingLanguage.flutter) field = true;

                String errors = validityCheck();

                print(errors);
                if(errors != ""){
                  showAlert(context, "Uyarı", errors);
                  return;
                }

                await userDoc.set({
                  'phoneNumber': "+90$phoneNumber",
                  'name': _name.text,
                  'surname': _surname.text,
                  'isFieldFlutter': field,
                  'english': _wantEnglish
                }, SetOptions(merge: true));

                // ignore: use_build_context_synchronously
                showSnackbar(context, "Tercihlerin başarıyla kaydedildi");
                Get.offAll(const DashboardPage());
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(AppColors.lightRed),
              ),
              child: const Center(
                  child: Text(
                    'Tercihlerimi Kaydet',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  String validityCheck() {
    String errors = "";
    if(_name.text == "") errors = "$errors\nİsmini girmelisin";
    if(_surname.text == "") errors = "$errors\nSoyismini girmelisin";

    return errors;
  }
}
