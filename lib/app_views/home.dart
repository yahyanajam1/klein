import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klein/app_data/web_view.dart';
import 'package:klein/utils/app_urls.dart';
import 'package:klein/widgets/side_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/colors.dart';

class Home extends StatefulWidget {
  final String url;

  const Home({super.key, required this.url});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> _goBack(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: SideMenu(),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              );
            },
          ),
          title: SizedBox(
              width: 100,
              child: Image.asset('assets/klein_logo.png', fit: BoxFit.contain)),
          backgroundColor: MyColors.darkGreen,
          elevation: 4.0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 12,),
              height: 34,
              child: OutlinedButton(
                onPressed: (){
                  _launchURL(AppUrl.donateAssist);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.5, color: Colors.black),
                  backgroundColor: MyColors.appYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Donate", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              ),
            ),

          ],
        ),
        body: WebViewData(controller: controller,),
      ),
    );
  }



  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return Future.value(false);
    } else {
   if(mounted) {
     showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to exit from Foodrive?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ));
   }
      return Future.value(true);
    }
  }

}