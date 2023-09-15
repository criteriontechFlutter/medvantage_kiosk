import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;
import 'package:get/get.dart';

class MyImagePicker{
  //CreateProfileController controller = Get.put(CreateProfileController());

  Future getImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,);
      final imageTemporary = File(image!.path);
      //controller.updateProfile(imageTemporary);
      // var crop= await _cropImage(image!.path);
      // return crop;
    }
    on PlatformException catch(e){
      print(e);
    }
  }
     _cropImage(filePath) async {
    File? croppedImage = (await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    )) as File?;
    return croppedImage;
  }

  Future getCameraImage() async {
  try{
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    final imageTemporary = File(image!.path);
    //controller.updateProfile(imageTemporary);
    // var crop= await _cropImage(image!.path);
    // return crop;
  }
  on PlatformException catch(e){
    print(e);
  }
  }





  getPicInBase64(pics) async{
    var str= await pics.path;
    var converted= (base64.encode(await Io.File(str).readAsBytes()));
    return converted;
  }


  Future getVideo() async{
    try{
      final video = await ImagePicker().pickVideo(source: ImageSource.camera);
      return video;
    }
    catch(e){
      print(e);
    }
  }

  Future getVideoFromGallery() async{
    try{
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      return video;
    }
    catch(e){
      print(e);
    }
  }



}