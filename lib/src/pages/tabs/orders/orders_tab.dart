import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/db/mock/app_data.dart';
import 'package:greengrocer/src/pages/tabs/orders/components/orders_title.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);
  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => OrdersTitle(pedidos: pedidos[index]),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemCount: pedidos.length,
      ),
    );
  }
}
