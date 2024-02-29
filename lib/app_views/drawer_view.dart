import 'package:flutter/material.dart';
import 'package:mosque_raw/app_data/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/colors.dart';
import 'home.dart';


class DrawerView extends StatefulWidget {

  final String url;
  final String title;

  const DrawerView({super.key,required this.url, required this.title});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: MyColors.darkGreen,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w600,letterSpacing: 1.5),),
      ),

      body: WebViewData(controller: controller,),
    );
  }
}
