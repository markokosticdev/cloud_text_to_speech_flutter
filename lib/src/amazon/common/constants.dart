import 'package:cloud_text_to_speech/src/amazon/common/config.dart';

class EndpointsAmazon {
  EndpointsAmazon._();

  /// Endpoint to retrieve a list of available voices.
  static String get voices =>
      "https://polly.${ConfigAmazon.region}.amazonaws.com/v1/voices";

  /// Endpoint for synthesizing speech from text.
  static String get tts =>
      "https://polly.${ConfigAmazon.region}.amazonaws.com/v1/speech";

  /// Endpoint for lexicon operations.
  static String get lexicon =>
      "https://polly.${ConfigAmazon.region}.amazonaws.com/v1/lexicons";

  /// Endpoint for pronunciation lexicons.
  static String get pronunciation =>
      "https://polly.${ConfigAmazon.region}.amazonaws.com/v1/pronunciation";
}
