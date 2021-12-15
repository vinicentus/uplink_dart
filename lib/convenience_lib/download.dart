import 'dart:io';

import 'dart:typed_data';

import 'package:uplink_dart/src/classes_lib.dart';

// TODO: decide wether it is a good idea to introduce asynchronous code into this library
extension Download on DartUplinkProject {
  /// Used to download a whole object
  Future<Uint8List> downloadBytesFuture(String bucketName, String filePath,
      {final bufferSize = 256}) async {
    var buffer = BytesBuilder();
    await for (final event in downloadByteStream(bucketName, filePath)) {
      buffer.add(event);
    }
    return buffer.toBytes();

    // This doesn't work because Uint8Lists aren't growable...
    // return downloadByteStream(bucketName, filePath)
    //     .reduce((previous, element) => previous..addAll(element));
  }

  /// Supposed to be more convenient for dart users than the original
  /// [DartUplinkProject.downloadObject] combined with [DartUplinkDownload.read].
  /// The [bufferSize] represents the number of bytes that this tries to read
  /// and return in every stream event. Note that the actual number of returned
  /// bytes per stream event can vary.
  ///
  /// This is relaitvely similar to [File.openRead]. Except that the returned
  /// streams are not growable, but instead more memory efficient.
  Stream<Uint8List> downloadByteStream(String bucketName, String filePath,
      {final bufferSize = 256}) async* {
    var download = downloadObject(bucketName, filePath);
    var size = download.info().system.content_length;

    var remainingBytes = size;

    try {
      while (remainingBytes > 0) {
        // We request [bufferSize] bytes every time (meaning we use a [bufferSize] byte long buffer),
        // but we might not get as many bytes back evey time,
        // especially not for the very last section of the file,
        // which is likely to be shorter than [bufferSize] bytes.
        var freshBytes = download.read(bufferSize);

        // Subtract the number of bytes actualy read, not the requested amount
        remainingBytes -= freshBytes.length;

        yield freshBytes;
      }
    } finally {
      // This weird looking try / finally statement exists only to make sure
      // that we close the download object, even if the stream was caneled.
      // TODO: add tests such as:
      // project
      //     .downloadByteStream(bucketName, filePath)
      //     .listen((event) {})
      //     .cancel();
      print('close() called from stream');
      download.close();
    }
  }
}
