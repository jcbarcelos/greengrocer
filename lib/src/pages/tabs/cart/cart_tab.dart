// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';

import 'package:greengrocer/src/pages/tabs/cart/components/cart_card.dart';
import 'package:greengrocer/src/pages/tabs/orders/components/paymant_dialog_widget.dart';
import 'package:greengrocer/src/services/util_services.dart';
import 'package:greengrocer/src/config/db/mock/app_data.dart' as app_data;
import 'package:greengrocer/src/widget/show_confirmation_widget/show_confirmation_widget.dart';

class CartTab extends StatefulWidget {
  const CartTab({
    Key? key,
  }) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilServices utilServices = UtilServices();

  void removeItemFormCart(CartItemModel cartItem) {
    setState(() {
      app_data.cartItems.remove(cartItem);
      utilServices.showToast(
        message: '${cartItem.item.itemName} removido ao carrinho',
      );
    });
  }

  double cartTotalPrice() {
    double totalPrice = 0;

    for (var itemCart in app_data.cartItems) {
      totalPrice += itemCart.totalPrice();
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) {
                final cartItem = app_data.cartItems[index];
                return CartCard(
                  cartItem: app_data.cartItems[index],
                  updatedQuantity: (qtd) {
                    if (qtd == 0) {
                      removeItemFormCart(app_data.cartItems[index]);
                    } else {
                      setState(() => cartItem.quantity = qtd);
                    }
                  },
                );
              },
              itemCount: app_data.cartItems.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Geral',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      utilServices.priceToCurrency(cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 25,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      bool? resultConfirmation = await showOrderConfirmation();
                      if (resultConfirmation ?? false) {
                        showDialog(
                          context: context,
                          builder: (_) => PaymanetDialogWidget(
                            pedidos: app_data.pedidos.first,
                          ),
                        );
                      } else {
                        utilServices.showToast(
                          message: 'Pedido não confirmado.',
                          isError: true,
                        );
                      }
                    },
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() async {
    return showConfirmationWidget(
      context,
      'Confirmação',
      'Deseja realmente concluir o pedido?',
    );
  }
}
