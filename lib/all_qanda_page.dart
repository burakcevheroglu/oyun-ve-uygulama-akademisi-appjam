import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/qanda_page.dart';
import 'package:oyunveuygulamaakademisi/services/phoneauth.dart';
import 'package:oyunveuygulamaakademisi/widgets/leading_button.dart';

class AllQAndAPage extends StatelessWidget {
  const AllQAndAPage({Key? key, required this.isButtonBack}) : super(key: key);

  final bool isButtonBack;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: profileLeadingButton(isButtonBack),
        surfaceTintColor: Colors.transparent,
        title: const Text('Etkinlikler'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('questionandanswer')
            .orderBy('timestamp' , descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Bir hata oluştu.');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return eventInformation(
                document['title'],
                document['date'].toString(),
                document['time'],
                document.id
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget eventInformation(String title, String date, String time, String documentId) {
    return InkWell(
      onTap: () => Get.to(() => QAndAPage(userName: globalUserName, documentId: documentId, showOldList: false,)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.date_range_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        date,
                        style: const TextStyle(fontSize: 16),
                      ),
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
