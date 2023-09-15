import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'app_color.dart';
import 'flutter_download_file.dart';

class PdfViewer extends StatefulWidget {
  final pdfUrl;
  const PdfViewer({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  //get comparision => null;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body:Stack(
            children: [
              widget.pdfUrl==''?
              Center(
                child: Text("No pdf found",style: MyTextTheme().largeBCB,),
              ) :
              SfPdfViewer.network( widget.pdfUrl.toString()
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 5),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: const Icon(Icons.arrow_back_ios_sharp)),
              )
            ],
          ),
          floatingActionButton: Visibility(
          visible: widget.pdfUrl!="",
            child: FloatingActionButton(
            onPressed: ()async {
                  FlutterDownloadFiles().download(
                      context,
                      widget.pdfUrl);},
            child: const Icon(Icons.download_rounded,size:30),
        ),
          ),
        ),
      ),
    );
  }
}
