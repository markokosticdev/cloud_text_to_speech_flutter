import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/google/voices/voice_model.dart';

class VoicesResponseGoogle extends BaseResponse {
  VoicesResponseGoogle({required int code, required String reason})
      : super(code: code, reason: reason);
}

class VoicesSuccessGoogle extends VoicesResponseGoogle {
  VoicesSuccessGoogle({required this.voices})
      : super(code: 200, reason: 'Success');
  final List<VoiceGoogle> voices;
}

class VoicesFailedBadRequestGoogle extends VoicesResponseGoogle {
  VoicesFailedBadRequestGoogle({String? reasonPhrase})
      : super(
            code: 400,
            reason:
                "Bad Request	A required parameter is missing, empty, or null. Or, the value passed to either a required or optional parameter is invalid. A common issue is a header that is too long. ${reasonPhrase ?? ''}");
}

class VoicesFailedUnauthorizedGoogle extends VoicesResponseGoogle {
  VoicesFailedUnauthorizedGoogle()
      : super(
            code: 401,
            reason:
                "Unauthorized	The request is not authorized. Check to make sure your subscription key or token is valid and in the correct region.");
}

class VoicesFailedTooManyRequestsGoogle extends VoicesResponseGoogle {
  VoicesFailedTooManyRequestsGoogle()
      : super(
            code: 429,
            reason:
                "Too Many Requests	You have exceeded the quota or rate of requests allowed for your subscription.");
}

class VoicesFailedBadGateWayGoogle extends VoicesResponseGoogle {
  VoicesFailedBadGateWayGoogle()
      : super(
            code: 502,
            reason:
                "Bad Gateway	Network or server-side issue. May also indicate invalid headers.");
}

class VoicesFailedUnknownErrorGoogle extends VoicesResponseGoogle {
  VoicesFailedUnknownErrorGoogle({required int code, required String reason})
      : super(code: code, reason: reason);
}
