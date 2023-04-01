import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ecotags/const/color.dart';
import 'package:ecotags/providers/camera/CameraProvider.dart';
import 'package:ecotags/screens/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/UploadImage.dart';

// A screen that allows users to take a picture using a given camera.
class CameraWidget extends StatefulWidget {
  static String tag = '/camera';
  const CameraWidget({
    super.key,
    // required this.camera,
  });

  // final CameraDescription camera;

  @override
  CameraWidgetState createState() => CameraWidgetState();
}

class CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    CameraDescription camera =
        Provider.of<CameraProvider>(context, listen: false).getCamera();

    print('Camera is initialized');
    print(camera);
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      camera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final size = MediaQuery.of(context).size;
            final deviceRatio = size.width / size.height;
            // If the Future is complete, display the preview.
            return Transform.scale(
              scale: 1 /
                  (_controller.value.aspectRatio *
                      MediaQuery.of(context).size.aspectRatio),
              alignment: Alignment.topCenter,
              child: new CameraPreview(_controller),
            );
          } else {
            // Otherwise, display a loading indicator.
            return LoadingWidget(message: "Camera is loading...");
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,

          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();
              // send this to firestore
              // await Provider.of<CameraProvider>(context, listen: false).uploadImage(image.path);

              if (!mounted) return;

              // upload
              // await uploadImage(image);

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                      // Pass the automatically generated path to
                      // the DisplayPictureScreen widget.
                      image: image),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          )),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final XFile image;
  const DisplayPictureScreen({super.key, required this.image});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Display the Picture')),
        body: Container(
            color: backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Image.file(File(widget.image.path))),
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          backgroundColor: primaryColor,
          onPressed: () async {
            setState(() {
              isUploading = true;
            });
            await uploadImage(widget.image);
            //show toast
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Image Uploaded successfully!'),
              duration: Duration(seconds: 2),
            ));
            Navigator.of(context).pop();
          },
          label: Text(isUploading ? "Uploading" : "Upload Image",
              style: TextStyle(color: appColor)),
          icon: isUploading
              ? CircularProgressIndicator(
                  color: appColor,
                )
              : Icon(CupertinoIcons.cloud_upload, color: appColor),
        ));
  }
}
