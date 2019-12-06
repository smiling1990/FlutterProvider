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
/// Description: Login user info
///
class SettingModel extends BaseModel with ChangeNotifier {
  /// Application id
  String _id;

  /// Application name
  String _name;

  /// Version
  String _version;

  /// Version code
  int _versionCode;

  SettingModel(
    this._id,
    this._name,
    this._version,
    this._versionCode,
  );

  String get id => _id;

  String get name => _name;

  String get version => _version;

  int get versionCode => _versionCode;

  void update({String id, String name, String version, int versionCode}) {
    _id = id ?? _id;
    _name = name ?? _name;
    _version = version ?? _version;
    _versionCode = versionCode ?? _versionCode;
    notifyListeners();
  }
}
