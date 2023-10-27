import 'dart:typed_data';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

abstract class AudioResponseMicrosoft extends BaseResponse {
  AudioResponseMicrosoft({required int code, required String reason})
      : super(code: code, reason: reason);
}

class AudioSuccessMicrosoft extends AudioResponseMicrosoft {
  AudioSuccessMicrosoft({required this.audio})
      : super(code: 200, reason: "Success");
  final Uint8List audio;
}

class AudioFailedBadRequestMicrosoft extends AudioResponseMicrosoft {
  AudioFailedBadRequestMicrosoft({String? reasonPhrase})
      : super(
            code: 400,
            reason:
                "Bad Request	A required parameter is missing, empty, or null. Or, the value passed to either a required or optional parameter is invalid. A common issue is a header that is too long. ${reasonPhrase ?? ''}");
}

class AudioFailedUnauthorizedMicrosoft extends AudioResponseMicrosoft {
  AudioFailedUnauthorizedMicrosoft()
      : super(
            code: 401,
            reason:
                "Unauthorized	The request is not authorized. Check to make sure your subscription key or token is valid and in the correct region.");
}

class AudioFailedUnsupportedMicrosoft extends AudioResponseMicrosoft {
  AudioFailedUnsupportedMicrosoft()
      : super(
            code: 415,
            reason:
                "Unsupported Media Type	It's possible that the wrong Content-Type was provided. Content-Type should be set to application/ssml+xml.");
}

class AudioFailedTooManyRequestMicrosoft extends BaseResponse {
  AudioFailedTooManyRequestMicrosoft()
      : super(
            code: 429,
            reason:
                "Too Many Requests	You have exceeded the quota or rate of requests allowed for your subscription.");
}

class AudioFailedBadGatewayMicrosoft extends AudioResponseMicrosoft {
  AudioFailedBadGatewayMicrosoft()
      : super(
            code: 502,
            reason:
                "Bad Gateway	Network or server-side issue. May also indicate invalid headers.");
}

class AudioFailedUnknownErrorMicrosoft extends AudioResponseMicrosoft {
  AudioFailedUnknownErrorMicrosoft({required int code, required String reason})
      : super(code: code, reason: reason);
}
