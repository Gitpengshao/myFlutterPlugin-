import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'batterylevel_platform_interface.dart';

/// An implementation of [BatterylevelPlatform] that uses method channels.
class MethodChannelBatterylevel extends BatterylevelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('batterylevel');

  ///获取平台版本号
  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 获取电池电量
  @override
  Future<int?> getBatteryLevel() async {
    final level = await methodChannel.invokeMethod<int>('getBatteryLevel');
    return level;
  }

  @override
  Future<String?> getValueByAndroid(String tag) async {
    final level =
        await methodChannel.invokeMethod<String>('getValueByAndroid', tag);
    return level;
  }

  @override
  Future<String?> intentToAndroidView(String tag) async {
    final level =
        await methodChannel.invokeMethod<String>('intentToAndroidView', tag);
    return level;
  }
}
