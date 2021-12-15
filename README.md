<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# storj.dart
Dart wrapper for the Uplink (Storj) GO library

This repository currently relies on you to compile a verision of [uplink-c](https://github.com/storj/uplink-c)

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

### Instalation steps
1. install go, add it to your path
2. clone uplink-c to a directory of your choice
3. from within that repository directory, run `go build -o libuplinkc.so -buildmode=c-shared`. (For more info about building on different platforms, see https://github.com/storj-thirdparty/uplink-python#initial-set-up-important)
5. Copy the resulting binary `libuplinkc.so` to a directory of your choice, and specify the path in the mandatory initial call to `loadDynamicLibrary(String path)`, for example `loadDynamicLibrary('/home/username/libuplinkc.so');`

## Usage

There is a short example in the `/example` folder.

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.

### Contributing

If you wish contribute to regenerate the `generated_bindings.dart`. You need to also copy over `libuplinkc.h`, `uplink_definitions.h`, `uplink_compat.h` from uplink-c. Then you can run `dart run ffigen`.
