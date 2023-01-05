import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/styles/index.dart';

/// 透明背景AppBar
class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;

  const TransparentAppBar(
      {Key? key, this.actions, this.title, this.leading, this.height = 44})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // 顶部状态栏的颜色设置，现在改成了黑色
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: Center(
        child: title,
      ),
      leading: leading,
      actions: actions,
    );
  }
}
