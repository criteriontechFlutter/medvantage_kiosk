import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../app_color.dart';
import '../my_text_theme.dart';

class CommonWidgets {
  backButton(context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  shimmerEffect({
    required Widget child,
    required bool shimmer,
    Color ? baseColor,
  }) {
    return (shimmer)
        ? Shimmer.fromColors(
            baseColor: baseColor??Colors.grey, highlightColor: Colors.white, child: child)
        : child;
  }

  imageDialog({img, context}) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: CachedNetworkImage(
            fit: BoxFit.fill,
            placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 36,
                    child: CircularProgressIndicator(),
                  ),
                ),
            imageUrl: img.toString(),
            errorWidget: (context, url, error) =>
                const Image(image: AssetImage('assets/noProfileImage.png'))),
      ),
    );
  }

  showNoData({
    required bool show,
    bool? showLoader,
    Widget? child,
    String? title,
    String? loaderTitle,
    Color? color,
  }) {
    return show
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 60),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      child: Lottie.asset('assets/no_wifi.json')),
                  Text(
                    title ?? 'NO Data Found',
                    style: MyTextTheme()
                        .mediumPCB
                        .copyWith(color: color ?? AppColor.primaryColor),
                  ),
                ],
              ),
            ),
          )
        : (((showLoader ?? false))
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 70,
                      child: Lottie.asset('assets/loader.json',  )),
                  shimmerEffect(
                    shimmer: true,
                    child: Text(
                      loaderTitle ?? 'Loading Data',
                      style: MyTextTheme()
                          .mediumPCB
                          .copyWith(color: color ?? AppColor.primaryColor),
                    ),
                  ),
                ],
              )
            : child);
  }


  ButtonStyle myButtonStyle=TextButton.styleFrom(
    padding: const EdgeInsets.all(0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: const Size(0, 0),
    primary: Colors.black,
  );


}
