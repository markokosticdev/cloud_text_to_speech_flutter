import 'package:cloud_text_to_speech/src/common/http/base_header.dart';

///Base class that all authentications types must implement.
abstract class AuthenticationHeaderMicrosoft extends BaseHeader {
  ///[type] The type of Microsoft Authorisation Header to use.
  ///[value] The value assigned to the [type].
  AuthenticationHeaderMicrosoft({required String type, required String value})
      : super(type: type, value: value);
}

///Authentication using Ocp-Apim-Subscription-Key header type
class SubscriptionKeyAuthenticationHeaderMicrosoft
    extends AuthenticationHeaderMicrosoft {
  SubscriptionKeyAuthenticationHeaderMicrosoft(
      {required String subscriptionKey})
      : super(type: "Ocp-Apim-Subscription-Key", value: subscriptionKey);

  @override
  String get headerValue => value;
}
