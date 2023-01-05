import 'package:flutter/material.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// 骨架屏-卡片
Widget cardListSkeleton({
  Color color = ThemeColors.tabBarElement,
  int duration = 3,
  int interval = 5,
}) {
  return Shimmer(
    duration: Duration(seconds: duration), //Default value
    interval: Duration(seconds: interval), //Default value: Duration(seconds: 0)
    color: Colors.white, //Default value
    colorOpacity: 0, //Default value
    enabled: true, //Default value
    direction: const ShimmerDirection.fromLTRB(), //Default Value
    child: Container(
      color: color,
    ),
  );
}
