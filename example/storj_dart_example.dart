import 'dart:io';

import 'package:storj_dart/storj_dart.dart';

var accessToken = 'your_access';
var bucketName = 'bucket-name';
var filePath = 'path/to/file.txt';

var downloadDestination = 'downloaded.txt';

void main() {
  // This must be called initially, and you need to provide a path to a precompiled
  // version of the uplink-c library. This could for example be loaded from your documents folder.
  // See the readme for more information
  loadDynamicLibrary('libuplinkc.so');

  var access = DartUplinkAccess.parseAccess(accessToken);
  print(access.serialize());
  var project = DartUplinkProject.openProject(access);
  var download = project.downloadObject(bucketName, filePath);
  var size = download.info().system.content_length;
  print(size);

  final buffersize = 1024;
  var remainingBytes = size;
  // TODO: check copy param
  var fileBytes = BytesBuilder();

  // At some point in the future there will be convenience methods created for this,
  // for example returning a stream of bytes, or a whole file at once.
  while (remainingBytes > 0) {
    // We request 1024 bytes every time (meaning we use a 1024 byte long buffer),
    // but we might not get as many bytes back evey time,
    // especially not for the very last section of the file,
    // which is likely to be shorter than 1024 bytes.
    var freshBytes = download.read(buffersize);
    fileBytes.add(freshBytes);

    // Subtract the number of bytes actualy read, not the requested amount
    remainingBytes -= freshBytes.length;
    print('read ${freshBytes.length} bytes (${fileBytes.length}/$size)');
  }

  download.close();
  project.close();

  // Write to disk
  File(downloadDestination).writeAsBytes(fileBytes.toBytes());

  // Share file (create new access)
  var newAccess = access.share(DartUplinkPermission.readOnlyPermission(),
      [DartUplinkUplinkSharePrefix(bucketName, filePath)]);
  print(newAccess.serialize());

  // Get file info using new access
  var newProject = DartUplinkProject.openProject(newAccess);
  var newDownload = newProject.downloadObject(bucketName, filePath);
  print(newDownload.info().system.content_length);
  newDownload.close();
  newProject.close();

  // TODO: download data and check that downloaded data is the same as uploaded
}
