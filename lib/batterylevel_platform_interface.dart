import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'batterylevel_method_channel.dart';

abstract class BatterylevelPlatform extends PlatformInterface {
  /// Constructs a BatterylevelPlatform.
  BatterylevelPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatterylevelPlatform _instance = MethodChannelBatterylevel();

  /// The default instance of [BatterylevelPlatform] to use.
  ///
  /// Defaults to [MethodChannelBatterylevel].
  static BatterylevelPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BatterylevelPlatform] when
  /// they register themselves.
  static set instance(BatterylevelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
 ///获取平台版本号
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  // 获取电池电量
  Future<int?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }
  Future<String?> getValueByAndroid(String tag){
    throw UnimplementedError('getValueByAndroid() has not been implemented.');
  }
  ///跳转原生页面
  Future<String?> intentToAndroidView(String tag) {
    throw UnimplementedError('intentToAndroidView() has not been implemented.');
  }

}
