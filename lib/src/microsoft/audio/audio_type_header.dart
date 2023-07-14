import 'package:cloud_text_to_speech/src/common/http/base_header.dart';

class AudioTypeHeaderMicrosoft extends BaseHeader {
  ///Audio format should be selected from [AudioOutputFormat] class.
  AudioTypeHeaderMicrosoft({required String audioFormat})
      : super(type: "X-Microsoft-OutputFormat", value: audioFormat);

  @override
  String get headerValue => value;
}
