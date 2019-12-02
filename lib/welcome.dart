import 'package:cest_pret_de_chez_vous/src/post_ads/view_model/post_ad_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './navigation/navigation.dart';
import './src/account_settings/view/login.dart';
import './src/account_settings/view/mail_validation.dart';
import './src/account_settings/view_model/login_view_model.dart';
import 'src/display_ads/view_model/ads_around_view_model.dart';
import 'src/display_ads/view_model/current_user_ads_view_model.dart';
import 'src/display_ads/view_model/favorite_ads_view_model.dart';

class Welcome extends StatelessWidget {
  getLoggedContent(data) {}

  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        Widget view;
        String uid;
        if (snapshot.data == null) {
          uid = null;
          view = Login();
        } else if (!snapshot.data.isEmailVerified) {
          uid = snapshot.data.uid;
          view = ValidationMail();
        } else {
          uid = snapshot.data.uid;
          view = MultiProvider(
            providers: [
              ChangeNotifierProvider(
                builder: (context) => AdsAroundViewModel(),
              ),
              ChangeNotifierProvider(
                builder: (context) => FavoriteAdsViewModel(uid),
              ),
              ChangeNotifierProvider(
                builder: (context) => CurrentUserAdsViewModel(uid),
              ),
              ChangeNotifierProvider(
                builder: (context) => PostAdViewModel(),
              )
            ],
            child: Tabs(),
          );
        }

        return ChangeNotifierProvider(
          builder: (context) => LoginViewModel(uid),
          child: view,
        );
      },
    );
  }
}
