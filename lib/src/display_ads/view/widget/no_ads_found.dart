import 'package:cest_pret_de_chez_vous/styles.dart';
import 'package:flutter/cupertino.dart';

class NoAdsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Center(
      child: Text('Could not find any ads', style: Styles.bigCenterText),
    ));
  }
}
