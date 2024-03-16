import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klein/app_views/home.dart';
import 'package:klein/app_views/splash_screen.dart';
import 'package:klein/utils/app_urls.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/life_cycle.dart';


class MainScreen extends StatefulWidget {
  
  final int tabIndex;
  final bool showHide;

  const MainScreen({super.key, required this.tabIndex, required this.showHide});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late PersistentTabController _controller;
  bool showSplash = true;
  int selectedIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), () {
      setState(() {
        showSplash = false;
      });
    });

    _controller = PersistentTabController(initialIndex: widget.tabIndex,);
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          // do something
          _controller = PersistentTabController(initialIndex: 2);
        }))
    );
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      bottom: false,
        top: false,
        child: Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                PersistentTabView(
                  context,
                  controller: _controller,
                  screens: _buildScreen(),
                  items: _navBarItem(),
                  onItemSelected: _onItemTapped,
                  backgroundColor: Colors.white,
                  decoration: NavBarDecoration(
                      borderRadius: BorderRadius.circular(1)
                  ),
                  navBarStyle: NavBarStyle.style3,
                  handleAndroidBackButtonPress: true,
                  stateManagement: true,
                  popActionScreens: PopActionScreensType.all,
                  popAllScreensOnTapOfSelectedTab: true,
                  popAllScreensOnTapAnyTabs: true,
                  onWillPop: (final context) async {
                    _goBack(context!);
                    return false;
                  },
                ),
                if(showSplash) widget.showHide == true ? SplashScreen():SizedBox(),
              ],
            ),
          ),
        );
  }

  List<PersistentBottomNavBarItem> _navBarItem(){

    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.feed),
          activeColorPrimary: Colors.black,
          inactiveIcon: Icon(Icons.feed_outlined),
          title: 'Salah'
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.event_note),
          activeColorPrimary: Colors.black,
          inactiveIcon: Icon(Icons.event_note_outlined),
          title: 'Events'
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
          activeColorPrimary: Colors.black,
          inactiveIcon: Icon(Icons.home_outlined),
          title: 'Home'
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.perm_media),
          activeColorPrimary: Colors.black,
          inactiveIcon: Icon(Icons.perm_media_outlined),
          title: 'Videos'
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.monetization_on),
          activeColorPrimary: Colors.black,
          inactiveIcon: Icon(Icons.monetization_on_outlined),
          title: 'Assist'
      ),
    ];

  }

  List<Widget> _buildScreen() => [
    Home(url: AppUrl.news, ), Home(url: AppUrl.events,),
    Home(url: AppUrl.home, ), Home(url: AppUrl.videos,),
    Home(url: AppUrl.home, ),
    ];


  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainScreen(tabIndex: index, showHide: false,)),(route) => false);
      pushNewScreen(
        context,
        screen: MainScreen(tabIndex: index==4? 2:index,showHide: false,),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.fade,
      );
    });

    if (index == 4) {
      _launchURL(AppUrl.donateAssist);
      setState(() {
        _controller = PersistentTabController(initialIndex: 2);
      });
    }

    if (index == 0) {
      setState(() {

      });
    }

    if (index == 1) {
      setState(() {
        //Home(url: AppUrl.events, );
      });
    }

    if (index == 2) {
      setState(() {
        //Home(url: AppUrl.home, );
      });
    }

    if (index == 3) {
      setState(() {
        //Home(url: AppUrl.videos,);
      });
    }

  }

  Future<bool> _goBack(BuildContext context) async {
      if(mounted) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Do you want to exit from Klein Centre ?'),
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
