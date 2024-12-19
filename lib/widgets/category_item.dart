import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  //final String imageUrl;
  final String categoryName;

  const CategoryItem({
    super.key,
    //required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add a subtle shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Make image fill card width
        children: [
          Expanded( // Use Expanded to make the image take up available space
            child: ClipRRect( // Clip the image to the rounded corners
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              // child: Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover, // Cover the available space
              //   errorBuilder: (context, error, stackTrace) {
              //     return const Center(child: Icon(Icons.error)); // Show error icon if image fails to load
              //   },
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              categoryName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
