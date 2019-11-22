import 'package:flutter/cupertino.dart';

import '../../../../styles.dart';

class NoAdsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return(
      Center(
        child: Text('Could not find any ads', style: Styles.bigCenterText),
      )
    );
  }
}
