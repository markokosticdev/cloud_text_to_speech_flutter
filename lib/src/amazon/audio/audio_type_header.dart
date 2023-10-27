import 'package:cloud_text_to_speech/src/common/http/base_header.dart';

class AudioTypeHeaderAmazon extends BaseHeader {
  ///Audio format should be selected from [AudioOutputFormat] class.
  AudioTypeHeaderAmazon({required String audioFormat})
      : super(type: "X-Amazon-OutputFormat", value: audioFormat);

  @override
  String get headerValue => value;
}
