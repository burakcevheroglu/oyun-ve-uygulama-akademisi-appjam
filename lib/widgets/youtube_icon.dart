import 'package:flutter/material.dart';

Container youtubeIcon() {
  return Container(
    width: 35,
    height: 25,
    decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5)
    ),
    child: Center(child: Icon(Icons.play_arrow, color: Colors.white, size: 20,),),
  );
}