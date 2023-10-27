import 'package:cloud_text_to_speech/src/common/http/base_header.dart';

///Base class that all authentications types must implement.
abstract class AuthenticationHeaderAmazon extends BaseHeader {
  ///[type] The type of Amazon Authorisation Header to use.
  ///[value] The value assigned to the [type].
  AuthenticationHeaderAmazon({required String type, required String value})
      : super(type: type, value: value);
}
