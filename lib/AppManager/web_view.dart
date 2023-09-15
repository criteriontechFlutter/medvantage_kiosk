
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/my_app_bar.dart';



class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  const WebViewPage({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading=true;
  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyWidget().myAppBar(context, title: widget.title.toString()),
        body:   Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url.toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? const Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ),
      ),
    );
  }
}
