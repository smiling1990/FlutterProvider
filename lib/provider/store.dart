/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import 'model/theme_model.dart';
import 'model/setting_model.dart';
import 'model/user_info_model.dart';
import 'model/user_address_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Created On 2019/12/5
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
