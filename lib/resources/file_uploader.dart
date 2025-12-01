import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart';

import 'env_config.dart';

class FileUploadToDrive {
  static Future<String> uploadAndGetUrl({
    required PlatformFile file,
    required String pdi,
    required String carpeta,
  }) async {
    Uri url = Uri.parse(EnvConfig.googleScriptFileUploadUrl);
    var bytes = file.bytes!;
    var s = base64.encode(bytes);
    final mimeType = lookupMimeType('.${file.extension!}');
    var dataSend = {
      'info': {
        'libro': pdi,
        'folder': carpeta,
        'data': s,
        'name': file.name,
        'type': mimeType,
      },
      'fname': "upload"
    };
    // print(jsonEncode(dataSend));
    var response = await post(url, body: jsonEncode(dataSend));
    // print(response.body);
    var data = jsonDecode(response.body) ?? 'Error';
    // print(data['url']);
    return data.toString();
  }
}
