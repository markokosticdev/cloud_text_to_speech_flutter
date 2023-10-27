import 'package:cloud_text_to_speech/src/microsoft/common/config.dart';

class EndpointsMicrosoft {
  EndpointsMicrosoft._();

  /// Endpoint to retrieve a list of available voices.
  static String get voices =>
      "https://${ConfigMicrosoft.region}.tts.speech.microsoft.com/cognitiveservices/voices/list";

  /// Endpoint for synthesizing speech from text.
  static String get tts =>
      "https://${ConfigMicrosoft.region}.tts.speech.microsoft.com/cognitiveservices/v1";

  /// Endpoint for handling long audio requests, typically for converting large text files to audio.
  static String get longAudio =>
      "https://${ConfigMicrosoft.region}.customvoice.api.speech.microsoft.com";

  /// Endpoint to retrieve a list of custom voices, if any are available for use.
  static String get customVoicesList =>
      "https://${ConfigMicrosoft.region}.voice.speech.microsoft.com/cognitiveservices/v1?deploymentId=";

  /// Endpoint to obtain an Access Token for authenticating API requests.
  static String get issueToken =>
      "https://${ConfigMicrosoft.region}.api.cognitive.microsoft.com/sts/v1.0/issueToken";
}
