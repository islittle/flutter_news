import 'package:flutter/material.dart';
import 'package:flutter_news/common/entities/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/router/index.gr.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

Widget recommendWidget(BuildContext context, NewsItem newsRecommend) {
  return Container(
    margin: EdgeInsets.all(duSetWidth(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 图片
        InkWell(
          onTap: () {
            router(context).push(DetailsRoute(item: newsRecommend));
          },
          child: imageCached(
            newsRecommend.thumbnail,
            width: duSetWidth(335),
            height: duSetHeight(290),
          ),
        ),

        // 作者
        Container(
          margin: EdgeInsets.only(top: duSetHeight(14)),
          child: Text(
            newsRecommend.author,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontWeight: FontWeight.normal,
                color: ThemeColors.thirdElementText,
                fontSize: duSetFontSize(14)),
          ),
        ),
        // 标题
        Container(
          margin: EdgeInsets.only(top: duSetHeight(10)),
          child: Text(
            newsRecommend.title,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: ThemeColors.primaryText,
                fontSize: duSetFontSize(24),
                height: 1),
          ),
        ),
        //  一行三列
        Container(
          margin: EdgeInsets.only(top: duSetHeight(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  newsRecommend.category,
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
              Container(
                width: duSetWidth(15),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  '• ${duTimeLineFormat(newsRecommend.addtime)}',
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
                onTap: () {
                  // 传入回调函数跳转or弹窗
                },
              )
            ],
          ),
        ),
      ],
    ),
  );
}
