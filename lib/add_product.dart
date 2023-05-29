import 'package:crud_flutter/services/productapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var idController =TextEditingController();
  var  libelleController = TextEditingController();
  var stockController = TextEditingController();
  var  priceController = TextEditingController();
  var  photoController = TextEditingController();
  var  fabricationController = TextEditingController();
  var  expirationController = TextEditingController();
  final FocusNode focusNode=FocusNode();
  bool _validatelib= false ;
  bool _validatest=false;
  bool _validatepr=false;
  bool _validateph=false;
  bool _validatefab=false;
  bool _validateexp=false;


  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),
            getMyfield(
              errText: _validatelib,

              focusNode:focusNode,
              hintText: 'libelle',
              controller: libelleController
              ),
            getMyfield(errText: _validatest,hintText: 'stock' ,textInputType: TextInputType.number,controller: stockController),
            getMyfield(errText: _validatepr,hintText: 'price' ,textInputType: TextInputType.number,controller: priceController),
            getMyfield(errText: _validateph,hintText: 'photo' ,controller: photoController),
            getMyfield(errText: _validatefab,hintText: 'date fabrication',textInputType:TextInputType.datetime ,controller: fabricationController),
            getMyfield(errText: _validateexp,hintText: 'date expiration',textInputType:TextInputType.datetime ,controller: expirationController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ElevatedButton(
                onPressed: ()async{

                  setState(() {
                    libelleController.text.isEmpty?_validatelib=true:_validatelib=false;
                    stockController.text.isEmpty?_validatest=true:_validatelib=false;
                    priceController.text.isEmpty?_validatepr=true:_validatelib=false;
                    photoController.text.isEmpty?_validateph=true:_validatelib=false;
                    fabricationController.text.isEmpty?_validatefab=true:_validatelib=false;
                    expirationController.text.isEmpty?_validateexp=true:_validatelib=false;

                  });

                  if(_validatelib==false&& _validatest==false&& _validatepr==false&& _validateph==false&& _validatefab==false&& _validateexp==false){
                    var result =await ProductApi().addProduct(int.parse(idController.text), libelleController.text,int.parse( stockController.text), double.parse(priceController.text), photoController.text, DateTime.parse(fabricationController.text), DateTime.parse(expirationController.text));
                      Navigator.pop(context,result);
                  }

                },
              
              
              
              child:const Text('Add'), 
              ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:Colors.blueGrey
                    ),
                  
                  onPressed: (){
                //
                libelleController.text=''; 
                stockController.text='';
                priceController.text='';
                photoController.text='';
                fabricationController.text='';
                expirationController.text='';
                focusNode.requestFocus();
                //

              }, child:const Text('Reset'), 
              ),
            ],),

          ],

        ),
      ),
    );
  }
  Widget getMyfield({required bool errText,required String hintText ,TextInputType textInputType=TextInputType.name,required  TextEditingController controller, FocusNode? focusNode}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType:textInputType ,
        decoration: InputDecoration(
          hintText: 'Enter $hintText',
          labelText: hintText,
          errorText: errText?'Field can''t be Empty':null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))
          )
        ),
      ),
    );
  }
}