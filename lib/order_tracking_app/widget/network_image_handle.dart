import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget networkImage(
  String url, {
  BoxFit? fit,
  double? height,
  double? width,
  Color? backgroudColor,
}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    color: backgroudColor,
    fit: fit ?? BoxFit.cover,
    placeholder: (context, url) {
      return const CupertinoActivityIndicator();
    },
    errorWidget: (context, url, error) {
      return const Icon(Icons.error);
    },
    imageUrl: url,
  );
}
