package com.example.spotify_flutter_code

import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.example.spotify_flutter_code.nativeBanner.ListTileNativeAdBanner
import com.example.spotify_flutter_code.nativeBanner.ListTileNativeAdBannerNight
import com.example.spotify_flutter_code.nativeNormal.ListTileNativeAdFactory
import com.example.spotify_flutter_code.nativeNormal.ListTileNativeAdFactoryNight
import com.example.spotify_flutter_code.smallNative.ListTileNativeAdFactorySmall
import com.example.spotify_flutter_code.smallNative.ListTileNativeAdFactorySmallNight
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(window, false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            Log.e("TAG", "onCreate: splshs screen....." );
            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }

        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile", ListTileNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileNight", ListTileNativeAdFactoryNight(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileSmall", ListTileNativeAdFactorySmall(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileSmallNight", ListTileNativeAdFactorySmallNight(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileBanner", ListTileNativeAdBanner(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileBannerNight", ListTileNativeAdBannerNight(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileNight")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileSmall")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileSmallNight")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileBanner")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileBannerNight")
    }
}
