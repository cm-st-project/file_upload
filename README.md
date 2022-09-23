# file_upload
A Flutter plugin to send files as a request to the server 

## Usage

```dart
import 'package:file_upload/file_upload.dart';

Future<void> sendFiles() async {
  String url = '$_url/request1';
  // url,fileKey1,filePath1,fileType1,fileKey2,filePath2,fileType2
  response1 = await fileUpload.uploadTwoFiles(url,'video',path1!,'mp4','image',path2!,'jpg');
  print(response1);
}

Future<void> sendFile() async {
  String url = '$_url/request2';
  // url,fileKey,filePath,fileType
  response2 = await fileUpload.uploadFile(url,'audio',path3!,'wav');
  print(response2);
}
```

