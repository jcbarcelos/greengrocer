import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/services/util_services.dart';

class ItemTitle extends StatelessWidget {
  final ItemModel itemModel;
  final UtilServices utilServices = UtilServices();

  ItemTitle({
    super.key,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //content
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return ProductScreen(
                  itemModel: itemModel,
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
                      tag: itemModel.imgUrl,
                      child: Image.asset(
                        itemModel.imgUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Text(
                    itemModel.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        utilServices.priceToCurrency(itemModel.price),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '/${itemModel.unit}',
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
          child: Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: CustomColors.customSwatchColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(20),
              ),
            ),
            height: 40,
            width: 35,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
