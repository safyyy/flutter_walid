import 'package:crud_flutter/add_product.dart';
import 'package:crud_flutter/product.dart';
import 'package:crud_flutter/services/productapi.dart';
import 'package:crud_flutter/update_product.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Crud Interface'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product>? products;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async {
    products = await ProductApi().getAllProducts();
    setState(() {
      isLoaded = true;
    });
  }
Future<void>showMessageDialog(String title,String msg)async{
  return showDialog<void>(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(
            msg,
          ),
        ),
        actions: <Widget>[
          TextButton( child: Text('OK'),onPressed: ()=>Navigator.of(context).pop(),)
        ],
      );
    }
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: products?.length ?? 0,
          itemBuilder: (context, index) {
            final product = products![index];
            return Card(
              child: ListTile(
                title: Text(product.libele ?? 'No label'),
                subtitle: Text('Stock: ${product.price ?? 0}'),
                leading: CircleAvatar(
                  radius: 25,
                  child: Text('${product.id ?? 0}'),
                ),
                trailing: SizedBox(
                  width: 60,
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Colors.black.withOpacity(0.75),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProduct(
                                product: product,
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        child: const Icon(Icons.delete),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProduct(),
            ),
          ).then((data) {
            if (data !=null){
              showMessageDialog("Success", "$data Detail Add Success");
              getRecord();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
