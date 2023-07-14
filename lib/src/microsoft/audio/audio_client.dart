import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:cloud_text_to_speech/src/microsoft/audio/audio_type_header.dart';
import 'package:cloud_text_to_speech/src/microsoft/auth/authentication_types.dart';
import 'package:http/http.dart' as http;

class AudioClientMicrosoft extends BaseClient {
  AudioClientMicrosoft(
      {required http.Client client,
      required AuthenticationHeaderMicrosoft authHeader,
      required AudioTypeHeaderMicrosoft audioTypeHeader})
      : _audioTypeHeader = audioTypeHeader,
        super(client: client, header: authHeader);
  final AudioTypeHeaderMicrosoft _audioTypeHeader;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[header.type] = header.value;
    request.headers[_audioTypeHeader.type] = _audioTypeHeader.value;
    request.headers['Content-Type'] = "application/ssml+xml";
    return client.send(request);
  }
}
