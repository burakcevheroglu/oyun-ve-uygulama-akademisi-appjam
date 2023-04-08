import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp_text_field/otp_field.dart';

final navigationIndex = StateProvider<int>((ref) => 0);
final TextEditingController phoneController = TextEditingController();
final OtpFieldController phoneCodeController = OtpFieldController();
