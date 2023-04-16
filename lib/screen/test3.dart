import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test3 extends StatefulWidget {
  const Test3({Key? key}) : super(key: key);

  @override
  State<Test3> createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  String picDownloadUrl = "http://10.0.2.2:8000/image/get_image/a.jpg";
  String picUploadUrl = "http://10.0.2.2:8000/image/upload/a.jpg";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            //upload
            Container(
              color: Colors.redAccent.withOpacity(.5),
              height: 400,
              width: 400,
              child: TextButton(
                onPressed: () async {
                  String response = await uploadPhoto('a.jpg');
                }, child: Text("ok"),
              ),
            ),
            Container(
              height: 400,
              width: 400,
              child: Image(
                image: NetworkImage(picDownloadUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadPhoto(String filePath) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(picUploadUrl),
    );

    var file = await http.MultipartFile.fromPath('photo', filePath);

    request.files.add(file);

    var response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to upload photo');
    }
  }



}
