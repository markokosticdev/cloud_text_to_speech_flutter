import 'config.dart';

class EndpointsGoogle {
  EndpointsGoogle._();

  /// Endpoint to retrieve a list of available voices.
  static String get voices => "https://texttospeech.googleapis.com/v1/voices";

  /// Endpoint for synthesizing speech from text.
  static String get tts =>
      "https://texttospeech.googleapis.com/v1/text:synthesize";

  /// Endpoint to access project-specific settings or resources.
  static String get projectId =>
      "https://texttospeech.googleapis.com/v1/projects/${ConfigGoogle.projectId}";

  /// Endpoint for accessing custom voice models or other configurations.
  static String get customConfig =>
      "https://texttospeech.googleapis.com/v1/projects/${ConfigGoogle.projectId}/custom";
}
