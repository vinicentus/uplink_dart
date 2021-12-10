import 'dart:io';

import 'package:storj_dart/storj_dart.dart';

void main() {
  var uplink = Uplink();

  var access = uplink.parseAccess('your_access');
  var project = uplink.openProject(access);
  var download = project.downloadObject('bucket-name', 'path/to/file.txt');
  var size = uplink.downloadInfo(download).system.content_length;
  print(size);
  var file = uplink.downloadRead(download, size);

  print(file.length);
  File('downloaded.txt').writeAsBytes(file);
}
