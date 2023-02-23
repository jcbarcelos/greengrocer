import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/pedidos_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imgUrl: 'assets/images/fruits/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
  id: '',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/images/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  id: '',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/images/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  id: '',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/images/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  id: '',
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/images/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  id: '',
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/images/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  id: '',
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];
List<String> categories = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Temperos',
  'Cereais',
  'Laticinios',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    item: apple,
    quantity: 2,
  ),
  CartItemModel(
    item: mango,
    quantity: 1,
  ),
  CartItemModel(
    item: guava,
    quantity: 5,
  ),
  CartItemModel(
    item: grape,
    quantity: 6,
  ),
];

UserModel user = UserModel(
  name: 'Joao Pedro',
  email: 'joao@email.com',
  phone: '99 9 9999-9999',
  cpf: '999.999.999-99',
  password: '',
);

List<PedidosModel> pedidos = [
  PedidosModel(
    copyAndPaste: 'q132432fdd',
    createdDateTime: DateTime.parse('2023-02-06 10:00:10'),
    overdueDateTime: DateTime.parse('2023-02-15 11:00:10'),
    id: 'adsafds34342',
    status: 'preparing_purchage',
    total: 14,
    items: [
      CartItemModel(item: mango, quantity: 6),
      CartItemModel(item: grape, quantity: 4),
    ],
  ),
  PedidosModel(
    copyAndPaste: 'q132432fdd',
    createdDateTime: DateTime.parse('2023-02-06 10:00:10'),
    overdueDateTime: DateTime.parse('2023-02-15 11:00:10'),
    id: 'adsafds34342',
    status: 'pending_payment',
    total: 12,
    items: [
      CartItemModel(item: apple, quantity: 2),
    ],
  ),
  // Pedido 02
  PedidosModel(
    copyAndPaste: 'q1w2e3r4t5y6',
    createdDateTime: DateTime.parse(
      '2023-02-05 10:00:10.458',
    ),
    overdueDateTime: DateTime.parse(
      '2023-02-10 11:00:10.458',
    ),
    id: 'a65s4d6a2s1d6a5s',
    status: 'delivered',
    total: 11.5,
    items: [
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        item: guava,
        quantity: 1,
      ),
      CartItemModel(
        item: apple,
        quantity: 2,
      ),
    ],
  ),
];
