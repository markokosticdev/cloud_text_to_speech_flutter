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
    String ssmlWithRoot =
        '<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis">'
        '<prosody rate="$rate" pitch="$pitch">'
        '$ssml'
        '</prosody>'
        '</speak>';

    return ssmlWithRoot.replaceAll(RegExp(r'\s*\n\s*'), '').replaceAllMapped(
        RegExp(r'\s*(<[^>]+>)\s*'), (match) => '${match.group(1)}');
  }

  String sanitizeSsml(String ssml) {
    Map<String, List<String>> allowedElements = {
      'audio': [
        'src',
        'clipBegin',
        'clipEnd',
        'speed',
        'repeatCount',
        'repeatDur',
        'soundLevel'
      ],
      'break': ['time', 'strength'],
      'emphasis': ['level'],
      'lang': ['xml:lang'],
      'mark': ['name'],
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
      'p': [],
      'par': [],
      'phoneme': ['alphabet', 'ph'],
      's': [],
      'say-as': [
        'interpret-as',
        'language',
        'google:style',
        'format',
        'detail'
      ],
      'seq': [],
      'sub': ['alias'],
    };

    return Helpers.sanitizeSsml(ssml, allowedElements);
  }
}
