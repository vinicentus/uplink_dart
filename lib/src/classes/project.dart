part of classes;

class DartUplinkProject {
  // TODO: Does it makse  sense to pass this in the constructor?
  final NativeLibrary _nativeLib;
  // This is late because we need to call a c function to get a reference in the constructor
  // Also notice that this is a pointer and as such is backed by a native C variable
  // TODO: make sure that all the pointers inside these kinds of classes are freed when not needed!
  late final Pointer<UplinkProject> _nativeProject;

  DartUplinkProject._fromNative(this._nativeProject)
      : _nativeLib = _nativeLibrary;

  DartUplinkProject.openProject(DartUplinkAccess access)
      : _nativeLib = _nativeLibrary {
    var result = _nativeLib.uplink_open_project(access._nativeAccess);

    throwIfError(result.error);
    _nativeProject = result.project;
  }

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
  DartUplinkDownload downloadObject(String bucketName, String path,
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
    return DartUplinkDownload._fromNative(result.download);
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
