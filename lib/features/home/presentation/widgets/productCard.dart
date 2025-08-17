import 'package:flutter/material.dart';

class NewProductCard extends StatelessWidget {
  final String brand;
  final String name;
  final String price;
  final String? discountedPrice;
  final String imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const NewProductCard({
    Key? key,
    required this.brand,
    required this.name,
    required this.price,
    this.discountedPrice,
    required this.imagePath,
    this.onTap,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? discountPercent;
    if (discountedPrice != null && discountedPrice!.isNotEmpty) {
      final original =
          double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      final discounted =
          double.tryParse(
            discountedPrice!.replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          0;
      if (original > 0 && discounted < original) {
        discountPercent = ((original - discounted) / original) * 100;
      }
    }
    return SizedBox(
      width: 180, // 👈 Fixed width so it's safe inside ListView/Column
      child: Card(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed-size image container
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 150, // 👈 still keeps it smaller
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "$discountPercent% تخفيض",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.favorite_border, color: Colors.teal),
                  ),
                ],
              ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brand,
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Column(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        discountedPrice!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
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
