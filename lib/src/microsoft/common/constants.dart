import 'package:cloud_text_to_speech/src/microsoft/common/config.dart';

class EndpointsMicrosoft {
  EndpointsMicrosoft._();

  ///Endpoint used to get Access Token for requests authentication.
  static String get issueToken =>
      "https://${ConfigMicrosoft.region}.api.cognitive.microsoft.com/sts/v1.0/issueToken";

  ///Endpoint used to get the list of voices supported by the endpoint.
  static String get voicesList =>
      "https://${ConfigMicrosoft.region}.tts.speech.microsoft.com/cognitiveservices/voices/list";

  ///Endpoint used to get the list of voices supported by the endpoint.
  static String get customVoicesList =>
      "https://${ConfigMicrosoft.region}.voice.speech.microsoft.com/cognitiveservices/v1?deploymentId=";

  static String get longAudio =>
      "https://${ConfigMicrosoft.region}.customvoice.api.speech.microsoft.com";

  static String get audio =>
      "https://${ConfigMicrosoft.region}.tts.speech.microsoft.com/cognitiveservices/v1";
}
