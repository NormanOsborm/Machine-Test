import 'package:firebasepro/machineTest/fourthqs/screen/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../service/service.dart';
void main(){
  runApp(MaterialApp(home: ProductListingPage(),debugShowCheckedModeBanner: false,));
}


class ProductListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Welcome>>(
        future: HttpService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching products'));
          } else if (snapshot.hasData) {
            var products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return ListTile(
                  leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toString()}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}