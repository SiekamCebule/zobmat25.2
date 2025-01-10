import 'dart:io';
import 'package:path/path.dart' as path;

File fileInDirectory({
  required Directory directory,
  required String fileNameWithoutExtension,
}) {
  final files = directory.listSync().whereType<File>();
  return files.singleWhere(
    (file) => path.basename(file.path) == fileNameWithoutExtension,
  );
}
