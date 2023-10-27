import 'package:cloud_text_to_speech/src/amazon/auth/authentication_types.dart';
import 'package:cloud_text_to_speech/src/amazon/common/constants.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_client.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_response_mapper.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voices_responses.dart';
import 'package:http/http.dart' as http;

class VoicesHandlerAmazon {
  Future<VoicesSuccessAmazon> getVoices() async {
    final client = http.Client();
    final voiceClient = VoicesClientAmazon(client: client);

    try {
      final mapper = VoicesResponseMapperAmazon();
      final response = await voiceClient.get(Uri.parse(EndpointsAmazon.voices));
      final voicesResponse = mapper.map(response);
      if (voicesResponse is VoicesSuccessAmazon) {
        return voicesResponse;
      } else {
        throw voicesResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
