import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'main.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  CameraImage?cameraImage;
  CameraController?cameraController;
  String output ='';
  int  selectedCamera=0;

  @override
  void initState(){
    super.initState();
    loadCamera();
    loadmodel();
  }

  loadCamera(){
    cameraController=CameraController(cameras![1],ResolutionPreset.medium);
        cameraController!.initialize().then((value){
          if(!mounted){
            return;
          }
          else{
            setState(() {
              cameraController!.startImageStream((imageStream) {
                cameraImage = imageStream;
                runModel();
              });

            });
          }
    });
  }
  runModel() async{
    if(cameraImage!=null){
      var predictions = await Tflite.runModelOnFrame(bytesList: cameraImage!.planes.map((plane) {
        return plane.bytes;
      }).toList(),

       imageHeight:  50,
       imageWidth:  100,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true
      );
      predictions!.forEach((element) { setState(() {
        output = element['label'];
      });});

    }
  }

  loadmodel() async{
    await Tflite.loadModel(model:"assets/model.tflite",
    labels: "assets/labels.txt"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueAccent[400],
        title: Center(
          child: Image.asset(
            "assets/logo1.png",
            fit: BoxFit.contain,
            height: 80,
            width: 80,
          ),
        ),
      /*  actions: [
          IconButton(
              onPressed: (){
                { Navigator.of(context).push(MaterialPageRoute( builder: (context) => info()));}
              }
              ,icon : Icon(Icons.info_outline))
        ],*/
      ),
      body: Container(
    width: MediaQuery. of(context). size. width ,
    height:  MediaQuery. of(context). size. height,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/manui.png'),fit: BoxFit.cover
    ),
    ),
        child: Column(
          children: [
            SizedBox(height: 10,),
           // Icon(Icons.camera_alt),
            Padding(padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  height: 250,
                  width: 200,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.7,
                    width: MediaQuery.of(context).size.width,
                    child: !cameraController!.value.isInitialized?
                        Container():
                        AspectRatio(aspectRatio: cameraController!.value.aspectRatio,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),

                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),

                              ),
                              child: CameraPreview(cameraController!)
                          ),
                        ),
                        )
                  ),
                ),
              ),

            ),

            SizedBox(height: 15,),
          /*  Center(
              child: IconButton(
                icon: Icon(Icons.camera,
                color: Colors.black,
                size: 50,),
                  onPressed: () {

                      selectedCamera == 1;

                  }
              ),*/
            SizedBox(height: 70,),
           // Text(output,
          //  style: TextStyle(
          //    fontWeight: FontWeight.bold,
         //     fontSize: 25
         //   ),),

            Visibility(
                visible: output == "Sad",
            child:Column(
              children: [
                Text("😔", style: TextStyle(fontSize: 100),),
                SizedBox(height: 30,),
                MaterialButton(
                    height: 50,
                    minWidth: 220,
                    onPressed: (){},
                    color: Colors.blueAccent[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(output,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),))
              ],
            ) ,),
            Visibility(
              visible: output == "Happy",
              child:Column(
                children: [
                  Text("😊", style: TextStyle(fontSize: 100)),
                  SizedBox(height: 30,),
                  MaterialButton(
                      height: 50,
                      minWidth: 220,
                      onPressed: (){},
                      color: Colors.blueAccent[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(output,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),))
                ],
              ) ,),
            Visibility(
              visible: output == "Angry",
              child:Column(
                children: [
                  Text("😡", style: TextStyle(fontSize: 100)),
                  SizedBox(height: 30,),
                  MaterialButton(
                    height: 50,
                      minWidth: 220,
                      onPressed: (){},
                      color: Colors.blueAccent[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(output,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),))
                ],
              ) ,)
          ],

        ),
      ),
    );
  }
}
