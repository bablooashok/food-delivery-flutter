import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  List outputs;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("camera"),
      ),
      body: _loading ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                imageFile == null ?
                Text("No Image Selected") :
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(imageFile,width: 400,height: 400,),
                ),
                SizedBox(
                  height: 20,
                ),
                outputs != null ? Text("${outputs[0]["label"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    background: Paint()..color = Colors.white,
                  ),) : Text("select a Food Image to know the Name of the Food Item"),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){
                  _showChoiceDialog(context);
                },child: Text("Select Image"),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  openGallery(BuildContext context) async{

    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _loading = true;
      imageFile = picture;
    });
    Navigator.of(context).pop();
    classifyImage(imageFile);
  }

  openCamera(BuildContext context) async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _loading = true;
      imageFile = picture;
    });
    Navigator.of(context).pop();
    classifyImage(imageFile);
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Select a source"),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: (){
                    openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: (){
                    openCamera(context);
                  },
                )
              ],
            )
        ),
      );
    });
  }

  classifyImage(File image) async{
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5
    );
    setState(() {
      _loading = false;
      outputs = output;
    });
  }

  loadModel() async{
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
