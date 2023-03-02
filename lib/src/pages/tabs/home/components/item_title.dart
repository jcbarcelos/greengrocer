import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/pages/tabs/home/controller/home_controller.dart';
import 'package:greengrocer/src/services/util_services.dart';

class ItemTitle extends StatefulWidget {
  final ItemModel itemModel;
  final HomeController homeController;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTitle({
    super.key,
    required this.itemModel,
    required this.cartAnimationMethod,
    required this.homeController,
  });

  @override
  State<ItemTitle> createState() => _ItemTitleState();
}

class _ItemTitleState extends State<ItemTitle> {
  final UtilServices utilServices = UtilServices();

  final GlobalKey imageGk = GlobalKey();

  IconData titleIcon = Icons.add_shopping_cart_outlined;
  Future<void> switchIconAddCart() async {}
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //content
        InkWell(
          onTap: () {
            Get.back();
            widget.homeController.searchTitle.value = '';
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return ProductScreen(
                  itemModel: widget.itemModel,
                );
              }),
            );
          },
          child: Card(
            elevation: 9,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //imagem
                  Expanded(
                    child: Hero(
                      tag: widget.itemModel.imgUrl,
                      child: Image.network(
                        widget.itemModel.imgUrl,
                        key: imageGk,
                      ),
                    ),
                  ),

                  Text(
                    widget.itemModel.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        utilServices.priceToCurrency(widget.itemModel.price),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '/${widget.itemModel.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  // name
                  // preco
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Material(
                  child: InkWell(
                    child: Ink(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: CustomColors.customSwatchColor,
                      ),
                      height: 40,
                      width: 35,
                      child: IconButton(
                        onPressed: () async {
                          setState(
                            (() => titleIcon = Icons.check),
                          );
                          widget.cartAnimationMethod(imageGk);
                          await Future.delayed(
                            const Duration(milliseconds: 1000),
                          );

                          setState(
                            (() =>
                                titleIcon = Icons.add_shopping_cart_outlined),
                          );
                        },
                        icon: Icon(
                          titleIcon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
