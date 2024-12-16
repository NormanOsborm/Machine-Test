import 'package:firebasepro/machinetestwo/firstqs/screen/details.dart';
import 'package:firebasepro/machinetestwo/firstqs/screen/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model1.dart';
import '../provider/provider.dart';

class ProductSearchDelegate extends SearchDelegate<Wel> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        (Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductListingPage()))
            as BuildContext);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).filterProducts(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final suggestions = productProvider.products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.title),
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
  }
}
