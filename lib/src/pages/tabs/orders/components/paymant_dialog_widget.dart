import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/pedidos_model.dart';
import 'package:greengrocer/src/services/util_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymanetDialogWidget extends StatelessWidget {
  final PedidosModel pedidos;
  final UtilServices utilServices = UtilServices();
  PaymanetDialogWidget({
    super.key,
    required this.pedidos,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      'Pagamento com Pix',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  QrImage(
                    data: 'dsadasdsadsa',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  Text(
                    'Vencimento: ${utilServices.formatDateTime(pedidos.overdueDateTime, "pt_BR")}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Total: ${utilServices.priceToCurrency(pedidos.total)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: const BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                    ),
                    onPressed: () {},
                    label: const Text(
                      'Copiar código Pix',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    icon: const Icon(
                      Icons.copy,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ));
  }
}
