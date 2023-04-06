import 'package:flutter/material.dart';
import 'package:oyunveuygulamaakademisi/const.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            monthlySumWidget(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Teknoloji Girişimciliği',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 10,),
                  girisimcilikWidget(title: "Girişimcilik", percent: 100, image: AppImages.girisimcilik, color: AppColors.yellow),
                  girisimcilikWidget(title: "Hukuk", percent: 70, image: AppImages.hukuk, color: AppColors.red),
                  girisimcilikWidget(title: "İnsan Kaynakları Eğitimleri", percent: 70, image: AppImages.insankaynaklari, color: AppColors.green),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container monthlySumWidget() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: AppConstants.borderRadius, color: AppColors.blue),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: .75,
                  strokeWidth: 10,
                  color: AppColors.yellow,
                  backgroundColor: AppColors.grey,
                ),
              ),
              const Text(
                '75%',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Text(
                  "Mart Ayı Bitiyor!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Text(
                  'Mart ayı görevlerini tamamlamana çok az kaldı!',
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      centerTitle: false,
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
                image: AssetImage(AppImages.userPicture))),
      ),
      title: Row(
        children: const [
          Text(
            'Selam, ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Burak',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
      actions: const [
        Icon(Icons.notifications_none_outlined),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class girisimcilikWidget extends StatelessWidget {
  const girisimcilikWidget({
    super.key, required this.title, required this.percent, required this.image, required this.color,
  });

  final String title;
  final int percent;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(5) + const EdgeInsets.only(right: 10),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppConstants.borderRadius,
          boxShadow: const [BoxShadow(
            blurRadius: 10,
            spreadRadius: -5,
            offset: Offset(0,4)
          )]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image)
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15,),
                  Text('Tamamlanan: $percent%', style: const TextStyle(fontSize: 12),),
                  const SizedBox(height: 5,),
                  Container(
                    width: double.infinity,
                    height: 8,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: percent ,child: Container(color: color,)),
                        Expanded(flex: (100-percent) ,child: Container(color: AppColors.grey,)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
