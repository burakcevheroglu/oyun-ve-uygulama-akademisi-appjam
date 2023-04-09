import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/all_qanda_page.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:oyunveuygulamaakademisi/widgets/alert.dart';

class QAndAPage extends StatefulWidget {
  const QAndAPage({Key? key, required this.userName, required this.documentId, required this.showOldList}) : super(key: key);

  final String userName;
  final String documentId;
  final bool showOldList;

  @override
  State<QAndAPage> createState() => _QAndAPageState();
}

class _QAndAPageState extends State<QAndAPage> {
  final TextEditingController _textController = TextEditingController();
  String? title;
  String? time;
  String? date;

  Future<DocumentSnapshot> getDocument(String documentId) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('questionandanswer')
        .doc(documentId);

    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot;
  }

  Future<void> _addComment(String userName) async {
    String text = _textController.text;

    await FirebaseFirestore.instance
        .collection('questionandanswer')
        .doc(widget.documentId)
        .collection('comments')
        .add({
      'name': userName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _textController.clear();
  }

  @override
  void initState() {
    super.initState();

    getDocument(widget.documentId).then((value) {
      setState(() {
        title = value['title'];
        time = value['time'];
        date = value['date'].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: const Text("Soru Tahtası"),
        actions: (widget.showOldList) ? [
          IconButton(onPressed: () => Get.to(() => AllQAndAPage(userName: widget.userName,)), icon: const Icon(Icons.list, size: 30,)),
          const SizedBox(width: 10,),
        ] : []
      ),
      body: Column(
        children: [
          eventInformation(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      AddQuestionWidget(
                        controller: _textController,
                        func: () {
                          if(_textController.text != ""){
                            _addComment(widget.userName);
                            showSnackbar(context, "Tebrikler, sorun başarıyla gönderildi!");
                          }
                          else{
                            showSnackbar(context, "Lütfen bir soru yazıp tekrar dene");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Sorular",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('questionandanswer')
                            .doc(widget.documentId)
                            .collection('comments')
                            .orderBy('timestamp', descending: true) // Burada sıralamayı belirtiyoruz
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (snapshot.data!.docs.isNotEmpty) ? snapshot.data!.docs.length : 1,
                            itemBuilder: (context, index) {
                              if(snapshot.data!.docs.isEmpty){
                                return Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: AppConstants.borderRadius
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text("Upps! Burada hiç soru yok. :(", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                        SizedBox(height: 10,),
                                        Text('Hemen bir soru eklemeye ne dersin?')
                                      ],
                                    ),
                                  ),
                                );
                              }
                              DocumentSnapshot comment = snapshot.data!.docs[index];
                              Timestamp? ts = comment['timestamp'];
                              return CommentWidget(name: comment['name'], text: comment['text'], timestamp: ts,);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget eventInformation() {
    return Column(
      children: [
        Text(
          title ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Icon(Icons.watch_later_outlined),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  time ?? '',
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
                  date ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.name,
    required this.text, required this.timestamp,
  });

  final String name;
  final String text;
  final Timestamp? timestamp;

  @override
  Widget build(BuildContext context) {
    String date = "";
    print("ts: $timestamp");
    if (timestamp != null) {
      // timestamp değeri null değilse, zaman farkını hesapla
      int unixTimestamp = timestamp!.seconds;
      date = _timeDifference(unixTimestamp);
    }
    else{
      print("asadsadsada");
    }



    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: AppConstants.borderRadius, color: AppColors.green),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    child: Text(name.substring(0, 1).toUpperCase()),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
                const SizedBox(width: 10,),
                SizedBox(width: 100,child: Text(date, style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(200)),))

              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white.withAlpha(220),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddQuestionWidget extends StatelessWidget {
  const AddQuestionWidget(
      {super.key, required this.controller, required this.func});

  final TextEditingController controller;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: AppConstants.borderRadius),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.insert_comment_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Soru ekle",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              autocorrect: false,
              controller: controller,
              maxLines: 2,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.all(10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Sorunuzu buraya yazın',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                func();
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: AppConstants.borderRadius,
                    color: AppColors.blue),
                child: const Center(
                  child: Text(
                    "Soruyu gönder",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


String _timeDifference(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var now = DateTime.now();
  var difference = now.difference(date);

  if (difference.inDays > 1) {
    return '${difference.inDays} gün önce';
  } else if (difference.inDays == 1) {
    return '1 gün önce';
  } else if (difference.inHours > 1) {
    return '${difference.inHours} saat önce';
  } else if (difference.inHours == 1) {
    return '1 saat önce';
  } else if (difference.inMinutes > 1) {
    return '${difference.inMinutes} dakika önce';
  } else if (difference.inMinutes == 1) {
    return '1 dakika önce';
  } else {
    return 'Birkaç saniye önce';
  }
}