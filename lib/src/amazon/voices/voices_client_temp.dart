import 'package:cloud_text_to_speech/src/amazon/common/config.dart';
import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:cloud_text_to_speech/src/amazon/auth/authentication_types.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:sigv4/sigv4.dart';

class VoicesClientAmazon extends BaseClient {
  VoicesClientAmazon({
    required http.Client client,
  }) : super(client: RetryClient(client));

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final sigv4Client = Sigv4Client(
      keyId: ConfigAmazon.keyId,
      accessKey: ConfigAmazon.accessKey,
      region: ConfigAmazon.region,
      serviceName: 'polly',
    );

    final headers = sigv4Client.signedHeaders(request.url.toString(),
        method: request.method,
        query: request.url.queryParameters,
        headers: request.headers,
        body: request is http.Request ? request.body : null,
        dateTime: DateTime.now()
            .toUtc() //.add(Duration(minutes: 5))
            .toString()
            .replaceAll(RegExp(r'\.\d*Z$'), 'Z')
            .replaceAll(RegExp(r'[:-]|\.\d{3}'), '')
            .split(' ')
            .join('T'));

    request.headers.addAll(headers);

    return client.send(request);
  }
}

// import 'package:aws_request/aws_request.dart';
// import 'package:cloud_text_to_speech/src/amazon/common/config.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';
//
// class VoicesClientAmazon {
//   final AwsRequest _client;
//
//   VoicesClientAmazon({required AwsRequest client }): _client = client;
//
//   Future<http.Response> get(Uri uri) async {
//
//     final result = await _client.send(
//       type: AwsRequestType.get,
//       queryPath: uri.path,
//       service: 'polly',
//     );
//
//     print(result.body.toString());
//
//     return result;
//   }
//
//   AwsRequest get client => _client;
// }

// import 'package:aws_auth/aws_auth.dart';
// import 'package:cloud_text_to_speech/src/amazon/common/config.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';
//
// import '../../common/http/base_client.dart';
//
// class VoicesClientAmazon extends BaseClient {
//   VoicesClientAmazon({required http.Client client }): super(client: RetryClient(client));
//
//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//
//     final credentialsProvider = AWSStaticCredentialsProvider(
//         ConfigAmazon.keyId,
//         ConfigAmazon.accessKey
//     );
//
//     print(ConfigAmazon.keyId + ' ' + ConfigAmazon.accessKey + ' ' + ConfigAmazon.region);
//
//     final signer = AWS4Signer(
//       credentialsProvider,
//       region: ConfigAmazon.region,
//       serviceName:'polly',
//     );
//
//     final req = AWSRequest.formData(
//         request.url
//     );
//
//     signer.sign(req);
//
//     request.headers.addAll(req.headers);
//
//
//     return client.send(request);
//   }
// }
