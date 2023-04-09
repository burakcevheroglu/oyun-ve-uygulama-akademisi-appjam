import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../menu_page.dart';

IconButton profileLeadingButton(bool isButtonBack) {
  if (isButtonBack) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.chevron_left,
        size: 30,
        color: Colors.black,
      ),
    );
  } else {
    return IconButton(
      onPressed: () => Get.to(() => const MenuPage(),
          transition: Transition.leftToRightWithFade, fullscreenDialog: true),
      icon: const Icon(
        Icons.menu,
        size: 30,
        color: Colors.black,
      ),
    );
  }
}