
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';
import 'flutter_download_file.dart';

class ImageView extends StatefulWidget {
  final String url;
  final bool? isFilePath;
  final String? filePathImg;

  const ImageView({Key? key, required this.url, this.isFilePath, this.filePathImg}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    print(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
           widget.isFilePath==true?  Image.file(File(widget.filePathImg.toString())):InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 1.6,
              child: CachedNetworkImage(
                imageUrl: widget.url,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.orange,)),
                errorWidget: (context, url, error) => Image.asset('assets/noProfileImage.png'),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: Colors.transparent),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FlutterDownloadFiles().download(
                context,widget.url);
            },
          child: const Icon(Icons.download_rounded, size:30),
        ),
      ),

    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// import 'app_color.dart';
//
// class ImageView extends StatefulWidget {
//
//   final String tag;
//   final String file;
//
//   const ImageView({ Key? key, required this.tag, required this.file}) : super(key: key);
//
//
//   @override
//   ImageViewState createState() => ImageViewState();
// }
//
// class _ImageViewState extends State<ImageView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColor.primaryColor,
//       child: SafeArea(
//         child: Material(
//           child: Stack(
//             children: [
//               Container(
//                   child: Hero(
//                     tag: widget.tag,
//                     child: PhotoView(
//                       imageProvider: NetworkImage(widget.file.toString()),
//                     ),
//                   )
//               ),
//               IconButton(icon: Icon(Icons.arrow_back,
//                 color: Colors.white,), onPressed: (){
//                 Navigator.pop(context);
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
