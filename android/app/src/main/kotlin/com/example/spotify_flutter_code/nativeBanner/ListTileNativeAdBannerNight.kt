package com.example.spotify_flutter_code.nativeBanner
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
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class ListTileNativeAdBannerNight(private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
            nativeAd: NativeAd,
            customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
                .inflate(R.layout.native_banner_ad_night, null) as NativeAdView

        with(nativeAdView) {
            var callToActionView: Button? = null
            callToActionView = findViewById<View>(R.id.cta_banner) as Button
            val cta = nativeAd.callToAction
            if(cta != "") {
                callToActionView.text = cta
            }else{
                callToActionView.text = "INSTALL"
            }

            val ratingBar: RatingBar? = null
            val starRating = nativeAd.starRating
            var secondaryView: TextView? = null
            val store = nativeAd.store
            val advertiser = nativeAd.advertiser

            secondaryView = findViewById<View>(R.id.secondary_banner) as TextView
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
                ratingBar?.visibility = View.GONE
            }
            secondaryView.text = secondaryText
            secondaryView.visibility = View.VISIBLE

            var primaryView: TextView? = null
            primaryView = findViewById<View>(R.id.primary_banner) as TextView
            val headline = nativeAd.headline
            primaryView.text = headline

            var iconView: ImageView? = null
            iconView = findViewById<ImageView>(R.id.icon_banner)

            val icon = nativeAd.icon
            if (icon != null) {
                iconView?.setImageDrawable(icon.drawable)
            }
            this.iconView = iconView


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