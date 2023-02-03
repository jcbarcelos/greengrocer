import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/db/mock/app_data.dart' as app_data;
import 'package:greengrocer/src/pages/tabs/home/components/category_title.dart';
import 'package:greengrocer/src/pages/tabs/home/components/item_title.dart';

import 'package:greengrocer/src/widget/text_input_search/text_input_search.dart';
import 'package:greengrocer/src/widget/text_rich_widget/text_rich_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: TextRichWidget(
          fontSize: 30,
          primaryName: 'Green',
          secundName: 'gracer',
          colorPrimary: CustomColors.customSwatchColor,
          colorSecund: CustomColors.customContrastColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeStyle: BadgeStyle(
                  badgeColor: CustomColors.customContrastColor,
                ),
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                position: BadgePosition.custom(top: -15, end: -10),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // search
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextInputSearch(),
          ),
          // Categories
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryTitle(
                  category: app_data.categories[index],
                  isSelected: app_data.categories[index] == selectedCategory,
                  onPressed: () {
                    setState(() {
                      selectedCategory = app_data.categories[index];
                    });
                  },
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
              itemCount: app_data.categories.length,
            ),
          ),

          //GrivView

          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 11.5,
              ),
              itemCount: app_data.items.length,
              itemBuilder: ((context, index) {
                return ItemTitle(
                  itemModel: app_data.items[index],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
