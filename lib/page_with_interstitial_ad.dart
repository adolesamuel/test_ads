import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/ad_helper.dart';

///This page loads a counter example add that shows interstitial ads
/// when [_counter] is greater than 3
class InterStitialAdPage extends StatefulWidget {
  InterStitialAdPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InterStitialAdPageState createState() => _InterStitialAdPageState();
}

class _InterStitialAdPageState extends State<InterStitialAdPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    //if add is ready and counter>=3 show add else ...
    if (_isInterstitialAdReady && _counter >= 3) {
      _interstitialAd?.show();
    }
    setState(() {
      _counter <= 6 ? _counter++ : _counter = 0;
    });
  }

  InterstitialAd? _interstitialAd;

  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // Navigator.pop(context);
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_counter >= 3 || !_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
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
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
