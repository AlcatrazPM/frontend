import 'dart:convert';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:alkatrazpm/src/file_saver/FileSaver.dart';

class FileSaverDefault implements FileSaver {
  @override
  void saveFile(String filename, String text) {
    var bytes = utf8.encode(text);
    js.context.callMethod("webSaveAs", [
      html.Blob(
          [bytes],
          "text/plain;"
          "charset=utf-8"),
      filename
    ]);
  }
}
