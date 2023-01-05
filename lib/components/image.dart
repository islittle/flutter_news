import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

Widget imageCached(
  String url, {
  double width = 48,
  double height = 48,
  EdgeInsetsGeometry? margin,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    // progressIndicatorBuilder: (context, url, downloadProgress) =>
    //     LinearProgressIndicator(
    //   value: downloadProgress.progress,
    // ),
    imageBuilder: (context, imageProvider) => Container(
      width: duSetWidth(width),
      height: duSetHeight(height),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: Radii.k6pxRadius,
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    ),
    placeholder: (context, url) {
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(), // ??
      );
    },
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
