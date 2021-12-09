import 'package:storj_dart/storj_dart.dart';

void main() {
  var uplink = Uplink();

  var access = uplink.parseAccess('access');
  var project = uplink.openProject(access);
  var download = uplink.downloadObject(project, 'bucketName', 'path');
  var file = uplink.downloadRead(download, 10);

  print(file);
}
