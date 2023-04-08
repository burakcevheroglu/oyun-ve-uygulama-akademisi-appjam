import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/dashboard_page.dart';
import 'package:oyunveuygulamaakademisi/profile_page.dart';
import 'package:oyunveuygulamaakademisi/services/provider.dart';

import '../const.dart';

class AppBottomNavigationBar extends ConsumerWidget {
  const AppBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomNavigationBar(
      borderRadius: const Radius.circular(100),
      iconSize: 30.0,
      selectedColor: Colors.white,
      strokeColor: const Color(0x30040307),
      unSelectedColor: Colors.white.withAlpha(150),
      backgroundColor: AppColors.blue,
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.home),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.stacked_bar_chart_outlined),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
        ),
      ],
      currentIndex: ref.watch(navigationIndex),
      onTap: (index) {
        if(ref.read(navigationIndex) == index) return;
        ref.read(navigationIndex.notifier).update((state) => index);
        if(index==0) Get.offAll(const DashboardPage());
        if(index==1);
        if(index==2) Get.to(() => const ProfilePage());
      },
    );
  }
}