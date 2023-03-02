import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/tabs/home/components/category_title.dart';
import 'package:greengrocer/src/pages/tabs/home/components/item_title.dart';
import 'package:greengrocer/src/pages/tabs/home/controller/home_controller.dart';
import 'package:greengrocer/src/widget/shimmer/custom_shimmer.dart';

import 'package:greengrocer/src/widget/text_input_search/text_input_search.dart';
import 'package:greengrocer/src/widget/text_rich_widget/text_rich_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;
  final TextEditingController searchController = TextEditingController();

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                child: AddToCartIcon(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  ),
                  key: globalKeyCartItems,
                ),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(microseconds: 1000),
        rotation: true,
        dragToCardCurve: Curves.easeIn,
        dragToCardDuration: const Duration(milliseconds: 1000),
        previewCurve: Curves.linearToEaseOut,
        previewHeight: 30,
        previewWidth: 30,
        opacity: 0.85,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // search
            GetBuilder<HomeController>(
              builder: (homeController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: TextInputSearch(
                    searchController: searchController,
                    onChanged: (value) {
                      homeController.searchTitle.value = value;
                    },
                    getController: homeController,
                  ),
                );
              },
            ),
            // Categories
            GetBuilder<HomeController>(
              builder: (homeController) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !homeController.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTitle(
                              category:
                                  homeController.allCategories[index].title,
                              isSelected: homeController.allCategories[index] ==
                                  homeController.currentCategory,
                              onPressed: () {
                                homeController.selectCategory(
                                  homeController.allCategories[index],
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: homeController.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (index) => Container(
                              margin: const EdgeInsets.only(right: 12),
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: 20,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            //GrivView

            GetBuilder<HomeController>(
              builder: (homeController) {
                return Expanded(
                  child: !homeController.isProductLoading
                      ? Visibility(
                          visible: (homeController.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 40,
                                color: CustomColors.customSwatchColor,
                              ),
                              const Text('Não há itens para apresentar'),
                            ],
                          ),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: homeController.allProducts.length,
                            itemBuilder: ((context, index) {
                              if ((index + 1 ==
                                      homeController.allProducts.length) &&
                                  !homeController.isLastPage) {
                                homeController.loadMoreProducts();
                              }
                              return GetBuilder<HomeController>(
                                  builder: (homeController) {
                                return ItemTitle(
                                  homeController: homeController,
                                  itemModel: homeController.allProducts[index],
                                  cartAnimationMethod:
                                      itemSelectedCartAnimations,
                                );
                              });
                            }),
                          ),
                        )
                      : GridView.count(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            10,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
