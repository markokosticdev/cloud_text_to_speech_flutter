import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:cloud_text_to_speech/src/amazon/audio/audio_type_header.dart';
import 'package:cloud_text_to_speech/src/amazon/auth/authentication_types.dart';
import 'package:http/http.dart' as http;
import 'package:sigv4/sigv4.dart';

import '../common/config.dart';

class AudioClientAmazon extends BaseClient {
  AudioClientAmazon({required http.Client client}) : super(client: client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Content-Type'] = "application/json";

    final sigv4Client = Sigv4Client(
      keyId: ConfigAmazon.keyId,
      accessKey: ConfigAmazon.accessKey,
      region: ConfigAmazon.region,
      serviceName: 'polly',
    );

    final headers = sigv4Client.signedHeaders(
      request.url.toString(),
      method: request.method,
      query: request.url.queryParameters,
      headers: request.headers,
      body: request is http.Request ? request.body : null,
    );

    request.headers.addAll(headers);

    return client.send(request);
  }
}
