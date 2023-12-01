
import 'package:learn_banking_finance/ad_loader/ad_loader.dart';

import '../google_ads/ad_helper.dart';
import '../utils/debug.dart';

class AdLoaderMediation {
  static interMediation(Function onLoad) {
    if (Debug.adType == Debug.adGoogleType) {
      if (Debug.isAdxEnable) {
        AdLoader.interAdGoogleAdx(() {}, () {
          AdLoader.interAdGoogle(() {}, () {
            AdLoader.interAdFacebook(() {}, () {}, () {
              onLoad.call();
            });
          }, () {
            onLoad.call();
          });
        }, () {
          onLoad.call();
        });
      } else {
        AdLoader.interAdGoogle(() {}, () {
          AdLoader.interAdGoogleAdx(() {}, () {
            AdLoader.interAdFacebook(() {}, () {}, () {
              onLoad.call();
            });
          }, () {
            onLoad.call();
          });
        }, () {
          onLoad.call();
        });
      }
    } else if (Debug.adType == Debug.adFacebookType) {
      AdLoader.interAdFacebook(() {}, () {
        if (Debug.isAdxEnable) {
          AdLoader.interAdGoogleAdx(() {}, () {}, () {
            onLoad.call();
          });
        } else {
          AdLoader.interAdGoogle(() {}, () {}, () {
            onLoad.call();
          });
        }
      }, () {
        onLoad.call();
      });
    } else {
      onLoad.call();
    }
  }
  static interCountMediation(Function onLoad) {
    if (Debug.adType == Debug.adGoogleType) {
      if (Debug.isAdxEnable) {
        AdLoader.interAdCountGoogleAdx(() {}, () {
          AdLoader.interAdCountGoogle(() {}, () {
            AdLoader.interAdCountFacebook(() {}, () {}, () {
              onLoad.call();
            });
          }, () {
            onLoad.call();
          });
        }, () {
          onLoad.call();
        });
      } else {
        AdLoader.interAdCountGoogle(() {}, () {
          AdLoader.interAdCountGoogleAdx(() {}, () {
            AdLoader.interAdCountFacebook(() {}, () {}, () {
              onLoad.call();
            });
          }, () {
            onLoad.call();
          });
        }, () {
          onLoad.call();
        });
      }
    } else if (Debug.adType == Debug.adFacebookType) {
      AdLoader.interAdCountFacebook(() {}, () {
        if (Debug.isAdxEnable) {
          AdLoader.interAdCountGoogleAdx(() {}, () {}, () {
            onLoad.call();
          });
        } else {
          AdLoader.interAdCountGoogle(() {}, () {}, () {
            onLoad.call();
          });
        }
      }, () {
        onLoad.call();
      });
    } else {
      onLoad.call();
    }
  }
}