import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/ad_helper.dart';

class NativeInlineAdPage extends StatefulWidget {
  final String title;
  const NativeInlineAdPage({Key? key, required this.title}) : super(key: key);

  @override
  _NativeInlineAdPageState createState() => _NativeInlineAdPageState();
}

class _NativeInlineAdPageState extends State<NativeInlineAdPage> {
  static final _kAdIndex = 4;

  late NativeAd _ad;

  bool _isAdLoaded = false;

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_isAdLoaded)
          Container(
            child: AdWidget(ad: _ad),
            height: 72.0,
            alignment: Alignment.center,
          ),
      ],
    ));
  }
}
