class Log {
  static bool _enabled = false;
  static String _package = "[cloud_text_to_speech]";

  static void enable() => _enabled = true;

  static void disable() => _enabled = false;

  static bool get isEnabled => _enabled;

  static void d(String message, [String? tag]) {
    if (isEnabled) print("$_package -> ${tag ?? ""} : $message");
  }
}
