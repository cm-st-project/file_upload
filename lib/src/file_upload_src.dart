import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:httpgit i_parser/http_parser.dart';

class FileUpload {
  Future uploadFile(
      String url, String fileKey, String filePath, String fileType) async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };

    http.MultipartRequest request =
        http.MultipartRequest('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
        fileKey,
        filePath,
        contentType: MediaType('application', fileType),
      ),
    );

    request.send().then((response) async {
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(await response.stream.transform(utf8.decoder).join());
        if (jsonResponse == null) {
          print('Field is empty');
          return null;
        }
        return jsonResponse;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    });
  }

  Future uploadTwoFiles(
      String url,
      String fileKey1,
      String filePath1,
      String fileType1,
      String fileKey2,
      String filePath2,
      String fileType2) async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };

    http.MultipartRequest request =
        http.MultipartRequest('GET', Uri.parse(url));
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
        fileKey1,
        filePath1,
        contentType: MediaType('application', fileType1),
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        fileKey2,
        filePath2,
        contentType: MediaType('application', fileType2),
      ),
    );

    request.send().then((response) async {
      if (response.statusCode == 200) {
        var jsonResponse =
            jsonDecode(await response.stream.transform(utf8.decoder).join());
        if (jsonResponse == null) {
          print('Field is empty');
          return null;
        }
        return jsonResponse;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    });
  }
}
