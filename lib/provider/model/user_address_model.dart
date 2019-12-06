/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import 'base_model.dart';
import 'user_info_model.dart';
import 'package:flutter/material.dart';

/// Created On 2019/12/6
/// Description: 依赖UserInfoModel
///
class UserAddressModel extends BaseModel with ChangeNotifier {
  /// User
  UserInfoModel _userInfoModel;

  /// Address id
  String _id;

  /// PostalCode
  String _postalCode;

  /// Address
  String _address;

  /// Province
  String _province;

  /// City
  String _city;

  /// District
  String _district;

  UserAddressModel(
    this._userInfoModel,
    this._id,
    this._postalCode,
    this._address,
    this._province,
    this._city,
    this._district,
  );

  UserInfoModel get userInfoModel => _userInfoModel;

  String get id => _id;

  String get postalCode => _postalCode;

  String get address => _address;

  String get province => _province;

  String get city => _city;

  String get district => _district;

  void update({
    UserInfoModel userInfoModel,
    String id,
    String postalCode,
    // String address,
    String province,
    String city,
    String district,
  }) {
    _userInfoModel = userInfoModel ?? _userInfoModel;
    _id = id ?? _id;
    _postalCode = postalCode ?? _postalCode;
    _province = province ?? _province;
    _city = city ?? _city;
    _district = district ?? _district;
    _address = district == null ? _address : '广东省 深圳市 $district';
    notifyListeners();
  }
}
