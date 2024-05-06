import 'dart:math';

import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';
import 'package:xml/xml.dart';

import 'log.dart';

class Helpers {
  Helpers._();

  static String sanitizeSsml(
      String ssml, Map<String, List<String>> allowedElements) {
    if (!ssml.trim().startsWith("<speak")) {
      ssml = "<speak>" + ssml + "</speak>";
    }

    var document = XmlDocument.parse(ssml);
    var rootElement = document.rootElement;

    _sanitizeNode(rootElement, allowedElements);

    if (!allowedElements.containsKey('speak')) {
      return rootElement.children
          .map((child) => child.toXmlString(pretty: false))
          .join();
    } else {
      return document.toXmlString(pretty: false);
    }
  }

  static void _sanitizeNode(
      XmlNode node, Map<String, List<String>> allowedElements) {
    if (node.nodeType == XmlNodeType.ELEMENT) {
      var element = node as XmlElement;

      for (var child in List.from(element.children)) {
        _sanitizeNode(child, allowedElements);
      }

      if (!allowedElements.containsKey(element.name.local)) {
        XmlNode parent = element.parent!;
        List<XmlNode> children =
            element.children.map((node) => node.copy()).toList();
        int elementIndex = parent.children.indexOf(element);
        parent.children.removeAt(elementIndex);
        parent.children.insertAll(elementIndex, children);
      } else {
        var allowedAttributes = allowedElements[element.name.local] ?? [];
        for (var attribute in element.attributes.toList()) {
          if (!allowedAttributes.contains(attribute.name.local)) {
            element.attributes.remove(attribute);
          }
        }
      }
    } else if (node.nodeType == XmlNodeType.TEXT) {
      var text = node as XmlText;
      if (text.value.trim().isEmpty) {
        text.remove();
      }
    }
  }

  static List<String> shuffleNamesByText(
    List<String> names,
    String text,
  ) {
    List<int> indices = List<int>.generate(names.length, (index) => index);

    List<int> seed = text.codeUnits.toList();
    Random random =
        Random(seed.fold<int>(0, (prev, element) => prev + element));

    for (int i = names.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      int temp = indices[i];
      indices[i] = indices[j];
      indices[j] = temp;
    }

    List<String> shuffledNames = List<String>.from(names);

    for (int i = 0; i < names.length; i++) {
      shuffledNames[indices[i]] = names[i];
    }

    return shuffledNames;
  }

  static List<T> mapVoiceNames<T extends VoiceUniversal>(List<T> voices,
      List<String> maleVoiceNames, List<String> femaleVoiceNames) {
    String locale = '';
    String gender = '';
    List<String> names = [];
    int nameIndex = 0;

    return voices.map((voice) {
      if (locale != voice.locale.code || gender != voice.gender) {
        nameIndex = 0;
        locale = voice.locale.code;
        gender = voice.gender;
        switch (gender.toLowerCase()) {
          case 'male':
            names = shuffleNamesByText(maleVoiceNames, locale);
            break;
          case 'female':
          case 'neutral':
          default:
            names = shuffleNamesByText(femaleVoiceNames, locale);
        }
      }

      if (names.isNotEmpty) {
        if (nameIndex >= names.length) {
          nameIndex = 0;
        }

        voice.name = names[nameIndex];
        voice.nativeName = names[nameIndex];
      }

      nameIndex++;
      return voice;
    }).toList(growable: false);
  }

  static List<T> removeVoiceDuplicates<T extends VoiceUniversal>(
      List<T> voices) {
    Set<String> uniqueCodes = {};

    return voices.where((voice) {
      if (uniqueCodes.contains(voice.code)) {
        return false;
      }
      uniqueCodes.add(voice.code);
      return true;
    }).toList();
  }

  static List<T> sortVoices<T extends VoiceUniversal>(List<T> voices) {
    List<T> validVoices = voices.where((voice) {
      if (voice.locale.name == null || voice.locale.name!.isEmpty) {
        Log.d("Invalid voice data, removing from sort: ${voice}");
        return false;
      }
      return true;
    }).toList();

    validVoices.sort((a, b) {
      int localeComparison = a.locale.name!.compareTo(b.locale.name!);
      if (localeComparison != 0) {
        return localeComparison;
      } else {
        return b.gender.compareTo(a.gender);
      }
    });

    return validVoices;
  }
}
