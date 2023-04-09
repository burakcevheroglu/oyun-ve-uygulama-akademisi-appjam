import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'lib/add_note.dart';
import 'notes.dart';

class notYazma extends StatefulWidget {
  const notYazma({Key? key}) : super(key: key);

  @override
  State<notYazma> createState() => _notYazmaState();
}

class _notYazmaState extends State<notYazma> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late String ad;
  late String link;
  late String konu;
  @override
  void initState() {
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Not Paylaşma Ekranı',
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body:SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'images/homepage_img_8.png',
                  width: 200,
                  height: 250,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(
                    controller: controller1,
                    onChanged: (String isimSoyisim){
                      if(isimSoyisim.isNotEmpty){
                        setState(() {
                          ad = isimSoyisim;
                        });
                      }
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'isim soyisim',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(
                    controller: controller2,
                    onChanged: (String icerik){
                      if(icerik.isNotEmpty){
                        setState(() {
                          konu = icerik;
                        });
                      }
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'konu',
                    ),
                  ),
                ),
                SizedBox(height: 20 ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextField(
                    controller: controller3,
                    onChanged: (String id){
                      if(id.isNotEmpty){
                        setState(() {
                          link = id;
                        });
                      }
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'link',
                    ),
                  ),
                ),
                SizedBox(height: 20 ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(40, 40),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => not(
                        a: ad,
                        b:konu,
                        c:link
                    )));
                  },
                  child: Text(
                      'Yükle',
                      style: TextStyle(fontSize: 20)
                  ),
                )
              ],
            ),
          ),
        )

    );
  }
}
