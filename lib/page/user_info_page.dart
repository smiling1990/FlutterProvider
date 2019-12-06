/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import '../utils/utils.dart';
import 'common_web_view.dart';
import '../provider/store.dart';
import 'package:flutter/material.dart';
import '../provider/model/user_info_model.dart';

/// Created On 2019/12/5
/// Description:
///
class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
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
    print('-->> UserInfo Page Rebuild.');
    Widget line = Container(
      height: 0.2,
      color: Color(0xFF999999),
      margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Store.connect<UserInfoModel>(
            builder: (context, snapshot, child) {
              print('-->> UserInfo Page Info Rebuild.');
              return _buildItem(
                'Avatar',
                () {
                  // assets/avatar_0.png
                  int toInt = Utils.getRandomNum();
                  String toAvatar = 'assets/avatar_$toInt.png';
                  snapshot.update(avatar: toAvatar);
                },
                text: snapshot.avatar,
                avatar: snapshot.avatar,
              );
            },
          ),
          line,
          Store.connect<UserInfoModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Wechat Id',
                () {},
                canEdit: false,
                text: snapshot.id,
              );
            },
          ),
          line,
          Store.connect<UserInfoModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Name',
                () {},
                canEdit: false,
                text: snapshot.name,
              );
            },
          ),
          line,
          Store.connect<UserInfoModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Age',
                null,
                canEdit: false,
                text: '${snapshot.age}(final)',
              );
            },
          ),
          line,
          Store.connect<UserInfoModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Email',
                () {},
                isLink: true,
                canEdit: false,
                text: snapshot.email,
              );
            },
          ),
          line,
          Store.connect<UserInfoModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Home Page',
                () {
                  Utils.pushToPage(
                    context,
                    WebViewPage(snapshot.net, title: 'Homepage'),
                  );
                },
                isLink: true,
                canEdit: false,
                text: snapshot.net,
              );
            },
          ),
          line,
        ],
      ),
    );
  }
}
