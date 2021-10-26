package com.example.test_ads

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

   override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

       
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "listTile", ListTileNativeAdFactory(context))
    } 

      override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
    }
}
