/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import 'dart:math';
import 'package:flutter/material.dart';

/// Created On 2019/12/5
/// Description:
///
class Utils {
  /// Create a random num
  static getRandomNum() {
    // Random [0, 9)
    int ret = Random().nextInt(9);
    return ret;
  }

  /// Create a random color
  static getRandomColor() {
    // Random [0, 0xFF]
    int r = Random().nextInt(0xFF + 1);
    int g = Random().nextInt(0xFF + 1);
    int b = Random().nextInt(0xFF + 1);
    return Color.fromARGB(0xFF, r, g, b);
  }

  /// Create many random colors
  static getRandomColors(int count) {
    List<Color> colors = [];
    for (int i = 0; i < count; i++) {
      colors.add(getRandomColor());
    }
    return colors;
  }

  static pushToPage(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => widget));
  }

  /// Get postal code
  /// 450001
  static getPostalCode(String district) {
    String postalCode;
    if (district == '罗湖区') {
      postalCode = '518001';
    } else if (district == '福田区') {
      postalCode = '518026';
    } else if (district == '南山区') {
      postalCode = '518052';
    } else if (district == '盐田区') {
      postalCode = '518081';
    } else if (district == '福田区') {
      postalCode = '518028';
    } else if (district == '龙岗区') {
      postalCode = '518116';
    } else if (district == '宝安区') {
      postalCode = '518101';
    } else if (district == '光明新区') {
      postalCode = '518106';
    } else if (district == '坪山新区') {
      postalCode = '518118';
    } else if (district == '大鹏新区') {
      postalCode = '518120';
    } else if (district == '龙华新区') {
      postalCode = '518110';
    }
    return postalCode ?? '518000';
  }

  /// Create a random District
  /// 广东省 深圳市 宝安区
  static getRandomDistrict() {
    List<String> districts = [
      '罗湖区',
      '福田区',
      '南山区',
      '盐田区',
      '龙岗区',
      '宝安区',
      '光明新区',
      '坪山新区',
      '大鹏新区',
      '龙华新区',
    ];
    int a = Random().nextInt(districts.length);
    return districts[a];
  }
}
