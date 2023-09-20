import 'dart:io';

/// helper function to read fixture json files
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
