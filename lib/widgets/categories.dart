import 'package:flutter/material.dart';
import 'package:flutter_news/common/entities/index.dart';
import 'package:flutter_news/styles/index.dart';
import 'package:flutter_news/utils/index.dart';

Widget newsCategoriesWidget(
    {List<CategoryResponseEntity>? categories,
    String? selectedCategoryCode,
    Function(CategoryResponseEntity)? onTap}) {
  return categories == null
      ? Container()
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map<Widget>((item) {
              return Container(
                alignment: Alignment.center,
                height: duSetHeight(52),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: selectedCategoryCode == item.code
                          ? ThemeColors.secondaryElementText
                          : ThemeColors.primaryText,
                      fontSize: duSetFontSize(18),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => onTap!(item),
                ),
              );
            }).toList(),
          ),
        );
}
