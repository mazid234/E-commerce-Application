import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_007/providers/product.dart';
import 'package:flutter_application_007/providers/products.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

//we need global key
class _EditProductScreenState extends State<EditProductScreen> {
  static const routeName = '/EditProductScreen';

  var _isInit = true;
  var _isLoading = false;

  // final _titleController = TextEditingController();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageController =
      TextEditingController(); //to store the value feed in imageurl text field
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    "description": '',
    'imageUrl': '',
    'price': '',
  };

  @override
  void initState() {
    // _imageUrlFocusNode.addListener(
    // _updateImageUrl); // we need to add a listerner for the image urlfocusnode so if we change focus from imageurl to any other field it refresh ui
    // and we point to a function here that should be executed whenever the focus changes, without ()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      // print("PassedId:${productId}");
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId.toString());
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // void _updateImageUrl() {
  //   if (!_imageUrlFocusNode.hasFocus) {
  //     setState(() {});
  //   }
  // }

  Future _saveForm() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    } // it wil stop the further code to be executed
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    // print('savefrom Id ${_editedProduct.id}');
    if (_editedProduct.id != null) {
      // print("if is already runnig");
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id ?? '', _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An Error Occured"),
            content: Text(error
                .toString()), //error is bit technical and might be confidential
            actions: [
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.of(ctx).pop();
                  // Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      } finally {
        setState(() {
          // print('thennnnn');
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
      // setState(() {
      //   _isLoading = false;
      // });
      // Navigator.of(context).pop();

      //now we can use error in widget
      //with return next .then will be executed onces showDialog is done
    }

    // print(_editedProduct.id);
    // print(_editedProduct.title);
    // print(_editedProduct.description);
    // print(_editedProduct.price);
    // print(_editedProduct.imageUrl);
  }

//dispose to avoid memory leaks and avoid memory occupied
  @override
  void dispose() {
    // _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedProduct.id != null ? 'Edit Product' : "Add Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      //TextFormField is connected to form behind the scenes
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          validator: (title) {
                            if (title!.isEmpty) {
                              return 'Please enter a title';
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(
                                _priceFocusNode); //to move focuse on next field when user press submit or enter on keyboard
                          },
                          onSaved: (newTitle) {
                            _editedProduct = Product(
                              isFavorite: _editedProduct.isFavorite,
                              id: _editedProduct.id,
                              title: newTitle ?? '',
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['price'],
                          decoration: InputDecoration(labelText: 'Price'),
                          validator: (price) {
                            if (price!.isEmpty) {
                              return 'Please enter a price';
                            } // ye pass hoga tbhi next condition tk jayga
                            if (double.tryParse(price) == null) {
                              return 'Please enter a valid number';
                            }
                            if (double.parse(price) <= 0) {
                              return 'Please enter a amount greater than zero';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(
                                _descriptionFocusNode); //to move focuse on next field when user press submit or enter on keyboard
                          },
                          focusNode: _priceFocusNode,
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: (double.parse(newValue!)),
                                imageUrl: _editedProduct.imageUrl);
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          validator: (description) {
                            if (description!.isEmpty) {
                              return 'Please enter a description!';
                            }
                            if (description.length < 10) {
                              return 'Description length should be greater than 10 characters';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: newValue!,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl);
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(8),
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: _imageController.text.isEmpty
                                  ? Center(child: Text('Enter Url'))
                                  : FittedBox(
                                      child:
                                          Image.network(_imageController.text),
                                      fit: BoxFit.fill),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  // initialValue: _initValues['imageUrl'],
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      labelText: 'Enter Image Url'),
                                  controller: _imageController,
                                  focusNode: _imageUrlFocusNode,
                                  validator: (email) {
                                    if (email!.isEmpty) {
                                      return 'Please enter a email!';
                                    }

                                    return null;
                                  },
                                  onEditingComplete: () {
                                    setState(() {});
                                  },
                                  onFieldSubmitted: (_) {
                                    _saveForm();
                                  },
                                  onSaved: (newValue) {
                                    _editedProduct = Product(
                                        isFavorite: _editedProduct.isFavorite,
                                        id: _editedProduct.id,
                                        title: _editedProduct.title,
                                        description: _editedProduct.description,
                                        price: _editedProduct.price,
                                        imageUrl: newValue ?? '');
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
