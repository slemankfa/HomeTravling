
import 'dart:io';

String fixtuer(String name) => File("test/fixtuers/$name").readAsStringSync();