import 'package:cloud_text_to_speech/src/microsoft/audio/audio_client.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_request_param.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_response_mapper.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_type_header.dart';
import 'package:cloud_text_to_speech/src/microsoft/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/microsoft/common/constants.dart';
import 'package:cloud_text_to_speech/src/microsoft/ssml/ssml.dart';
import 'package:http/http.dart' as http;

class AudioHandlerMicrosoft {
  Future<AudioSuccessMicrosoft> getAudio(AudioRequestParamsMicrosoft params,
      AuthenticationHeaderMicrosoft authHeader) async {
    final mapper = AudioResponseMapperMicrosoft();
    final audioClient = AudioClientMicrosoft(
        client: http.Client(),
        authHeader: authHeader,
        audioTypeHeader:
            AudioTypeHeaderMicrosoft(audioFormat: params.audioFormat));

    try {
      final ssml = SsmlMicrosoft(
          text: params.text,
          rate: params.rate,
          pitch: params.pitch,
          voice: params.voice);

      final response = await audioClient
          .post(Uri.parse(EndpointsMicrosoft.audio), body: ssml.sanitizedSsml);
      final audioResponse = mapper.map(response);
      if (audioResponse is AudioSuccessMicrosoft) {
        return audioResponse;
      } else {
        throw audioResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
