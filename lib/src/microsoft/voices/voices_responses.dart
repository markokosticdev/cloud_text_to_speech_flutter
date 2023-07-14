import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voice_model.dart';

class VoicesResponseMicrosoft extends BaseResponse {
  VoicesResponseMicrosoft({required int code, required String reason})
      : super(code: code, reason: reason);
}

class VoicesSuccessMicrosoft extends VoicesResponseMicrosoft {
  VoicesSuccessMicrosoft({required this.voices})
      : super(code: 200, reason: 'Success');
  final List<VoiceMicrosoft> voices;
}

class VoicesFailedBadRequestMicrosoft extends VoicesResponseMicrosoft {
  VoicesFailedBadRequestMicrosoft({String? reasonPhrase})
      : super(
            code: 400,
            reason:
                "Bad Request	A required parameter is missing, empty, or null. Or, the value passed to either a required or optional parameter is invalid. A common issue is a header that is too long. ${reasonPhrase ?? ''}");
}

class VoicesFailedUnauthorizedMicrosoft extends VoicesResponseMicrosoft {
  VoicesFailedUnauthorizedMicrosoft()
      : super(
            code: 401,
            reason:
                "Unauthorized	The request is not authorized. Check to make sure your subscription key or token is valid and in the correct region.");
}

class VoicesFailedTooManyRequestsMicrosoft extends VoicesResponseMicrosoft {
  VoicesFailedTooManyRequestsMicrosoft()
      : super(
            code: 429,
            reason:
                "Too Many Requests	You have exceeded the quota or rate of requests allowed for your subscription.");
}

class VoicesFailedBadGateWayMicrosoft extends VoicesResponseMicrosoft {
  VoicesFailedBadGateWayMicrosoft()
      : super(
            code: 502,
            reason:
                "Bad Gateway	Network or server-side issue. May also indicate invalid headers.");
}

class VoicesFailedUnkownErrorMicrosoft extends VoicesResponseMicrosoft {
  VoicesFailedUnkownErrorMicrosoft({required int code, required String reason})
      : super(code: code, reason: reason);
}
