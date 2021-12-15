import 'dart:io';

// This library contains asynchronous convenience wrappers around the main library
import 'package:storj_dart/convenience_lib.dart';
// Main library with an API similar to the go library
import 'package:storj_dart/storj_dart.dart';

var accessToken = 'your_access';
var bucketName = 'bucket-name';
var filePath = 'path/to/file.txt';

var downloadDestination = 'downloaded.txt';

void main() async {
  // This must be called initially, and you need to provide a path to a precompiled
  // version of the uplink-c library. This could for example be loaded from your documents folder.
  // See the readme for more information
  loadDynamicLibrary('libuplinkc.so');

  var access = DartUplinkAccess.parseAccess(accessToken);
  print(access.serialize());
  var project = DartUplinkProject.openProject(access);

  var bytes = await project.downloadBytesFuture(bucketName, filePath);

  project.close();

  // Write to disk
  File(downloadDestination).writeAsBytes(bytes);
}
