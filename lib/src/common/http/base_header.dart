abstract class BaseHeader {
  ///[type] The type of Header to use.
  ///[value] The value assigned to the [type].
  BaseHeader({required String type, required String value})
      : _type = type,
        _value = value;

  final String _type;
  final String _value;

  String get value => _value;

  String get type => _type;

  String get headerValue;
}
