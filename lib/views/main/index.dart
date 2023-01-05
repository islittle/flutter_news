import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news/common/apis/index.dart';
import 'package:flutter_news/common/consts/index.dart';
import 'package:flutter_news/common/entities/index.dart';
import 'package:flutter_news/components/index.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/views/main/widgets/ad.dart';
import 'package:flutter_news/views/main/widgets/channels.dart';
import 'package:flutter_news/views/main/widgets/news_item.dart';
import 'package:flutter_news/views/main/widgets/newsletter.dart';
import 'package:flutter_news/views/main/widgets/recommend.dart';
import 'package:flutter_news/widgets/categories.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  EasyRefreshController? _controller; // EasyRefresh控制器

  NewsPageListResponseEntity? _newsPageList; // 新闻翻页
  NewsItem? _newsRecommend; // 新闻推荐
  List<CategoryResponseEntity>? _categories; // 分类
  List<ChannelResponseEntity> _channels = [];
  String? _selectedCategoryCode;

  @override
  void initState() {
    super.initState();

    _controller = EasyRefreshController();
    _loadAllData();
    _loadLatestWithDiskCache();
  }

// 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = Storage().getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData == null) {
        Timer(const Duration(seconds: 3), () {
          _controller?.callRefresh();
        });
      }
    }
  }

  // 读取所有数据
  _loadAllData() async {
    _categories = await NewsAPI.categories(
      context: context,
      cacheDisk: true,
    );
    _channels = await NewsAPI.channels(
      context: context,
      cacheDisk: true,
    );
    _newsRecommend = await NewsAPI.newsRecommend(
      context: context,
      cacheDisk: true,
    );
    _newsPageList = await NewsAPI.newsPageList(
      context: context,
      cacheDisk: true,
    );

    _selectedCategoryCode = _categories?.first.code;
    if (mounted) {
      setState(() {});
    }
  }

  // 拉取推荐、新闻
  _loadNewsData(
    categoryCode, {
    bool refresh = false,
  }) async {
    _selectedCategoryCode = categoryCode;
    _newsRecommend = await NewsAPI.newsRecommend(
      context: context,
      params: NewsRecommendRequestEntity(categoryCode: categoryCode),
      refresh: refresh,
      cacheDisk: true,
    );
    _newsPageList = await NewsAPI.newsPageList(
      context: context,
      params: NewsPageListRequestEntity(categoryCode: categoryCode),
      refresh: refresh,
      cacheDisk: true,
    );

    // TODO:?? 为啥加了状态就会更新
    if (mounted) {
      setState(() {});
    }
  }

  // 分类菜单
  Widget _buildCategories() {
    return _categories == null
        ? Container()
        : newsCategoriesWidget(
            categories: _categories,
            selectedCategoryCode: _selectedCategoryCode,
            onTap: (CategoryResponseEntity item) {
              _loadNewsData(item.code);
            },
          );
  }

  // 推荐阅读
  Widget _buildRecommend() {
    return _newsRecommend == null
        ? Container()
        : recommendWidget(context, _newsRecommend!);
  }

  // 频道
  Widget _buildChannels() {
    return _channels.isEmpty
        ? Container()
        : newsChannelsWidget(
            channels: _channels,
            onTap: (ChannelResponseEntity item) {
              print(item.code);
            },
          );
  }

  // 新闻列表
  Widget _buildNewsList() {
    return _newsPageList == null
        ? Container(
            height: duSetHeight(161 * 5 + 100.0),
          )
        : Column(
            children: _newsPageList!.items!.map((item) {
              // 新闻行
              List<Widget> widgets = <Widget>[
                newsItem(item),
                const Divider(height: 1),
              ];

              // 每 5 条 显示广告
              int index = _newsPageList!.items!.indexOf(item);
              if (((index + 1) % 5) == 0) {
                widgets.addAll(<Widget>[
                  adWidget(),
                  const Divider(height: 1),
                ]);
              }

              // 返回
              return Column(
                children: widgets,
              );
            }).toList(),
          );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return newsletterWidget();
  }

  @override
  Widget build(BuildContext context) {
    return _newsPageList == null
        ? cardListSkeleton()
        : EasyRefresh(
            enableControlFinishRefresh: true,
            controller: _controller,
            header: ClassicalHeader(),
            onRefresh: () async {
              await _loadNewsData(_selectedCategoryCode, refresh: true);
              _controller?.finishRefresh();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCategories(), // 顶部navbar
                  const Divider(height: 1),
                  _buildRecommend(), // 推荐卡片
                  const Divider(height: 1),
                  _buildChannels(), // 频道icon
                  const Divider(height: 1),
                  _buildNewsList(), // 新闻listItem
                  const Divider(height: 1),
                  _buildEmailSubscribe(), // 邮件订阅框
                ],
              ),
            ),
          );
  }
}
