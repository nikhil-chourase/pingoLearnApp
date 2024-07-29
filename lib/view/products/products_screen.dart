

import 'package:flutter/material.dart';
import 'package:pingolearnapp/components/custom_widgets.dart';
import 'package:pingolearnapp/controllers/product/product_provider.dart';
import 'package:pingolearnapp/global.dart';
import 'package:provider/provider.dart';




class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'e-Shop',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          ),
         ),
       ),

        body: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (productProvider.errorMessage != null) {
            //  
              return Center(child: Text(productProvider.errorMessage!));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 1.85 / 3, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                ),
                itemCount: productProvider.products!.length,
                itemBuilder: (context, index) {
                  final product = productProvider.products![index];
                  return customGridTile(product, context);
                },
              );
            }
          },
        ),
      );
  }
}
