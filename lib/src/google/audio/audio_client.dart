import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:cloud_text_to_speech/src/google/auth/authentication_types.dart';
import 'package:http/http.dart' as http;

class AudioClientGoogle extends BaseClient {
  AudioClientGoogle(
      {required http.Client client,
      required AuthenticationHeaderGoogle authHeader})
      : super(client: client, header: authHeader);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[header.type] = header.value;
    request.headers['Content-Type'] = "application/json";
    return client.send(request);
  }
}
