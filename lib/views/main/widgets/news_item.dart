import 'package:flutter/material.dart';
import 'package:flutter_news/common/entities/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

/// 新闻行 Item
Widget newsItem(NewsItem item) {
  return Container(
    height: duSetHeight(161),
    padding: EdgeInsets.all(duSetWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 图
        imageCached(
          item.thumbnail,
          width: duSetWidth(121),
          height: duSetWidth(121),
        ),
        // 右侧
        SizedBox(
          width: duSetWidth(194),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 作者
              Container(
                margin: const EdgeInsets.all(0),
                child: Text(
                  item.author,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontWeight: FontWeight.normal,
                    color: ThemeColors.thirdElementText,
                    fontSize: duSetFontSize(14),
                    height: 1,
                  ),
                ),
              ),
              // 标题
              Container(
                margin: EdgeInsets.only(top: duSetHeight(10)),
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: ThemeColors.primaryText,
                    fontSize: duSetFontSize(16),
                    height: 1,
                  ),
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                ),
              ),
              // Spacer
              const Spacer(),
              // 一行 3 列
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 分类
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: duSetWidth(60),
                    ),
                    child: Text(
                      item.category,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.secondaryElementText,
                        fontSize: duSetFontSize(14),
                        height: 1,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                  // 添加时间
                  Container(
                    width: duSetWidth(15),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: duSetWidth(100),
                    ),
                    child: Text(
                      '• ${duTimeLineFormat(item.addtime)}',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.thirdElementText,
                        fontSize: duSetFontSize(14),
                        height: 1,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                  // 更多
                  const Spacer(),
                  InkWell(
                    child: const Icon(
                      Icons.more_horiz,
                      color: ThemeColors.primaryText,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
