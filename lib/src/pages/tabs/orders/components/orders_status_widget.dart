import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/tabs/orders/widgets/custom_divider_widget.dart';
import 'package:greengrocer/src/pages/tabs/orders/widgets/status_dot_widget.dart';

class OrdersStatusWidget extends StatelessWidget {
  OrdersStatusWidget({
    super.key,
    required this.status,
    required this.isOverude,
  });
  final String status;
  final bool isOverude;

  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchage': 3,
    'shipping': 4,
    'delivered': 5,
  };

  int get curruntStatus => allStatus[status]!;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StatusDot(isActive: true, title: 'Pedido confirmado'),
        const CustomDividerWidget(),
        if (curruntStatus == 1) ...[
          const StatusDot(
            isActive: true,
            title: 'Pix estornado',
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverude) ...[
          const StatusDot(
            isActive: true,
            title: 'Pagamento Pix vencido',
            backgroundColor: Colors.red,
          ),
        ] else ...[
          StatusDot(
            isActive: curruntStatus >= 2,
            title: 'Pagamento',
          ),
          const CustomDividerWidget(),
          StatusDot(
            isActive: curruntStatus >= 3,
            title: 'Preparando',
          ),
          const CustomDividerWidget(),
          StatusDot(
            isActive: curruntStatus >= 4,
            title: 'Envio',
          ),
          const CustomDividerWidget(),
          StatusDot(
            isActive: curruntStatus == 5,
            title: 'Entregue',
          ),
          const CustomDividerWidget(),
        ]
      ],
    );
  }
}
