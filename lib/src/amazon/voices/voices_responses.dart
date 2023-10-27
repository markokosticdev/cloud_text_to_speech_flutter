import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voice_model.dart';

class VoicesResponseAmazon extends BaseResponse {
  VoicesResponseAmazon({required int code, required String reason})
      : super(code: code, reason: reason);
}

class VoicesSuccessAmazon extends VoicesResponseAmazon {
  VoicesSuccessAmazon({required this.voices})
      : super(code: 200, reason: 'Success');
  final List<VoiceAmazon> voices;
}

class VoicesFailedBadRequestAmazon extends VoicesResponseAmazon {
  VoicesFailedBadRequestAmazon({String? reasonPhrase})
      : super(
            code: 400,
            reason:
                "Bad Request	A required parameter is missing, empty, or null. Or, the value passed to either a required or optional parameter is invalid. A common issue is a header that is too long. ${reasonPhrase ?? ''}");
}

class VoicesFailedUnauthorizedAmazon extends VoicesResponseAmazon {
  VoicesFailedUnauthorizedAmazon()
      : super(
            code: 401,
            reason:
                "Unauthorized	The request is not authorized. Check to make sure your subscription key or token is valid and in the correct region.");
}

class VoicesFailedTooManyRequestsAmazon extends VoicesResponseAmazon {
  VoicesFailedTooManyRequestsAmazon()
      : super(
            code: 429,
            reason:
                "Too Many Requests	You have exceeded the quota or rate of requests allowed for your subscription.");
}

class VoicesFailedBadGateWayAmazon extends VoicesResponseAmazon {
  VoicesFailedBadGateWayAmazon()
      : super(
            code: 502,
            reason:
                "Bad Gateway	Network or server-side issue. May also indicate invalid headers.");
}

class VoicesFailedUnknownErrorAmazon extends VoicesResponseAmazon {
  VoicesFailedUnknownErrorAmazon({required int code, required String reason})
      : super(code: code, reason: reason);
}
