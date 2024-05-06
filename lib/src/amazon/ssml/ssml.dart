import 'package:cloud_text_to_speech/src/common/utils/helpers.dart';

class SsmlAmazon {
  SsmlAmazon({required this.text, required this.rate, required this.pitch});

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
        'xmlns="http://www.w3.org/2001/10/synthesis">'
        '<prosody rate="$rate" pitch="$pitch">'
        '$ssml'
        '</prosody></speak>';
  }

  String sanitizeSsml(String ssml) {
    Map<String, List<String>> allowedElements = {
      'amazon:domain': ['name'],
      'amazon:effect': ['name', 'phonation', 'vocal-tract-length'],
      'break': ['time', 'strength'],
      'emphasis': ['level'],
      'lang': [],
      'mark': [],
      'p': [],
      'phoneme': [],
      's': [],
      'say-as': [],
      'sub': [],
      'w': [],
    };

    return Helpers.sanitizeSsml(ssml, allowedElements);
  }
}
