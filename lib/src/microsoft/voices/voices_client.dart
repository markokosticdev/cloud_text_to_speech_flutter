import 'package:cloud_text_to_speech/src/common/http/base_client.dart';
import 'package:cloud_text_to_speech/src/microsoft/auth/authentication_types.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class VoicesClientMicrosoft extends BaseClient {
  VoicesClientMicrosoft(
      {required http.Client client,
      required AuthenticationHeaderMicrosoft header})
      : super(client: RetryClient(client), header: header);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[header!.type] = header!.headerValue;

    return client.send(request);
  }
}
