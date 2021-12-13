import 'dart:io';

import 'package:storj_dart/storj_dart.dart';

void main() {
  var access = DartUplinkAccess.parseAccess('your_access');
  var project = DartUplinkProject.openProject(access);
  var download = project.downloadObject('bucket-name', 'path/to/file.txt');
  var size = download.info().system.content_length;
  print(size);
  var file = download.read(size);
  print(file.length);

  File('downloaded.txt').writeAsBytes(file);
}
