import 'package:cloud_text_to_speech/src/common/http/base_header.dart';

///Base class that all authentications types must implement.
abstract class AuthenticationHeaderGoogle extends BaseHeader {
  ///[type] The type of Microsoft Authorisation Header to use.
  ///[value] The value assigned to the [type].
  AuthenticationHeaderGoogle({required String type, required String value})
      : super(type: type, value: value);
}

///Authentication using Ocp-Apim-Subscription-Key header type
class ApiKeyAuthenticationHeaderGoogle extends AuthenticationHeaderGoogle {
  ApiKeyAuthenticationHeaderGoogle({required String apiKey})
      : super(type: "X-goog-api-key", value: apiKey);

  @override
  String get headerValue => value;
}
