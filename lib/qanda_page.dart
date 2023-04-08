import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';

class QAndAPage extends StatelessWidget {
  const QAndAPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text("Soru Tahtası"),
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
                    children: const [
                      addQuestionWidget(),
                      SizedBox(height: 20,),
                      CommentWidget(),
                      CommentWidget(),
                      CommentWidget(),
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

  Column eventInformation() {
    return Column(
          children: [
            const Text("Unity Soru Cevap Buluşması - 3", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: const [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 5,),
                    Text("20:00", style: TextStyle(fontSize: 16),),
                  ],
                ),
                const SizedBox(width: 20,),
                Row(
                  children: const [
                    Icon(Icons.date_range_outlined),
                    SizedBox(width: 5,),
                    Text("2023-03-21", style: TextStyle(fontSize: 16),),
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppConstants.borderRadius,
        color: AppColors.green
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(child: Text("B"),),
                ),
                SizedBox(width: 10,),
                Expanded(child: Text("Burak Taha Cevheroğlu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
              ],
            ),
            const SizedBox(height: 10,),
            Text("Benim sorum Türkiye'deki oyun sektöründeki duraksama hakkında olacak bu duraksamanın sebebi nedir ne zaman kadar sürer? şimdiden teşekkür ederim.", style: TextStyle(color: Colors.white.withAlpha(220),),)
          ],
        ),
      ),
    );
  }
}

class addQuestionWidget extends StatelessWidget {
  const addQuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: AppConstants.borderRadius
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.insert_comment_outlined),
                SizedBox(width: 10,),
                Text("Soru ekle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height: 10,),
            TextField(
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
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: AppConstants.borderRadius,
                color: AppColors.blue
              ),
              child: const Center(child: Text("Soruyu gönder", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),),
            )
          ],
        ),
      ),
    );
  }
}
