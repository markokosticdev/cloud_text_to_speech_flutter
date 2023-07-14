import 'package:cloud_text_to_speech/src/microsoft/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/microsoft/common/constants.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_client.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_response_mapper.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voices_responses.dart';
import 'package:http/http.dart' as http;

class VoicesHandlerMicrosoft {
  Future<VoicesSuccessMicrosoft> getVoices(
      AuthenticationHeaderMicrosoft authHeader) async {
    final client = http.Client();
    final voiceClient =
        VoicesClientMicrosoft(client: client, header: authHeader);

    try {
      final mapper = VoicesResponseMapperMicrosoft();
      final response =
          await voiceClient.get(Uri.parse(EndpointsMicrosoft.voicesList));
      final voicesResponse = mapper.map(response);
      if (voicesResponse is VoicesSuccessMicrosoft) {
        return voicesResponse;
      } else {
        throw voicesResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
