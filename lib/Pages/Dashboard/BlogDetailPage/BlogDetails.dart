import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_doctor/AppManager/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';


import '../../../Localization/app_localization.dart';
import '../DataModal/dashboard_data_modal.dart';
import '../dashboard_modal.dart';

class BlogDetails extends StatefulWidget {
  final BlogDetailDataModal details;

  const BlogDetails({Key? key, required this.details}) : super(key: key);

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  DashboardModal modal = DashboardModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLocalizations localization=Provider.of<ApplicationLocalizations>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        title:  Text(localization.getLocaleData.blogDetails.toString()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 5),
          child: Column(children: [
            Text(
              widget.details.title.toString(),
              style: MyTextTheme().largeBCB,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.details.imagePath.toString(),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      // shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/noProfileImage.png',
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            HtmlWidget( widget.details.description.toString())
          ]),
        ),
      ),
    );
  }
}
