package com.example.spotify_flutter_code.nativeNormal

import android.content.Context
import android.text.TextUtils
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.example.spotify_flutter_code.R
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class ListTileNativeAdFactory(val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
            nativeAd: NativeAd,
            customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
                .inflate(R.layout.normal_native_ad, null) as NativeAdView

        with(nativeAdView) {
            val body = nativeAd.body
            var tertiaryView: TextView? = null
            tertiaryView = findViewById<View>(R.id.body) as TextView
            tertiaryView.text = body
            nativeAdView.bodyView = tertiaryView

            var callToActionView: Button? = null
            callToActionView = findViewById<View>(R.id.cta) as Button
            val cta = nativeAd.callToAction
            if(cta != "") {
                callToActionView.text = cta
            }else{
                callToActionView.text = "INSTALL"
            }

            Log.e("TAG", "createNativeAd: cta button text===== $cta")

            var mediaView: MediaView? = null
            mediaView = findViewById<View>(R.id.media_view) as MediaView
            nativeAdView.mediaView = mediaView

            val ratingBar: RatingBar? = null
            val starRating = nativeAd.starRating
            var secondaryView: TextView? = null
            val store = nativeAd.store
            val advertiser = nativeAd.advertiser

            secondaryView = findViewById<View>(R.id.secondary) as TextView
            val secondaryText: String

            secondaryView.visibility = View.VISIBLE
            if (adHasOnlyStore(nativeAd)) {
                nativeAdView.storeView = secondaryView
                secondaryText = store.toString()
            } else if (!TextUtils.isEmpty(advertiser)) {
                nativeAdView.advertiserView = secondaryView
                secondaryText = advertiser.toString()
            } else {
                secondaryText = ""
            }
            Log.e("TAG", "createNativeAd:secondaryText... $secondaryText")
            //  Set the secondary view to be the star rating if available.
            if (starRating != null && starRating > 0) {
                secondaryView.visibility = View.GONE
                ratingBar?.visibility = View.GONE
                ratingBar?.rating = starRating.toFloat()
                nativeAdView.starRatingView = ratingBar
            } else {
                /*secondaryView.text = secondaryText
                secondaryView.visibility = View.VISIBLE*/
                ratingBar?.visibility = View.GONE
            }
            secondaryView.text = secondaryText
            secondaryView.visibility = View.VISIBLE

            var primaryView: TextView? = null
            primaryView = findViewById<View>(R.id.primary) as TextView
            val headline = nativeAd.headline
            primaryView.text = headline

            var iconView: ImageView? = null
            iconView = findViewById<ImageView>(R.id.icon)

//            val attributionViewSmall =
//                    findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_small)
//            val attributionViewLarge = findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_large)

//            val iconView = findViewById<ImageView>(R.id.iv_list_tile_native_ad_icon)
            val icon = nativeAd.icon
            if (icon != null) {
//                attributionViewSmall.visibility = View.VISIBLE
//                attributionViewLarge.visibility = View.INVISIBLE
                iconView?.setImageDrawable(icon.drawable)
            } else {
//                attributionViewSmall.visibility = View.INVISIBLE
//                attributionViewLarge.visibility = View.VISIBLE
            }
            this.iconView = iconView

//            val headlineView = findViewById<TextView>(R.id.tv_list_tile_native_ad_headline)
//            headlineView.text = nativeAd.headline
//            this.headlineView = headlineView

//            val bodyView = findViewById<TextView>(R.id.tv_list_tile_native_ad_body)
//            with(bodyView) {
//                text = nativeAd.body
//                visibility = if (nativeAd.body.isNullOrEmpty()) View.INVISIBLE else View.VISIBLE
//            }
            this.bodyView = bodyView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }

    private fun adHasOnlyStore(nativeAd: NativeAd): Boolean {
        val store = nativeAd.store
        val advertiser = nativeAd.advertiser
        return !TextUtils.isEmpty(store) && TextUtils.isEmpty(advertiser)
    }

}