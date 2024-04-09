import 'batterylevel_platform_interface.dart';

class Batterylevel {
  Future<String?> getPlatformVersion() {
    return BatterylevelPlatform.instance.getPlatformVersion();
  }

  // 获取电池电量
  Future<int?> getBatteryLevel() {
    return BatterylevelPlatform.instance.getBatteryLevel();
  }

  ///给原生传参数
  Future<String?> getValueByAndroid(String tag) {
    return BatterylevelPlatform.instance.getValueByAndroid(tag);
  }

  ///跳转原生页面
  Future<String?> intentToAndroidView(String tag) {
    return BatterylevelPlatform.instance.intentToAndroidView(tag);
  }
}
