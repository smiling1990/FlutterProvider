## 前言
Provider是Google I/O 2019大会宣布的官方推荐的状态管理方式。

本文档通过一个简单的项目，介绍Provider的特点及使用。

关于Provider的官方介绍请点击 [Provider](https://pub.dev/packages/provider).

## 项目地址
文章虽长，代码来凑。直接看代码的小伙伴，点击 [https://github.com/smiling1990/FlutterProvider](https://github.com/smiling1990/FlutterProvider)

## Provider分类

### Provider
最基础的Provider，它持有一个类型的值，并暴露出去，并且在任何时候都能获取到最新的值。一般情况下，下层获取上层状态，不过下层是监听不到上层状态的变化。在程序越来越复杂的情况下，使用它在多个Widget中共享状态，还是很方便的。

**提示：同种类型，Provider只能维护一份数据。**

### ListenableProvider
监听状态改变并重绘视图。

### ChangeNotifierProvider
与ListenableProvider区别在于，当需要的时候，会自动调用dispose.

### ValueListenableProvider
与ListenableProvider区别在于，仅仅支持value方式获取状态。

### StreamProvider
以流的方式共享数据。

### FutureProvider
持有Future，并在Future完成时，通知监听者。

### ProxyProvider 系列
当一个 **Model** 与其它的Model或者更多的Model之间存在依赖关系，即多个Model状态发生改变，都会引起这个 **Model** 的状态发生变化，需要使用 **ProxyProvider 系列** 建立多种Model之间的依赖关系。

ProxyProvider 系列包含：
- ProxyProvider - ProxyProvider6
- ListenableProxyProvider - ListenableProxyProvider6
- ChangeNotifierProxyProvider - ChangeNotifierProxyProvider6
- xxxProxyProvider

这些ProxyProvider的使用基本上同Provider的使用，下文会着重介绍。

## 使用哪种Provider?

- 需求：多个Widget共享状态，如果没有这个需求，额，怎么会没有呢，好奇怪。
- 当不需要监听状态改变，下层仅仅是获取上层状态，使用[Provider].
- 需要共享数据，并监听数据发生变化，使用[ListenableProvider]或者[ChangeNotifierProvider]，如果自主管理数据的dispose，使用ListenableProvider.
- 如果两种类型数据，或者多种数据存在依赖关系，使用[ProxyProvider] 系列。
- 最方便的使用，也是懒人最强方式，使用[ChangeNotifierProvider]和[ChangeNotifierProxyProvider].
- 技术正在不断的完善，官方更新比较频繁，需要时时关注动态。

## 两种获取状态的方式

### 通过Provider.value<T>(context)方式获取
使用起来灵活方便，如果Widget比较简单，获取状态就是一行代码的事。

懂行的项目经理，有时候说，“这个，这个，还有那个，不就一行代码的事嘛”，而我们呢，为了这行代码，布了多少局了，我们要Init，要创建Model，还要关注官方动态，还要关注性能，还要创建Bug，额，创建Bug？！

### 通过Consumer方式获取
高手过招，招招致命，推荐使用这种获取方式，避免整个Widget重绘。Widget局部刷新重绘和整个Widget重绘，举个栗子：

- Widget 绘制：娜美吃了路飞手里的 **10** 块肉
- Widget 局部绘制：娜美需要吃路飞手里的 **1** 块肉
- Widget 重绘：娜美需要吃路飞手里的 **10** 块肉

## 项目实战
### 项目简介
1. 更改项目的主题色PrimaryColor

    预测结果：在子Widget更改Model数据，引起父Widget状态发生改变。
    
![](https://user-gold-cdn.xitu.io/2019/12/6/16eda2b4dd90a702?w=540&h=960&f=jpeg&s=87468)

2. 首页通过ListView展示Setting, User Info, User Address

![](https://user-gold-cdn.xitu.io/2019/12/6/16eda28e1bd45af9?w=540&h=960&f=jpeg&s=64605)

![](https://user-gold-cdn.xitu.io/2019/12/6/16eda2d883f34838?w=540&h=960&f=jpeg&s=67659)

![](https://user-gold-cdn.xitu.io/2019/12/6/16eda2dd34322390?w=540&h=960&f=jpeg&s=67628)

3. 更改Setting, User Info, User Address数据，观察页面的重绘情况
    
    预测结果：只会引起单个Widget发生重绘

4. 建立User Address和User Info的依赖关系，更改User Info数据，观察页面重绘情况。

    预测结果：更改User Info数据，会重绘UserInfoWidget和UserAddressWidget.
    
### 项目结构

![](https://user-gold-cdn.xitu.io/2019/12/6/16eda46323b1d1e0?w=1003&h=842&f=png&s=151333)

### 第一步：添加依赖

当前最新版本：3.2.0，查看最新版本请点击 [Provider最新版本](https://pub.dev/packages/provider)

- 在pubspec.yaml中添加 provider: ^3.2.0
- 执行Package get

![](https://user-gold-cdn.xitu.io/2019/12/6/16eda0ac52ecfef9?w=606&h=279&f=png&s=22333)

### 第二步：创建Model

~~~
class ThemeModel extends BaseModel with ChangeNotifier {
  Color _primaryColor;

  ThemeModel(this._primaryColor);

  Color get primaryColor => _primaryColor;

  void update(Color primaryColor) {
    _primaryColor = primaryColor;
    notifyListeners();
  }
}

~~~

~~~
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
~~~

~~~
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

~~~

~~~
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
~~~

### 第三步：创建Store

~~~
/// Description: Provider store
/// providers：
/// 1. [Provider] 最基础的Provider，它持有一个类型的值，并暴露出去，并且在任何时候都能获取到最新的值。
///     一般情况下，下层获取上层状态，不过下层是监听不到上层状态的变化。在程序越来越复杂的情况下，使用
///     它在多个Widget中共享状态，还是很方便的。
/// 2. [ListenableProvider] 监听状态改变并重绘视图。
/// 3. [ChangeNotifierProvider] 与ListenableProvider区别在于，当需要的时候，会自动调用dispose.
/// 4. [ValueListenableProvider] 与ListenableProvider区别在于，仅仅支持value方式获取状态。
/// 5. [StreamProvider] 以流的方式共享数据。
/// 6. [FutureProvider] 持有Future，并在Future完成时，通知监听者。
/// 7. [ProxyProvider] 系列
///   7.1 [ProxyProvider]
///   7.2 [ProxyProvider2] - [ProxyProvider6]
///   7.3 [ListenableProxyProvider]
///   7.4 [ListenableProxyProvider] - [ListenableProxyProvider6]
///   7.5 ...
/// 特点：同种类型只能维护一份数据
/// 使用建议：
/// 0. 需求：多个Widget共享状态，如果没有这个需求，额，怎么会没有呢，好奇怪。
/// 1. 当不需要监听状态发生改变，下层仅仅是获取上层状态，使用[Provider]。
/// 2. 共享数据，并监听数据发生变化，使用[ListenableProvider]或者[ChangeNotifierProvider]，
///     如果自主管理数据的dispose，使用ListenableProvider.
/// 3. 如果两种类型数据，或者多种数据存在依赖关系，使用[ProxyProvider] 系列。
/// 4. 最方便的使用，也是懒人最强方式，使用[ChangeNotifierProvider]和[ChangeNotifierProxyProvider].
/// 5. 技术正在不断的完善，官方更新比较频繁，需要时时关注动态。
class Store {
  /// 创建单一的[Provider]
  /// 使用这个方法时，需要在main.dart中添加 Provider.debugCheckInvalidValueType = null;
  static Provider createProvider<T>(T t) {
    return Provider<T>(
      create: (BuildContext c) => t,
    );
  }

  /// 创建单一的[ListenableProvider]
  static ListenableProvider createListenableProvider<T extends Listenable>(
      T t) {
    return ListenableProvider<T>(
      create: (BuildContext c) => t,
    );
  }

  /// 创建单一的[ChangeNotifierProvider]
  /// 提示：[ChangeNotifier] 实现了 [Listenable]
  static ChangeNotifierProvider
      createChangeNotifierProvider<T extends ChangeNotifier>(T t) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext c) => t,
    );
  }

  /// 创建单一的[ProxyProvider]
  /// 使用这个方法时，需要在main.dart中添加 Provider.debugCheckInvalidValueType = null;
  static ProxyProvider createProxyProvider<T, R>(
    R r,
    R Function(BuildContext c, T t, R r) update,
  ) {
    return ProxyProvider<T, R>(
      create: (BuildContext c) => r,
      update: update,
    );
  }

  /// 创建单一的[ListenableProxyProvider]
  static ListenableProxyProvider
      createListenableProxyProvider<T, R extends Listenable>(
    R r,
    R Function(BuildContext c, T t, R r) update,
  ) {
    return ListenableProxyProvider<T, R>(
      create: (BuildContext c) => r,
      update: update,
    );
  }

  /// 创建单一的[ChangeNotifierProxyProvider]
  static ChangeNotifierProxyProvider
      createChangeNotifierProxyProvider<T, R extends ChangeNotifier>(
    R r,
    R Function(BuildContext c, T t, R r) update,
  ) {
    return ChangeNotifierProxyProvider<T, R>(
      create: (BuildContext c) => r,
      update: update,
    );
  }

  ///  上层Widget执行，Init
  ///  1. 如果是Application共享状态，在RunApp里调用
  ///  2. 如果仅仅是某几个Widget共享状态，在这些Widget的共同父Widget使用
  static init({
    Widget child,
  }) {
    var themeModel = ThemeModel(
      Color(0xFFC12CC6),
    );
    var userInfoModel = UserInfoModel(
      'smiling_0906',
      '蓝色微笑ing',
      18,
      'assets/avatar_0.png',
      'enguangs2@gmail.com',
      'https://juejin.im/user/5acd7f706fb9a028d375c045',
    );
    var settingModel = SettingModel(
      'com.smiling,flutterprovider',
      'Flutter Provider',
      '1.0.1',
      1,
    );
    var addressModel = UserAddressModel(
      userInfoModel,
      'AID1',
      '518100',
      '广东省 深圳市 宝安区',
      '广东省',
      '深圳市',
      '宝安区',
    );
    return MultiProvider(
      providers: [
        createListenableProvider<ThemeModel>(themeModel),
        createListenableProvider<UserInfoModel>(userInfoModel),
        createListenableProvider<SettingModel>(settingModel),
        createChangeNotifierProxyProvider<UserInfoModel, UserAddressModel>(
          addressModel,
          (BuildContext c, UserInfoModel u, UserAddressModel a) {
            return a..update(userInfoModel: u);
          },
        ),
      ],
      child: child,
    );
  }

  /// 父Widget执行[initSomeProviders]，子Widget获取State
  /// 切记：不要在不相关的Widget获取这些Provider State
  static initSomeProviders({
    List<SingleChildCloneableWidget> providers,
    Widget child,
  }) {
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }

  ////////////////////////////////////////////////////////////
  // 两种获取状态的方式
  ////////////////////////////////////////////////////////////
  /// 1. 通过Provider.value<T>(context)方式获取
  /// 使用起来灵活方便，如果Widget比较简单，获取状态就是一行代码的事。
  /// 懂行的项目经理，有时候说，“这个，这个，还有那个，不就一行代码的事嘛”，
  /// 而我们呢，为了这行代码，布了多少局了，我们要Init，要创建Model，还要关注官方动态，
  /// 还要关注性能，还要创建Bug，额，创建Bug？！
  static T value<T>(context) {
    return Provider.of(context);
  }

  /// 2. 通过Consumer方式获取
  /// 高手过招，招招致命，推荐使用这种获取方式，避免整个Widget重绘
  static Consumer connect<T>({
    Widget Function(BuildContext context, T value, Widget child) builder,
    Widget child,
  }) {
    return Consumer<T>(builder: builder, child: child);
  }
}
~~~

### 第四步：Provider初始化及Model数据获取

~~~
runApp(Store.init(child: MyApp()));
~~~

~~~
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
      ],
    ),
  );
}
~~~

