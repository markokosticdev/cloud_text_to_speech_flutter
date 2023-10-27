import 'dart:typed_data';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';

abstract class AudioResponseGoogle extends BaseResponse {
  AudioResponseGoogle({required int code, required String reason})
      : super(code: code, reason: reason);
}

class AudioSuccessGoogle extends AudioResponseGoogle {
  AudioSuccessGoogle({required this.audio})
      : super(code: 200, reason: "Success");
  final Uint8List audio;
}

class AudioFailedBadRequestGoogle extends AudioResponseGoogle {
  AudioFailedBadRequestGoogle({String? reasonPhrase})
      : super(
            code: 400,
            reason:
                "Bad Request	A required parameter is missing, empty, or null. Or, the value passed to either a required or optional parameter is invalid. A common issue is a header that is too long. ${reasonPhrase ?? ''}");
}

class AudioFailedUnauthorizedGoogle extends AudioResponseGoogle {
  AudioFailedUnauthorizedGoogle()
      : super(
            code: 401,
            reason:
                "Unauthorized	The request is not authorized. Check to make sure your subscription key or token is valid and in the correct region.");
}

class AudioFailedUnsupportedGoogle extends AudioResponseGoogle {
  AudioFailedUnsupportedGoogle()
      : super(
            code: 415,
            reason:
                "Unsupported Media Type	It's possible that the wrong Content-Type was provided. Content-Type should be set to application/ssml+xml.");
}

class AudioFailedTooManyRequestGoogle extends AudioResponseGoogle {
  AudioFailedTooManyRequestGoogle()
      : super(
            code: 429,
            reason:
                "Too Many Requests	You have exceeded the quota or rate of requests allowed for your subscription.");
}

class AudioFailedBadGatewayGoogle extends AudioResponseGoogle {
  AudioFailedBadGatewayGoogle()
      : super(
            code: 502,
            reason:
                "Bad Gateway	Network or server-side issue. May also indicate invalid headers.");
}

class AudioFailedUnknownErrorGoogle extends AudioResponseGoogle {
  AudioFailedUnknownErrorGoogle({required int code, required String reason})
      : super(code: code, reason: reason);
}
