/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import '../utils/utils.dart';
import '../provider/store.dart';
import 'package:flutter/material.dart';
import '../provider/model/theme_model.dart';

/// Created On 2019/12/5
/// Description:
///
class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  /// Color List
  List<Color> _themeColors;

  @override
  void initState() {
    super.initState();
    // Init
    _themeColors = Utils.getRandomColors(60);
  }

  /// Update Theme Color
  _updateThemeColor(Color color) {
    Store.value<ThemeModel>(context).update(color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Color')),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 2.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (c, i) {
          Color curColor = _themeColors[i];
          String colorString = curColor.toString();
          String text = colorString.substring(8, colorString.length - 1);
          text = '0x${text.toUpperCase()}';
          return Container(
            margin: EdgeInsets.fromLTRB(0.0, 2.0, 2.0, 0.0),
            child: MaterialButton(
              onPressed: () => _updateThemeColor(curColor),
              color: curColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color:
                      curColor.value > 0xFF666666 ? Colors.black : Colors.white,
                ),
              ),
            ),
          );
        },
        itemCount: _themeColors.length,
      ),
    );
  }
}
