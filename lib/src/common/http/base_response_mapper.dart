import 'package:cloud_text_to_speech/src/common/http/base_response.dart';
import 'package:http/http.dart' as http;

abstract class BaseResponseMapper {
  BaseResponse map(http.Response response);
}
