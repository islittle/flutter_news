import 'package:flutter/material.dart';
import 'package:flutter_news/common/consts/index.dart';
import 'package:flutter_news/utils/index.dart';
import 'package:flutter_news/common/entities/index.dart';

class NewsAPI {
  /// 翻页
  /// refresh 是否刷新
  static Future<NewsPageListResponseEntity> newsPageList({
    required BuildContext context,
    NewsPageListRequestEntity? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await R.get(
      '/news',
      context: context,
      params: params?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
      cacheKey: STORAGE_INDEX_NEWS_CACHE_KEY,
    );
    return NewsPageListResponseEntity.fromJson(response);
  }

  /// 推荐
  static Future<NewsItem> newsRecommend({
    required BuildContext context,
    NewsRecommendRequestEntity? params,
    bool refresh = false,
    bool cacheDisk = false,
  }) async {
    var response = await R.get(
      '/news/recommend',
      context: context,
      params: params?.toJson(),
      refresh: refresh,
      cacheDisk: cacheDisk,
    );
    return NewsItem.fromJson(response);
  }

  /// 分类
  static Future<List<CategoryResponseEntity>> categories({
    required BuildContext context,
    bool cacheDisk = false,
  }) async {
    var response = await R.get(
      '/categories',
      context: context,
      cacheDisk: cacheDisk,
    );
    return response
        .map<CategoryResponseEntity>(
            (item) => CategoryResponseEntity.fromJson(item))
        .toList();
  }

  /// 频道
  static Future<List<ChannelResponseEntity>> channels({
    required BuildContext context,
    bool cacheDisk = false,
  }) async {
    var response = await R.get(
      '/channels',
      context: context,
      cacheDisk: cacheDisk,
    );
    return response
        .map<ChannelResponseEntity>(
            (item) => ChannelResponseEntity.fromJson(item))
        .toList();
  }

  /// 标签列表
  static Future<List<TagResponseEntity>> tags({
    required BuildContext context,
    TagRequestEntity? params,
    bool cacheDisk = false,
  }) async {
    var response = await R.get(
      '/tags',
      context: context,
      params: params?.toJson(),
      cacheDisk: cacheDisk,
    );
    return response
        .map<TagResponseEntity>((item) => TagResponseEntity.fromJson(item))
        .toList();
  }
}
