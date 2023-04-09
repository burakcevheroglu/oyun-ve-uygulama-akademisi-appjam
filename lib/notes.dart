import 'package:flutter/material.dart';

import 'add_note.dart';
import 'lib/add_note.dart';

class not extends StatefulWidget {
  final String? a;
  final String? b;
  final String? c;
  not({this.a, this.b, this.c});

  @override
  State<not> createState() => _notState();
}

class _notState extends State<not> {
  List<String> isimSoyisim = ['A','B'];
  List<String> konular = ['c','d'];
  List<String> linkler = ['e','f'];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: isimSoyisim.length,
        itemBuilder: (BuildContext context,int index) {
          return Container(
            height: 50,
            color: Colors.amber,
            child: Center(
                child: Text('Ad: ${isimSoyisim[index]}\nKonu: ${konular[index]}\nlinkler: ${linkler[index]}')
            ),
          );
        },
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => notYazma()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
