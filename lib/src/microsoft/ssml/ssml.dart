import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voice_model.dart';

class SsmlMicrosoft {
  SsmlMicrosoft(
      {required this.text,
      required this.rate,
      required this.pitch,
      required this.voice});

  final String text;
  final String rate;
  final String pitch;
  final VoiceMicrosoft voice;

  String get rawSsml {
    return ssmlRoot(text);
  }

  String get sanitizedSsml {
    return ssmlRoot(sanitizeSsml(text));
  }

  String ssmlRoot(String ssml) {
    return '<speak version="1.0" '
        'xmlns="http://www.w3.org/2001/10/synthesis" '
        'xml:lang="${voice.locale.code}">'
        '<voice xml:lang="${voice.locale.code}" '
        'xml:gender="${voice.gender}" '
        'name="${voice.code}">'
        '<prosody rate="$rate" pitch="$pitch">'
        '$ssml'
        '</prosody></voice></speak>';
  }

  String sanitizeSsml(String ssml) {
    Map<String, List<String>> allowedElements = {
      'voice': ['name', 'effect'],
      'audio': ['src'],
      'bookmark': ['mark'],
      'break': ['time', 'strength'],
      'emphasis': ['level'],
      'lang': ['xml:lang'],
      'lexicon': ['uri'],
      'math': ['xmlns'],
      'mstts:audioduration': ['value'],
      'mstts:express-as': ['style', 'styledegree', 'role'],
      'mstts:silence': ['type', 'value'],
      'mstts:viseme': ['type'],
      'p': [],
      'phoneme': ['alphabet', 'ph'],
      's': [],
      'say-as': ['interpret-as', 'format', 'detail'],
      'sub': ['alias'],
    };

    return Helpers.sanitizeSsml(ssml, allowedElements);
  }
}
