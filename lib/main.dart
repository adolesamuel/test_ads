import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/ad_helper.dart';
import 'package:test_ads/page_with_banner_ad.dart';
import 'package:test_ads/page_with_interstitial_ad.dart';
import 'package:test_ads/page_with_native_ad.dart';
import 'package:test_ads/page_with_rewarded_ad.dart';

void main() {
  runApp(MyApp());
}
//always update manifest and info.plst, check tutorial 4 on link
//https://codelabs.developers.google.com/codelabs/admob-inline-ads-in-flutter#3

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  tileColor: Colors.yellow,
                  title: Text('Banner Ad Page'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            BannerAdPage(title: 'Banner Ad')));
                  },
                ),
                ListTile(
                  tileColor: Colors.blue,
                  title: Text('Interstitial Ads Page'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            InterStitialAdPage(title: 'InterStitial Ad')));
                  },
                ),
                ListTile(
                  tileColor: Colors.red,
                  title: Text('Rewarded Ad Page'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RewardedAdPage(title: 'Rewarded Ad')));
                  },
                ),
                ListTile(
                    tileColor: Colors.purple,
                    title: Text('Native Inline'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              NativeInlineAdPage(title: 'Native Inline Ad')));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
