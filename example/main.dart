import 'package:flutter/material.dart';
import 'package:file_upload/file_upload.dart';
import 'package:image_picker/image_picker.dart;
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'file upload example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileUploadExample(
        title: 'file upload example',
      ),
      // home: AudioScreen(),
    );
  }
}

class FileUploadExample extends StatefulWidget {
  FileUploadExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FileUploadExampleState createState() => _FileUploadExampleState();
}

class _FileUploadExampleState extends State<FileUploadExample> {
  FileUpload fileUpload = FileUpload();
  Map<String, dynamic> response1 = {};
  List response2 = [];
  PickedFile? file1;
  PickedFile? file2;
  FileType?  _pickingType = FileType.custom;
  String? path1;
  String? path2;
  String? path3;
  //Use the local host
  String _url = 'http://10.0.2.2:5000';


  Future getVideoFromGallery() async {
    file1 = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      path1 = file1?.path;
    });
  }

  Future getImageFromGallery() async {
    file1 = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      path2 = file2?.path;
    });
  }

  void _pickFile3() async {
       FilePicker.platform.pickFiles(
        type: _pickingType,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['mp3', 'wav'],
      ).then((paths) async{
         path3 = paths![0].path!.substring(1);
       });

   }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getVideoFromGallery();
              },
              child: Text('pick file1')),
          ElevatedButton(
              onPressed: () {
                getImageFromGallery();
              },
              child: Text('pick file2')),
          ElevatedButton(
              onPressed: () {
                sendFiles();
              },
              child: Text('send files')),
          ElevatedButton(
              onPressed: () {
                _pickFile3();
              },
              child: Text('pick file3')),
          ElevatedButton(
              onPressed: () {
                sendFile();
              },
              child: Text('send file')),

        ],
      ),
    );
  }
}