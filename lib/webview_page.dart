import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyunveuygulamaakademisi/const.dart';
import 'package:webview_flutter/webview_flutter.dart';


double _progress = 0;

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key, required this.title,required this.url}) : super(key: key);

  final String title;
  final String url;

  @override
  State<WebviewPage> createState() => _HomePageState();
}

class _HomePageState extends State<WebviewPage> {

  late WebViewController controller;


  @override
  void initState() {
    controller = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              _progress = progress.toDouble();
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(await controller.canGoBack()){
          controller.goBack();
          return false;
        }
        else{
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close, size: 30,),
            ),
            title: Text(widget.title),
          ),
          body: SafeArea(child: Stack(
            children: [
              LinearProgressIndicator(value: _progress/100, color: AppColors.blue,),
              WebViewWidget(controller: controller,)
            ],
          ))
      ),
    );
  }
}