import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/common/http/base_response_mapper.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_responses.dart';
import 'package:http/http.dart' as http;

class AudioResponseMapperMicrosoft extends BaseResponseMapper {
  @override
  BaseResponse map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return AudioSuccessMicrosoft(audio: response.bodyBytes);
      case 400:
        return AudioFailedBadRequestMicrosoft(
            reasonPhrase: response.reasonPhrase);
      case 401:
        return AudioFailedUnauthorizedMicrosoft();
      case 415:
        return AudioFailedUnsupportedMicrosoft();
      case 429:
        return AudioFailedTooManyRequestMicrosoft();
      case 502:
        return AudioFailedBadGatewayMicrosoft();
      default:
        return AudioFailedUnknownErrorMicrosoft(
            code: response.statusCode,
            reason: response.reasonPhrase ?? response.body);
    }
  }
}
