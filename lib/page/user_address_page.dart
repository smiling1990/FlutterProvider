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
import '../provider/model/user_address_model.dart';

/// Created On 2019/12/6
/// Description:
///
class UserAddressPage extends StatefulWidget {
  UserAddressPage({Key key}) : super(key: key);

  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  /// Show Item
  _buildItem(String title, VoidCallback onPressed,
      {String text, String avatar, bool isLink = false, bool canEdit = true}) {
    Widget detailWidget;
    if (avatar == null) {
      detailWidget = Text(
        text ?? '',
        style: TextStyle(
          fontSize: 14.0,
          color: isLink ? Color(0xFF207AEE) : Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.end,
      );
    } else {
      detailWidget = Container(
        alignment: Alignment.centerRight,
        child: CircleAvatar(
          child: Image.asset(
            avatar,
            width: 40.0,
            height: 40.0,
          ),
        ),
      );
    }
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      color: Colors.white,
      disabledColor: Colors.white,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(width: 4.0),
          Expanded(child: detailWidget),
          SizedBox(width: 4.0),
          canEdit
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: Colors.grey.withAlpha(160),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('-->> User Address Page Rebuild.');
    Widget line = Container(
      height: 0.2,
      color: Color(0xFF999999),
      margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              print('-->> User Address Page Info Rebuild.');
              return _buildItem(
                'Avatar',
                null,
                text: snapshot.userInfoModel.avatar,
                avatar: snapshot.userInfoModel.avatar,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Wechat Id',
                () {},
                canEdit: false,
                text: snapshot.userInfoModel.id,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Name',
                () {},
                canEdit: false,
                text: snapshot.userInfoModel.name,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Postal Code',
                () {
                  String district = Utils.getRandomDistrict();
                  snapshot.update(
                    district: district,
                    postalCode: Utils.getPostalCode(district),
                  );
                },
                text: snapshot.postalCode,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Address',
                () {
                  String district = Utils.getRandomDistrict();
                  snapshot.update(
                    district: district,
                    postalCode: Utils.getPostalCode(district),
                  );
                },
                text: snapshot.address,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Province',
                () {},
                canEdit: false,
                text: snapshot.province,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'City',
                () {},
                canEdit: false,
                text: snapshot.city,
              );
            },
          ),
          line,
          Store.connect<UserAddressModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'District',
                () {
                  String district = Utils.getRandomDistrict();
                  snapshot.update(
                    district: district,
                    postalCode: Utils.getPostalCode(district),
                  );
                },
                text: snapshot.district,
              );
            },
          ),
          line,
        ],
      ),
    );
  }
}
