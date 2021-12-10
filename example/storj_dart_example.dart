import 'dart:io';

import 'package:storj_dart/storj_dart.dart';

void main() {
  var uplink = Uplink();

  var access = uplink.parseAccess('access');
  var project = uplink.openProject(access);
  var download = uplink.downloadObject(project, 'bucketName', 'path');
  var size = uplink.getSize(uplink.downloadInfo(download));
  print(size);
  var file = uplink.downloadRead(download, size);

  print(file.length);
  File('downloaded.txt').writeAsBytes(file);
}
