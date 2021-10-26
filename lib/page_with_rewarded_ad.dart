import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads/ad_helper.dart';

class RewardedAdPage extends StatefulWidget {
  final String title;
  const RewardedAdPage({Key? key, required this.title}) : super(key: key);

  @override
  _RewardedAdPageState createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<RewardedAdPage> {
  late RewardedAd _rewardedAd;

  bool _isRewardedAdReady = false;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this._rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  @override
  void dispose() {
    _rewardedAd.dispose();

    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter <= 6 ? _counter++ : _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  _loadRewardedAd();

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
      floatingActionButton: _isRewardedAdReady
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Need a hint?'),
                      content: Text('Watch an Ad to get a hint!'),
                      actions: [
                        TextButton(
                          child: Text('cancel'.toUpperCase()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('ok'.toUpperCase()),
                          onPressed: () {
                            Navigator.pop(context);
                            _rewardedAd.show(onUserEarnedReward: (ad, reward) {
                              final snackbar = SnackBar(
                                  backgroundColor: Colors.yellow,
                                  duration: Duration(minutes: 1),
                                  action: SnackBarAction(
                                    label: 'Dismiss',
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  content: Text(
                                    'You got Reward!',
                                    style: TextStyle(color: Colors.blue),
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              label: Text('Hint'),
              icon: Icon(Icons.card_giftcard),
            )
          : null,
    );
  }
}
