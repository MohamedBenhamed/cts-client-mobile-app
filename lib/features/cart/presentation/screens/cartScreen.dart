import 'package:flutter/material.dart';

// Dummy cart model
class CartItem {
  final String name;
  final String imagePath;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> cartItems = [
    CartItem(
      name: 'iPhone 16 Pro Max',
      imagePath:
          'assets/products/smartPhones/iPhone16-Pro-Max-DesertTitanium.webp',
      price: 5200,
    ),
    CartItem(
      name: 'Samsung Galaxy Ultra',
      imagePath:
          'assets/products/smartPhones/iPhone16-Pro-Max-DesertTitanium.webp',
      price: 4500,
    ),
    CartItem(
      name: 'Xiaomi Mi 13',
      imagePath:
          'assets/products/smartPhones/iPhone16-Pro-Max-DesertTitanium.webp',
      price: 2500,
    ),
  ];

  double get orderTotal =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get deliveryFee => 10.00;
  double get totalAmount => orderTotal + deliveryFee;

  void removeItem(int index) {
    setState(() => cartItems.removeAt(index));
  }

  void updateQuantity(int index, int quantity) {
    setState(() {
      cartItems[index].quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product List
            ...List.generate(cartItems.length, (index) {
              final item = cartItems[index];
              return SizedBox(
                height: 140,
                child: Card(
                  elevation: 1,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.teal[100],
                          ),
                          width: 80,
                          height: 80,
                          child: Image.asset(item.imagePath, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.price.toStringAsFixed(2)} LYD',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => removeItem(index),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            QuantityWidget(
                              quantity: item.quantity,
                              onChanged:
                                  (value) => updateQuantity(index, value),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Order Summary
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'Order Total',
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                '${orderTotal.toStringAsFixed(2)} LYD',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Text(
                                'Order savings',
                                style: TextStyle(fontSize: 16),
                              ),
                              Spacer(),
                              Text('00.00 LYD', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'Delivery fees',
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                '${deliveryFee.toStringAsFixed(2)} LYD',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${totalAmount.toStringAsFixed(2)} LYD',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Handle checkout
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Quantity Widget
class QuantityWidget extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
          iconSize: 16,
        ),
        Text(quantity.toString(), style: const TextStyle(fontSize: 14)),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onChanged(quantity + 1),
          iconSize: 16,
        ),
      ],
    );
  }
}
