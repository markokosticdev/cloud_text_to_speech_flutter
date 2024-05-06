import 'package:cloud_text_to_speech/src/amazon/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/amazon/voices/voice_model.dart';
import 'package:cloud_text_to_speech/src/google/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/google/voices/voice_model.dart';
import 'package:cloud_text_to_speech/src/microsoft/tts/tts_params.dart';
import 'package:cloud_text_to_speech/src/microsoft/voices/voice_model.dart';
import 'package:cloud_text_to_speech/src/universal/audio/audio_output_format_mapper.dart';
import 'package:cloud_text_to_speech/src/universal/tts/tts_params.dart';

class TtsParamsMapper {
  static TtsParamsGoogle toGoogle(TtsParamsUniversal universalParams) {
    return TtsParamsGoogle(
      voice: VoiceGoogle(
        engines: universalParams.voice.engines,
        code: universalParams.voice.code,
        name: universalParams.voice.name,
        nativeName: universalParams.voice.nativeName,
        gender: universalParams.voice.gender,
        locale: universalParams.voice.locale,
      ),
      text: universalParams.text,
      audioFormat:
          AudioOutputFormatMapper.toGoogle(universalParams.audioFormat),
      rate: universalParams.rate,
      pitch: universalParams.pitch,
    );
  }

  static TtsParamsMicrosoft toMicrosoft(TtsParamsUniversal universalParams) {
    return TtsParamsMicrosoft(
      voice: VoiceMicrosoft(
        engines: universalParams.voice.engines,
        code: universalParams.voice.code,
        name: universalParams.voice.name,
        nativeName: universalParams.voice.nativeName,
        gender: universalParams.voice.gender,
        locale: universalParams.voice.locale,
      ),
      text: universalParams.text,
      audioFormat:
          AudioOutputFormatMapper.toMicrosoft(universalParams.audioFormat),
      rate: universalParams.rate,
      pitch: universalParams.pitch,
    );
  }

  static TtsParamsAmazon toAmazon(TtsParamsUniversal universalParams) {
    return TtsParamsAmazon(
      voice: VoiceAmazon(
        engines: universalParams.voice.engines,
        code: universalParams.voice.code,
        name: universalParams.voice.name,
        nativeName: universalParams.voice.nativeName,
        gender: universalParams.voice.gender,
        locale: universalParams.voice.locale,
      ),
      text: universalParams.text,
      audioFormat:
          AudioOutputFormatMapper.toAmazon(universalParams.audioFormat),
      rate: universalParams.rate,
      pitch: universalParams.pitch,
    );
  }
}
