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
class UserInfoModel extends BaseModel with ChangeNotifier {
  /// User id
  String _id;

  /// User age
  int _age;

  /// User name
  String _name;

  /// User avatar
  String _avatar;

  /// User email
  String _email;

  /// User Personal Net
  String _net;

  UserInfoModel(
    this._id,
    this._name,
    this._age,
    this._avatar,
    this._email,
    this._net,
  );

  String get id => _id;

  int get age => _age;

  String get name => _name;

  String get avatar => _avatar;

  String get email => _email;

  String get net => _net;

  void update({String id, String name, String avatar, int age}) {
    _id = id ?? _id;
    _age = age ?? _age;
    _name = name ?? _name;
    _avatar = avatar ?? _avatar;
    notifyListeners();
  }
}
