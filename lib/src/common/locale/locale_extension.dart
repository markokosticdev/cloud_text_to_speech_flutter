import 'dart:ui';

import 'package:locale_names/locale_names.dart';

export 'package:locale_names/locale_names.dart';

extension DisplayNamesExt on Locale {
  String? get defaultDisplayScript {
    if (this.scriptCode != null) {
      final lookup = _getLookupExt();
      final scriptCode = this.scriptCode;
      return lookup[scriptCode];
    }
    return "";
  }

  String? get nativeDisplayScript {
    if (this.scriptCode != null) {
      final lookup = _getLookupExt(locale: this);
      final scriptCode = this.scriptCode;
      return lookup[scriptCode];
    }
    return "";
  }

  String? displayScriptIn(Locale locale) {
    if (this.scriptCode != null) {
      final lookup = _getLookupExt(locale: locale);
      final scriptCode = this.scriptCode;
      return lookup[scriptCode];
    }
    return "";
  }

  Map<String, String> _getLookupExt({Locale? locale}) {
    if (locale == null) {
      return DisplayNames.tables['en']!;
    }
    String name = locale.toString();
    return _loadExt(name);
  }

  Map<String, String> _loadExt(String name) {
    Map<String, String> parent = Map.from(DisplayNames.tables['en']!);
    List<String> parts = name.split('_');
    if (parts.length > 1) {
      String parentName = parts.sublist(0, parts.length - 1).join("_");
      parent = _loadExt(parentName);
    }
    Map<String, dynamic>? data = DisplayNames.tables[name];
    if (data != null) {
      parent.addAll(data as Map<String, String>);
    }
    return parent;
  }
}
