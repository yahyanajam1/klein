import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/colors.dart';

class WebViewData extends StatefulWidget {

  final WebViewController controller;

  const WebViewData({super.key,required this.controller});

  @override
  State<WebViewData> createState() => _WebViewDataState();
}

class _WebViewDataState extends State<WebViewData> {

  var loadingPercent = 0;

  bool hide = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.controller..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url){
          setState(() {
            loadingPercent = 0;
          });
        },
        onProgress: (progress){
          setState(() {
            loadingPercent = progress;
          });
          },
        onPageFinished: (url){
          setState(() {
            loadingPercent = 100;
          });
        },

        onWebResourceError: (WebResourceError error){
          debugPrint("hello this ${error.description}");
          setState(() {
            hide = true;
          });
        },
        onNavigationRequest: (NavigationRequest request){
          if(request.url.startsWith("https://kleinislamiccenter.site/klein")){
            return NavigationDecision.navigate;
          } else {
              _launchURL(request.url);
            return NavigationDecision.prevent;
          }
        },

        onUrlChange: (UrlChange change){
          debugPrint("CHANGE URL IS THIS ${change.url!}");
          if(!change.url!.startsWith("https://kleinislamiccenter.site/klein")){
            hide = true;
            _launchURL(change.url!);
          }
        },

      ),

    )..setJavaScriptMode(JavaScriptMode.unrestricted)..addJavaScriptChannel("SnackBar", onMessageReceived: (message){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
    });

    widget.controller.enableZoom(false);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
         hide == false ? WebViewWidget(controller: widget.controller,):alertContainer(),
          if(loadingPercent<80)
            LinearProgressIndicator(
              value: loadingPercent/100.0,
              color: Colors.black,
            ),
          if(loadingPercent<80)
            Container(color: Colors.white,),
          if(loadingPercent<80)
            Center(
              child: SpinKitCircle(
              size: 60,
              color: Colors.black,
              ),
            ),

        ],
      ),
    );
  }

  Widget alertContainer(){

    return Container(
      color:MyColors.whiteTwo.withOpacity(0.4),
      child: Container(
          margin: EdgeInsets.only(top:16,bottom: 16,left: 12,right: 12),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white
          ),
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: MyColors.whiteTwo.withOpacity(0.4),width: 6)
              ),
              child: hide==false?Text('An issue has occurred\nplease refresh or try again !',textAlign: TextAlign.center,style: TextStyle(fontSize: 16 ,color: Colors.black,fontWeight: FontWeight.w500,),):
              Text(' Klein Center says\nan issue has occurred !',textAlign: TextAlign.center,style: TextStyle(fontSize: 16 ,color: Colors.black,fontWeight: FontWeight.w500,),))),
    );

  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

}
