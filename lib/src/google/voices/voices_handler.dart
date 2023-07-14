import 'package:cloud_text_to_speech/src/google/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/google/common/constants.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_client.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_response_mapper.dart';
import 'package:cloud_text_to_speech/src/google/voices/voices_responses.dart';
import 'package:http/http.dart' as http;

class VoicesHandlerGoogle {
  Future<VoicesSuccessGoogle> getVoices(
      AuthenticationHeaderGoogle authHeader) async {
    final client = http.Client();
    final voiceClient = VoicesClientGoogle(client: client, header: authHeader);

    try {
      final mapper = VoicesResponseMapperGoogle();
      final response =
          await voiceClient.get(Uri.parse(EndpointsGoogle.voicesList));
      final voicesResponse = mapper.map(response);
      if (voicesResponse is VoicesSuccessGoogle) {
        return voicesResponse;
      } else {
        throw voicesResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
