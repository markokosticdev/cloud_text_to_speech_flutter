import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';

class SsmlGoogle {
  SsmlGoogle({required this.text, required this.rate, required this.pitch});

  final String text;
  final String rate;
  final String pitch;

  String get rawSsml {
    return ssmlRoot(text);
  }

  String get sanitizedSsml {
    return ssmlRoot(sanitizeSsml(text));
  }

  String ssmlRoot(String ssml) {
    return '<speak version="1.0" '
        'xmlns="http://www.w3.org/2001/10/synthesis" '
        '<prosody rate="$rate" pitch="$pitch">'
        '$ssml'
        '</prosody></speak>';
  }

  String sanitizeSsml(String ssml) {
    Map<String, List<String>> allowedElements = {
      'break': ['time', 'strength'],
      'say-as': [
        'interpret-as',
        'language',
        'google:style',
        'format',
        'detail'
      ],
      'audio': [
        'src',
        'clipBegin',
        'clipEnd',
        'speed',
        'repeatCount',
        'repeatDur',
        'soundLevel'
      ],
      'p': [],
      's': [],
      'sub': ['alias'],
      'mark': ['name'],
      'emphasis': ['level'],
      'par': [],
      'seq': [],
      'media': [
        'xml:id',
        'begin',
        'end',
        'repeatCount',
        'repeatDur',
        'soundLevel',
        'fadeInDur',
        'fadeOutDur'
      ],
      'phoneme': ['alphabet', 'ph'],
      'voice': ['name', 'gender', 'variant', 'language', 'ordering'],
      'lang': ['xml:lang'],
    };

    return Helpers.sanitizeSsml(ssml, allowedElements);
  }
}
