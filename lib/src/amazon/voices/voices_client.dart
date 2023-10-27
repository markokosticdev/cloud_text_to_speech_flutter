import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:cloud_text_to_speech/src/amazon/common/config.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:sigv4/sigv4.dart';

class VoicesClientAmazon extends BaseClient {
  VoicesClientAmazon({required http.Client client})
      : super(client: RetryClient(client));

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
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
