import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/webview_page.dart';

class ImportantLinks extends StatelessWidget {
  const ImportantLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text("Önemli Linkler"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('links').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final links = snapshot.data!.docs;
          return ListView.builder(
            itemCount: links.length,
            itemBuilder: (BuildContext context, int index) {
              final link = links[index];
              final data = link.data() as Map<String, dynamic>;
              return ListTile(
                onTap: () => Get.to(() => WebviewPage(title: data['title'], url: data['link'])),
                leading: const Icon(Icons.link),
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['link'] ?? ''),
              );
            },
          );
        },
      ),
    );
  }
}
