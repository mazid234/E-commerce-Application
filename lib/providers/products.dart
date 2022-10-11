import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Light Weight Shoes',
    //   description: 'A nice pair of shoes.',
    //   price: 29.99,
    //   imageUrl:
    //       'https://m.media-amazon.com/images/I/71BQcg-N+VL._AC_UY575_.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Sneakers',
    //   description: 'A nice pair of shoes.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://webmerx.sgp1.cdn.digitaloceanspaces.com/sweetylifestyle/product_images/1661165529jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Sneakers shoes',
    //   description: 'A nice pair of shoes.',
    //   price: 19.99,
    //   imageUrl: 'https://m.media-amazon.com/images/I/71ZSYJXb0GL._UY695_.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Grey and Orange shoes',
    //   description: 'A nice pair of shoes.',
    //   price: 49.99,
    //   imageUrl: 'https://m.media-amazon.com/images/I/71CJ1wLzPJL._UL1500_.jpg',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'White Shoes',
    //   description: 'White Shoes - it is nice pair of shoes!',
    //   price: 29.99,
    //   imageUrl:
    //       "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1025&q=80",
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'Black shoes',
    //   description: 'A nice pair of shoes.',
    //   price: 59.99,
    //   imageUrl: 'https://m.media-amazon.com/images/I/710g5NuZQBL._UL1500_.jpg',
    // ),
    // Product(
    //   id: 'p7',
    //   title: 'Orange Shoes',
    //   description: 'A nice pair of shoes.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/02/22/12/01/shoe-1215384_960_720.jpg',
    // ),
    // Product(
    //   id: 'p8',
    //   title: 'Yellow Shoes',
    //   description: 'A nice pair of shoes.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://m.media-amazon.com/images/I/81HOeaLb8bL._AC_UY575_.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   print("ashdkl: ${_items}");
    //   return _items
    //       .where((prodItem) => prodItem.isFavorite)
    //       .toList(); // jo bhi product item favorite hoga uski ek new list bnake return krega where method

    // }
    return [..._items];
    //giving a copy not direct refrence so that we can't edit product from anywhere in app
  }

  // alternative getter for favorite items only // agr in product grid me showfavs true h to ye getter laga do
  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items
        .firstWhere((prod) => prod.id == id); // specific id se item search krna
  }

  Future fetchAndSetProducts() async {
    final url = Uri.https(
        'flutter-update-1eb33-default-rtdb.firebaseio.com', '/products.json');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite']));
      });
      // print(
      //     "Productdata:${(jsonDecode(response.body))['-NE5Hq0o2J1lAFSXxvHx']['description']}");
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future addProduct(Product product) async {
    final url = Uri.https('flutter-update-1eb33-default-rtdb.firebaseio.com',
        '/products.json'); // post is future object with which we can use then function
    //every future has its then function, then is triggered once a response is there , future (post) will recieves a response
    //then itself returns a new future (then/catchError)
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      ); //then is executed when http.post is done
      // print("whats inside : ${json.decode(response.body) }");
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); //to add at the start of the list
      // print("hello new title:${product.id}");
      notifyListeners();
    } catch (error) {
      print("EEERRROOORRRR:${error}");
      throw error; // this error will now thrown from where this addproduct method is called eg ediproductscreen
      // THEN CODE WILL BE SKIPPED IF ERROR WAS THROWN AT POST CODE

    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    // final prodIndex = _items.indexWhere((prod) => prod.id == id);
    _items.removeWhere((prod) => prod.id == id);
    // if (prodIndex >= 0) {
    //   _items.removeAt(prodIndex);
    notifyListeners();
    // } else {
    //   print('...');
    // }
  }
}
