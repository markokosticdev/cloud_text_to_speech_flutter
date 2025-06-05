import 'dart:convert';

import 'package:cloud_text_to_speech/src/amazon/audio/audio_client.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_request_param.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_response_mapper.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_responses.dart';
import 'package:cloud_text_to_speech/src/amazon/common/constants.dart';
import 'package:cloud_text_to_speech/src/amazon/ssml/ssml.dart';
import 'package:http/http.dart' as http;

class AudioHandlerAmazon {
  Future<AudioSuccessAmazon> getAudio(AudioRequestParamsAmazon params) async {
    final client = http.Client();
    final audioClient = AudioClientAmazon(client: client);
    final mapper = AudioResponseMapperAmazon();

    try {
      final ssml =
          SsmlAmazon(text: params.text, rate: params.rate, pitch: params.pitch);

      final Map<String, dynamic> body = {
        'OutputFormat': params.audioFormat,
        'Text': params.voice.isSsml?ssml.sanitizedSsml:params.text,
        'TextType':params.voice.isSsml? 'ssml':'text',
        'VoiceId': params.voice.code,
        'Engine': params.voice.engines.first
      };

      final String bodyJson = jsonEncode(body);
      print('api = ${EndpointsAmazon.tts} body = ${jsonEncode(body)}');

      final response = await audioClient.post(Uri.parse(EndpointsAmazon.tts),
          body: bodyJson);
      final audioResponse = mapper.map(response);
      if (audioResponse is AudioSuccessAmazon) {
        return audioResponse;
      } else {
        throw audioResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
