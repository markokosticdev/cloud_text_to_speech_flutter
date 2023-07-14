import 'package:cloud_text_to_speech/src/universal/voices/voice_model.dart';

class InitParamsGoogle {
  final String apiKey;

  InitParamsGoogle({
    required this.apiKey,
  });
}

class InitParamsMicrosoft {
  final String subscriptionKey;
  final String region;

  InitParamsMicrosoft({
    required this.subscriptionKey,
    required this.region,
  });
}

class TtsParamsUniversal {
  final VoiceUniversal voice;
  final String text;
  final String audioFormatGoogle;
  final String audioFormatMicrosoft;
  final String rate;
  final String pitch;

  TtsParamsUniversal({
    required this.voice,
    required this.text,
    required this.audioFormatGoogle,
    required this.audioFormatMicrosoft,
    required this.rate,
    required this.pitch,
  });
}
