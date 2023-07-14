class EndpointsGoogle {
  EndpointsGoogle._();

  ///Endpoint used to get the list of voices supported by the endpoint.
  static String get voicesList =>
      "https://texttospeech.googleapis.com/v1/voices";

  ///Endpoint used to get the list of voices supported by the endpoint.
  static String get customVoicesList => "";

  static String get longAudio => "";

  static String get audio =>
      "https://texttospeech.googleapis.com/v1/text:synthesize";
}
