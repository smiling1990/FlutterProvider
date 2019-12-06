/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import '../provider/store.dart';
import 'package:flutter/material.dart';
import '../provider/model/setting_model.dart';

/// Created On 2019/12/5
/// Description: Setting
///
class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
    print('-->> Setting Page Rebuild.');
    Widget line = Container(
      height: 0.2,
      color: Color(0xFF999999),
      margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Store.connect<SettingModel>(
            builder: (context, snapshot, child) {
              print('-->> Setting Page Info Rebuild.');
              return _buildItem(
                'Package Id',
                null,
                canEdit: false,
                text: snapshot.id,
              );
            },
          ),
          line,
          Store.connect<SettingModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Application Name',
                null,
                canEdit: false,
                text: snapshot.name,
              );
            },
          ),
          line,
          Store.connect<SettingModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Version',
                () {
                  snapshot.update(
                    version: _addVersion(snapshot.version),
                    versionCode: snapshot.versionCode + 1,
                  );
                },
                text: snapshot.version,
              );
            },
          ),
          line,
          Store.connect<SettingModel>(
            builder: (context, snapshot, child) {
              return _buildItem(
                'Version Code',
                () {
                  snapshot.update(
                    version: _addVersion(snapshot.version),
                    versionCode: snapshot.versionCode + 1,
                  );
                },
                text: snapshot.versionCode?.toString(),
              );
            },
          ),
          line
        ],
      ),
    );
  }

  /// 1.0.0 -->> 1.0.1
  String _addVersion(String version) {
    int curV = int.parse(version.replaceAll('.', ''));
    String toVersion = (curV + 1).toString();
    String a = toVersion.substring(0, 1);
    String b = toVersion.substring(1, 2);
    String c = toVersion.substring(2);
    toVersion = '$a.$b.$c';
    return toVersion;
  }
}
