import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/app_info.dart';

void main() {
  test('AppInfo.version matches pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(
      r'^version: ([\d.]+)\+',
      multiLine: true,
    ).firstMatch(pubspec)![1];
    expect(AppInfo.version, version);
  });
}
