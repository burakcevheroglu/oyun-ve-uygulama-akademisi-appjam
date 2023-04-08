import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> firebaseToShared() async {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final DocumentSnapshot ouaDoc = await FirebaseFirestore.instance.collection('oua').doc(userId).get();

  // Firestoredan verileri çek
  final String phoneNo = ouaDoc.get('phoneNumber');
  final String name = ouaDoc.get('name');
  final String surname = ouaDoc.get('surname');
  final bool isFieldFlutter = ouaDoc.get('isFieldFlutter');
  final bool isEnglish = ouaDoc.get('english');

  // Firestore'dan verileri aldıktan sonra burada sakla
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('phoneNumber', phoneNo);
  prefs.setString('name', name);
  prefs.setString('surname', surname);
  prefs.setBool('isFieldFlutter', isFieldFlutter);
  prefs.setBool('english', isEnglish);
}

