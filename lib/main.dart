/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import 'provider/store.dart';
import 'page/theme_page.dart';
import 'page/setting_page.dart';
import 'page/user_info_page.dart';
import 'page/user_address_page.dart';
import 'package:flutter/material.dart';
import 'provider/model/theme_model.dart';

void main() {
  /**
   * Noted:
   * When you set 'Provider.debugCheckInvalidValueType = null',
   * [Provider] will not automatically update dependents when Model is updated.
   * Use:
   * - ListenableProvider
   * - ChangeNotifierProvider
   * - ValueListenableProvider
   * - StreamProvider
   */
  // Provider.debugCheckInvalidValueType = null;
  /// Init providers
  runApp(Store.init(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get primary color by ThemeModel
    var primaryColor = Store.value<ThemeModel>(context).primaryColor;
    print('-->> MyApp rebuild');
    return MaterialApp(
      title: 'Flutter Provider',
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Show Title
  _buildTitle(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 18.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Provider'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => ThemePage()),
              );
            },
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          _buildTitle('Setting'),
          SettingPage(key: Key('Setting')),
          _buildTitle('User Info'),
          UserInfoPage(),
          _buildTitle('User Address'),
          UserAddressPage(),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
