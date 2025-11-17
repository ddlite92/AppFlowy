// library flowy_infra_ui_web;

import 'dart:js_util' as js_util;

import 'package:flowy_infra_ui_platform_interface/flowy_infra_ui_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class FlowyInfraUIPlugin extends FlowyInfraUIPlatform {
  static void registerWith(Registrar registrar) {
    FlowyInfraUIPlatform.instance = FlowyInfraUIPlugin();
  }

  // MARK: - Keyboard

  @override
  Stream<bool> get onKeyboardVisibilityChange async* {
    // suppose that keyboard won't show in web side
    yield false;
  }

  @override
  Future<String?> getPlatformVersion() async {
    // read navigator.userAgent via JS interop to avoid dart:html
    try {
      final navigator = js_util.getProperty(js_util.globalThis, 'navigator');
      final userAgent = js_util.getProperty(navigator, 'userAgent');
      return userAgent is String ? userAgent : null;
    } catch (_) {
      return null;
    }
  }
}
