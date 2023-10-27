import 'dart:typed_data';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

abstract class AudioResponseAmazon extends BaseResponse {
  AudioResponseAmazon({required int code, required String reason})
      : super(code: code, reason: reason);
}

class AudioSuccessAmazon extends AudioResponseAmazon {
  AudioSuccessAmazon({required this.audio})
      : super(code: 200, reason: "Success");
  final Uint8List audio;
}

class AudioFailedBadRequestAmazon extends AudioResponseAmazon {
  AudioFailedBadRequestAmazon({String? reasonPhrase})
      : super(
            code: 400,
            reason:
                "Bad Request	A required parameter is missing, empty, or null. Or, the value passed to either a required or optional parameter is invalid. A common issue is a header that is too long. ${reasonPhrase ?? ''}");
}

class AudioFailedUnauthorizedAmazon extends AudioResponseAmazon {
  AudioFailedUnauthorizedAmazon()
      : super(
            code: 401,
            reason:
                "Unauthorized	The request is not authorized. Check to make sure your subscription key or token is valid and in the correct region.");
}

class AudioFailedUnsupportedAmazon extends AudioResponseAmazon {
  AudioFailedUnsupportedAmazon()
      : super(
            code: 415,
            reason:
                "Unsupported Media Type	It's possible that the wrong Content-Type was provided. Content-Type should be set to application/ssml+xml.");
}

class AudioFailedTooManyRequestAmazon extends BaseResponse {
  AudioFailedTooManyRequestAmazon()
      : super(
            code: 429,
            reason:
                "Too Many Requests	You have exceeded the quota or rate of requests allowed for your subscription.");
}

class AudioFailedBadGatewayAmazon extends AudioResponseAmazon {
  AudioFailedBadGatewayAmazon()
      : super(
            code: 502,
            reason:
                "Bad Gateway	Network or server-side issue. May also indicate invalid headers.");
}

class AudioFailedUnknownErrorAmazon extends AudioResponseAmazon {
  AudioFailedUnknownErrorAmazon({required int code, required String reason})
      : super(code: code, reason: reason);
}
