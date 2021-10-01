import 'package:clipboard/clipboard.dart';

class Clipboard {
  Future<Map<String, String>> getOrderanFromClipboard() async {
    String clipboardText = await FlutterClipboard.paste();
    Map<String, String> listOrderan = {};

    List<String> texts = clipboardText.split('\n');

    if (texts[0] == '[Format Order') {
      for (String subText in texts) {
        if (subText.contains(':')) {
          List<String> subTexts = subText.split(':');
          listOrderan[subTexts[0]] = subTexts[1].trim();
        }
      }
      return listOrderan;
    } else return listOrderan;
  }
}