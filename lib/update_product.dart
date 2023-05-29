import 'package:crud_flutter/product.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatelessWidget {
  final Product product;
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController fabricationController = TextEditingController();
  final TextEditingController expirationController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  UpdateProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    libelleController.text = product.libele;
    stockController.text = '${product.stock}';
    priceController.text = '${product.price}';
    photoController.text = product.photo;
    fabricationController.text = product.fabricationDate.toString();
    expirationController.text = product.expirationDate.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            getMyField(
              focusNode: focusNode,
              hintText: 'libelle',
              controller: libelleController,
            ),
            getMyField(hintText: 'stock', controller: stockController),
            getMyField(hintText: 'price', controller: priceController),
            getMyField(hintText: 'photo', controller: photoController),
            getMyField(
              hintText: 'date fabrication',
              textInputType: TextInputType.datetime,
              controller: fabricationController,
            ),
            getMyField(
              hintText: 'date expiration',
              textInputType: TextInputType.datetime,
              controller: expirationController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // ToDo: Update a product
                  },
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                  onPressed: () {
                    libelleController.text = '';
                    stockController.text = '';
                    priceController.text = '';
                    photoController.text = '';
                    fabricationController.text = '';
                    expirationController.text = '';
                    focusNode.requestFocus();
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getMyField({
    required String hintText,
    TextInputType textInputType = TextInputType.name,
    required TextEditingController controller,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: 'Enter $hintText',
          labelText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}
