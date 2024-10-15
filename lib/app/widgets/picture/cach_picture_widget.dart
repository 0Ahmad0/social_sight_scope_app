
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';



class CacheNetworkImage extends StatelessWidget {
  final String photoUrl;
  final double? width;
  final double? height;
  final Widget waitWidget;
  final Widget errorWidget;
  final BoxFit boxFit;
  final bool withCircle;
  CacheNetworkImage({
     required this.photoUrl,
      this.width,
      this.height,
    required this.waitWidget,
    required this.errorWidget,
    this.boxFit=BoxFit.fill,
    this.withCircle=true,
  });

  @override
  Widget build(BuildContext context) {
    return
      photoUrl.isNotEmpty?
      CachedNetworkImage(
      fit: boxFit,
      width: width,
      height: height,
      imageUrl:
      "${photoUrl}",
      //"https://static.remove.bg/remove-bg-web/c05ac62d076574fad1fbc81404cd6083e9a4152b/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png",
      imageBuilder: (context, imageProvider) =>
      !withCircle?
         Image(image: imageProvider):

          CircleAvatar(
            foregroundImage:imageProvider,
          ),
      placeholder: (context, url) =>
        waitWidget,
      errorWidget: (context, url, error) =>
        errorWidget,

    )

    :errorWidget;
  }
}