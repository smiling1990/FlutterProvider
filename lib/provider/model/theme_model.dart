/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import 'base_model.dart';
import 'package:flutter/material.dart';

/// Created On 2019/12/5
/// Description:
///
class ThemeModel extends BaseModel with ChangeNotifier {
  Color _primaryColor;

  ThemeModel(this._primaryColor);

  Color get primaryColor => _primaryColor;

  void update(Color primaryColor) {
    _primaryColor = primaryColor;
    notifyListeners();
  }
}
