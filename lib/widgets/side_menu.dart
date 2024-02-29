import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mosque_raw/app_views/home.dart';
import 'package:mosque_raw/utils/app_urls.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_views/drawer_view.dart';
import '../utils/colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: MyColors.darkGreen,
            ),
              child: Container(
              padding: EdgeInsets.all(28),
              child: Image.asset('assets/klein_logo.png',fit: BoxFit.contain,),)
          ),
          /*
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
            onTap: () => {
              // Navigator.pushReplacement(
              //   context,
              //   //MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 1)),
              // ),
            },
          ),
          */
          ListTile(
            leading: Icon(CupertinoIcons.money_dollar_circle),
            title: Text('Masjid Support'),
            onTap: () => {
              _launchURL(AppUrl.donateAssist)
            },
          ),

          ListTile(
            leading: Icon(CupertinoIcons.person_2),
            title: Text('Masjid Imam'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context,MaterialPageRoute(builder: (context) => DrawerView(url: AppUrl.ourImams, title: 'Masjid Imams',)))

            },
          ),

          ListTile(
            leading: Icon(CupertinoIcons.briefcase),
            title: Text('Services'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context,MaterialPageRoute(builder: (context) => DrawerView(url: AppUrl.services, title: 'Services',)))
            },
          ),

          /*
          ListTile(
            leading: Icon(CupertinoIcons.person_3),
            title: Text('Masjid Team'),
            onTap: () => {
              PersistentNavBarNavigator.pushNewScreen(
                context,screen: Home(url: AppUrl.masjidTeam,),
                pageTransitionAnimation: PageTransitionAnimation.fade,)

            },
          ),
          */

          /*
          ListTile(
            leading: Icon(CupertinoIcons.bubble_left_bubble_right),
            title: Text('Feedback'),
            onTap: () => {
              PersistentNavBarNavigator.pushNewScreen(
                context,screen: Home(url: AppUrl.feedback,),
                pageTransitionAnimation: PageTransitionAnimation.fade,)
            },
          ),

          ListTile(
            leading: Icon(CupertinoIcons.hand_point_right),
            title: Text('Volunteer'),
            onTap: () => {
              PersistentNavBarNavigator.pushNewScreen(
                context,screen: Home(url: AppUrl.volunteer,),
                pageTransitionAnimation: PageTransitionAnimation.fade,)
            },
          ),
          */

          /*
          ListTile(
            leading: Icon(CupertinoIcons.mail),
            title: Text('Email Subscription'),
            onTap: () => {
              PersistentNavBarNavigator.pushNewScreen(
                context,screen: Home(url: AppUrl.emailSubscription,),
                pageTransitionAnimation: PageTransitionAnimation.fade,)
            },
          ),
           */

          ListTile(
            leading: Icon(CupertinoIcons.doc_plaintext),
            title: Text('About us'),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context,MaterialPageRoute(builder: (context) => DrawerView(url: AppUrl.aboutUs, title: 'About Us',)))


            },
          ),

          Container(
            margin: EdgeInsets.only(top: 12,bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                        onTap: () async {
                          _launchFB(AppUrl.facebook);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.appYellow,
                              borderRadius: BorderRadius.circular(100),
                              shape: BoxShape.rectangle,
                              border: Border.all(color: MyColors.appYellow,width: 1.5),
                              boxShadow:[
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1,1),
                                    color: MyColors.appYellow.withOpacity(0.2))]
                          ),
                          child: CircleAvatar(
                            radius:14,
                            backgroundColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  "assets/facebook.png"
                              ),
                            ),
                          ),
                        ),
                      ),
                /*
                InkWell(
                        onTap: ()async{

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColors.appYellow,
                              borderRadius: BorderRadius.circular(100),
                              shape: BoxShape.rectangle,
                              border: Border.all(color: MyColors.appYellow,width: 1.5),
                              boxShadow:[
                                BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(1,1),
                                    color: MyColors.appYellow.withOpacity(0.2))]
                          ),
                          child: CircleAvatar(
                              radius:14,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                backgroundImage: AssetImage("assets/twitter.png"),
                              )
                          ),
                        ),
                      ),
                 */
                SizedBox(width: 32,),
                InkWell(
                    onTap: ()async{
                      _launchFB(AppUrl.youtube);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.appYellow,
                          borderRadius: BorderRadius.circular(100),
                          shape: BoxShape.rectangle,
                          border: Border.all(color: MyColors.appYellow,width: 1.5),
                          boxShadow:[
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1,1),
                                color: MyColors.appYellow.withOpacity(0.2))]
                      ),
                      child: CircleAvatar(
                          radius:14,
                          backgroundColor: Colors.transparent,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            backgroundImage: AssetImage("assets/youtube.png"),
                          )
                      ),
                    ),
                  ),
              ],
            ),
          ),

        ],
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

  _launchFB(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalNonBrowserApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

}
