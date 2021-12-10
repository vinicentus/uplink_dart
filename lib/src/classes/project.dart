import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:storj_dart/generated/generated_bindings.dart';
import 'package:storj_dart/src/helpers.dart';

class DartUplinkProject {
  // TODO: think about how to expose this so that all internal classes can use it, maybe GetIt? Does it makse more sense than passing it in the constructor?
  final NativeLibrary _nativeLib;
  final Pointer<UplinkProject> _nativeProject;
  DartUplinkProject(this._nativeProject, this._nativeLib);

  abortUpload() {
    throw UnimplementedError();
  }

  beginUpload() {
    throw UnimplementedError();
  }

  // TODO
  close() {
    throw UnimplementedError();
  }

  commitUpload() {
    throw UnimplementedError();
  }

  createBucket() {
    throw UnimplementedError();
  }

  deleteBucket() {
    throw UnimplementedError();
  }

  deleteBucketWithObjects() {
    throw UnimplementedError();
  }

  deleteObject() {
    throw UnimplementedError();
  }

  // TODO: change return type
  Pointer<UplinkDownload> downloadObject(String bucketName, String path,
      [Pointer<UplinkDownloadOptions>? downloadOptions]) {
    // If no downloadOptions are passed, we have to allocate
    // This is the same as calloc.allocate(sizeOf<UplinkDownloadOptions>());
    // downloadOptions ??= calloc.call<UplinkDownloadOptions>();
    downloadOptions ??= nullptr;

    var bucketNameInt = bucketName.stringToInt8Pointer();
    var pahtInt = path.stringToInt8Pointer();
    var result = _nativeLib.uplink_download_object(
        _nativeProject, bucketNameInt, pahtInt, downloadOptions);

    calloc.free(bucketNameInt);
    calloc.free(pahtInt);
    calloc.free(downloadOptions);

    throwIfError(result.error);
    return result.download;
  }

  ensureBucket() {
    throw UnimplementedError();
  }

  listBuckets() {
    throw UnimplementedError();
  }

  listObjects() {
    throw UnimplementedError();
  }

  listUploadParts() {
    throw UnimplementedError();
  }

  listUploads() {
    throw UnimplementedError();
  }

  moveObject() {
    throw UnimplementedError();
  }

  revokeAccess() {
    throw UnimplementedError();
  }

  statBucket() {
    throw UnimplementedError();
  }

  statObject() {
    throw UnimplementedError();
  }

  updateObjectMetadata() {
    throw UnimplementedError();
  }

  uploadObject() {
    throw UnimplementedError();
  }

  uploadPart() {
    throw UnimplementedError();
  }
}
