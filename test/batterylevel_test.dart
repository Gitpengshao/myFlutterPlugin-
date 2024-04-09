import 'package:flutter_test/flutter_test.dart';
import 'package:batterylevel/batterylevel.dart';
import 'package:batterylevel/batterylevel_platform_interface.dart';
import 'package:batterylevel/batterylevel_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBatterylevelPlatform
    with MockPlatformInterfaceMixin
    implements BatterylevelPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BatterylevelPlatform initialPlatform = BatterylevelPlatform.instance;

  test('$MethodChannelBatterylevel is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBatterylevel>());
  });

  test('getPlatformVersion', () async {
    Batterylevel batterylevelPlugin = Batterylevel();
    MockBatterylevelPlatform fakePlatform = MockBatterylevelPlatform();
    BatterylevelPlatform.instance = fakePlatform;

    expect(await batterylevelPlugin.getPlatformVersion(), '42');
  });
}
