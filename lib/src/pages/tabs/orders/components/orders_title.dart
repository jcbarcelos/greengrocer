import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/pedidos_model.dart';
import 'package:greengrocer/src/pages/tabs/orders/components/orders_status_widget.dart';
import 'package:greengrocer/src/pages/tabs/orders/components/paymant_dialog_widget.dart';
import 'package:greengrocer/src/services/util_services.dart';
import 'package:greengrocer/src/widget/custom_button/custom_button_widget.dart';
import 'package:greengrocer/src/widget/text_rich_widget/text_rich_widget.dart';

// ignore: must_be_immutable
class OrdersTitle extends StatelessWidget {
  final PedidosModel pedidos;
  OrdersTitle({super.key, required this.pedidos});

  final UtilServices utilServices = UtilServices();

  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: pedidos.status == 'pending_payment',
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido ${pedidos.id}',
              ),
              Text(
                utilServices.formatDateTime(pedidos.createdDateTime, 'pt_BR'),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 1, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 250,
                      child: Scrollbar(
                        child: ListView(
                          children: pedidos.items.map(
                            (pedidosItems) {
                              return _PedidosItemWidget(
                                utilServices: utilServices,
                                pedidosItems: pedidosItems,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: OrdersStatusWidget(
                      status: pedidos.status,
                      isOverude: pedidos.overdueDateTime.isBefore(
                        DateTime.now(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextRichWidget(
              primaryName: 'Total: ',
              secundName: utilServices.priceToCurrency(totalPrice),
              fontSize: 20,
              colorPrimary: Colors.black,
              colorSecund: Colors.green,
              fontWeightSecund: FontWeight.normal,
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: pedidos.status == 'pending_payment',
              child: CustomButtonWidget(
                title: 'Ver QR Code Pix ',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => PaymanetDialogWidget(
                      pedidos: pedidos,
                    ),
                  );
                },
                icon: Icons.pix,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PedidosItemWidget extends StatefulWidget {
  const _PedidosItemWidget({
    Key? key,
    required this.utilServices,
    required this.pedidosItems,
  }) : super(key: key);

  final UtilServices utilServices;
  final CartItemModel pedidosItems;

  @override
  State<_PedidosItemWidget> createState() => _PedidosItemWidgetState();
}

class _PedidosItemWidgetState extends State<_PedidosItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${widget.pedidosItems.quantity} ${widget.pedidosItems.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(widget.pedidosItems.item.itemName)),
          Text(
            widget.utilServices.priceToCurrency(
              widget.pedidosItems.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
