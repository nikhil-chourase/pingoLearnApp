




import 'package:flutter/material.dart';
import 'package:pingolearnapp/utils/remote_config.dart';
import 'package:pingolearnapp/model/product/product.dart';
import 'package:pingolearnapp/utils/price_calculator.dart';
import 'package:provider/provider.dart';


Widget customGridTile(Product product, BuildContext context) {
  final size = MediaQuery.of(context).size;

  final priceCalculator = Provider.of<PriceCalculator>(context, listen: false);
  
  final int priceInt = priceCalculator.calculatePrice(product.price);
  final int discountedPriceInt = priceCalculator.calculateDiscountedPrice(product.price, product.discountPercentage);
  

  return Consumer<RemoteConfigService>(
    
    builder: (context, remoteConfigService, child) {

      print(remoteConfigService.showDiscountedPrice);

      bool showDiscountedPrice = remoteConfigService.showDiscountedPrice;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    height: size.height / 4.9,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: Image.network(
                      product.thumbnail!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Color(0xff303f60),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 4.0),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    color: Color(0xff303f60),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Text(
                      '\$${priceInt.toString()}',
                      style: showDiscountedPrice ?  const TextStyle(
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12.0,
                        color: Color(0xff303f60),
                      ) :  const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: Color(0xff303f60),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 8),

                    if(showDiscountedPrice)      
                    Text(
                      '\$${discountedPriceInt.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: Color(0xff303f60),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(width: 8),
      
                    Text(
                      '${product.discountPercentage.toString()}%',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: Colors.green,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  );
}



