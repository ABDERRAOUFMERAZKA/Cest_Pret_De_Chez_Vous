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
    return ChangeNotifierProvider(
      builder: (context) => LoginViewModel(),
      child: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          Widget view;
          FirebaseUser currentUser = snapshot.data;

          Provider.of<LoginViewModel>(context).updateCurrentUser(currentUser);

          // Choose the view according to the user.
          if (currentUser == null) {
            // If there is no user, wa ask him to connect or create an account.
            view = Login();
          } else if (!currentUser.isEmailVerified) {
            // If the user has not confirmed his email yet, we display a page to do so.
            view = ValidationMail();
          } else {
            // Here the user is connected and with email verified, he can access the app.
            String uid = currentUser.uid;
            view = MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  builder: (context) => AdsAroundViewModel(uid),
                ),
                ChangeNotifierProvider(
                  builder: (context) => FavoriteAdsViewModel(uid),
                ),
                ChangeNotifierProvider(
                  builder: (context) => CurrentUserAdsViewModel(uid),
                ),
                ChangeNotifierProvider(
                  builder: (context) => PostAdViewModel(uid),
                )
              ],
              // Tabs displays all the pages of the app, we put the view-models just
              // under it.
              child: Tabs(),
            );
          }

          return view;
        },
      ),
    );
  }
}
