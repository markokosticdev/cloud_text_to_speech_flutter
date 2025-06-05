import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:sigv4/sigv4.dart';

import '../common/config.dart';

class AudioClientAmazon extends BaseClient {
  AudioClientAmazon({required http.Client client}) : super(client: client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Log initial request values
    print('--- Amazon Polly Request ---');
    print('URL: ${request.url}');
    print('Method: ${request.method}');
    print('Initial Headers: ${request.headers}');
    print('Query Parameters: ${request.url.queryParameters}');
    if (request is http.Request) {
      print('Request Body: ${request.body}');
    }

    request.headers['Content-Type'] = "application/json";

    final sigv4Client = Sigv4Client(
      keyId: ConfigAmazon.keyId,
      accessKey: ConfigAmazon.accessKey,
      region: ConfigAmazon.region,
      serviceName: 'polly',
    );

    print('Region = ${ConfigAmazon.region}');

    final headers = sigv4Client.signedHeaders(
      request.url.toString(),
      method: request.method,
      query: request.url.queryParameters,
      headers: request.headers,
      body: request is http.Request ? request.body : null,
    );

    // Log signed headers
    print('Signed Headers: $headers');

    request.headers.addAll(headers);

    print('Final Headers After Merge: ${request.headers}');
    print('------------------------------');

    return client.send(request);
  }

}
