import 'dart:convert';

import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:cloud_text_to_speech/src/common/http/base_response_mapper.dart';
import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voice_model.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_responses.dart';
import 'package:http/http.dart' as http;

class VoicesResponseMapperMicrosoft extends BaseResponseMapper {
  @override
  BaseResponse map(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          String utfDecodedResponse = utf8.decode(response.bodyBytes);

          final json = jsonDecode(utfDecodedResponse) as List<dynamic>;
          var voices = json
              .map((e) => VoiceMicrosoft.fromJson(e as Map<String, dynamic>))
              .toList(growable: false);

          voices = Helpers.removeVoiceDuplicates(voices);

          voices = Helpers.sortVoices(voices);

          return VoicesSuccessMicrosoft(voices: voices);
        }
      case 400:
        return VoicesFailedBadRequestMicrosoft(
            reasonPhrase: response.reasonPhrase);
      case 401:
        return VoicesFailedUnauthorizedMicrosoft();
      case 429:
        return VoicesFailedTooManyRequestsMicrosoft();
      case 502:
        return VoicesFailedBadGateWayMicrosoft();
      default:
        return VoicesFailedUnknownErrorMicrosoft(
            code: response.statusCode,
            reason: response.reasonPhrase ?? response.body);
    }
  }
}
