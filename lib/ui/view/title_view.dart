import 'package:afterlogic_test/common/constants.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final subTitle;
  const TitleView({Key key, @required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            TITLE_CONTACTS,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          Text(
            subTitle,
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
