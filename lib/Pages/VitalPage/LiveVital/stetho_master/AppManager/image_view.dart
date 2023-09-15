
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'app_color.dart';

class ImageView extends StatefulWidget {
  final String url;

  const ImageView({Key? key, required this.url}) : super(key: key);

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
            InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 1.6,
              child: CachedNetworkImage(
                imageUrl: widget.url,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.orange,)),
                errorWidget: (context, url, error) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.error),
                    Text('There was an error while loading the image !!!')
                  ],
                ),
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
                              color: AppColor.black,
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
//   _ImageViewState createState() => _ImageViewState();
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
