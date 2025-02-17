import 'dart:convert';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

Future<void> startLocalServer() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final fileSystemPath = p.join(appDocDir.path, 'webr-0.4.2');
  debugPrint('📂 Resolved absolute path: $fileSystemPath');
  // ✅ Extract assets before serving
  await extractZipToDirectory(fileSystemPath);
  if (!Directory(fileSystemPath).existsSync()) {
    debugPrint('❌ Directory does not exist: $fileSystemPath');
    return;
  }

  final handler = const Pipeline().addHandler(
    createStaticHandler(
      fileSystemPath,
      // defaultDocument: 'index.html',
      useHeaderBytesForContentType: true,
      listDirectories: true, // ✅ Enable directory listing
    ),
  );

  final server = await io.serve(handler, '127.0.0.1', 8080);
  debugPrint('🚀 Serving at http://${server.address.host}:${server.port}');
}

Future<void> extractZipToDirectory(String targetDir) async {
  try {
    final zipAssetPath = 'assets/webr-0.4.2.zip';

    // ✅ Load ZIP from Flutter assets
    final byteData = await rootBundle.load(zipAssetPath);
    final zipBytes = byteData.buffer.asUint8List();

    // ✅ Decode ZIP file
    final archive = ZipDecoder().decodeBytes(zipBytes);

    // ✅ Ensure the target directory exists
    final targetDirExists = Directory(targetDir).existsSync();
    if (targetDirExists) {
      debugPrint('🗑️ Deleting old assets at $targetDir');
      Directory(targetDir).deleteSync(recursive: true);
    }
    Directory(targetDir).createSync(recursive: true);

    // ✅ Extract each file
    for (final file in archive) {
      final filePath = p.join(targetDir, file.name);
      if (file.isFile) {
        debugPrint('🟡 Extracting: $filePath');
        final extractedFile = File(filePath);
        extractedFile.parent.createSync(recursive: true);
        extractedFile.writeAsBytesSync(file.content as List<int>);
      }
    }

    debugPrint('✅ Extraction complete!');
  } catch (e) {
    debugPrint('❌ Error extracting ZIP: $e');
  }
}
