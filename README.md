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

This repository relies on you to compile a verision of [uplink-c](https://github.com/storj/uplink-c)

General steps:
1. install go
2. clone uplink-c to a directory of your choice
3. `run go build -o libuplinkc.so -buildmode=c-shared`
4. for building on windows, see https://github.com/storj-thirdparty/uplink-python#initial-set-up-important
5. Copy the resulting binary (libuplinkc.so) to this directory (inside storj.dart repository)
6. copy over libuplinkc.h, uplink_definitions.h, uplink_compat.h, if you want to generate bindings based on them.

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
