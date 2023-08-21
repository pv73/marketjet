import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketjet/models/product_model.dart';

import '../models/cart_model.dart';

class FirebaseProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String bannerCollection = "banners";
  String categoriesCollection = "category";
  String productCollection = "products";
  String userCollection = "users";

  /*addProducts() {
    for (int i = 0; i < 11; i++) {
      firestore.collection(productCollection).add(ProductModel(
          "1",
          "1",
          ["#ffff00", "#00ff00", "#0000ff"],
          "Nike Shoes ",
          "20",
          [
            "https://static.nike.com/a/images/t_default/99528c30-cd75-4646-bfad-af571bf6ae6e/court-vision-mid-next-nature-shoes-VKCWFj.png"
          ],
          "Shoes",
          "2499",
          "1",
          {
            "6": "2099",
            "7": "2199",
            "8": "2299",
            "9": "2399",
            "10": "2499",
          }).toMap());
    }
  }*/

  Stream<QuerySnapshot<Map<String, dynamic>>> getBanners() {
    var banners = firestore.collection(bannerCollection);
    return banners.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategories() {
    var banners = firestore.collection(categoriesCollection);
    return banners.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    var banners = firestore.collection(productCollection);
    return banners.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductById(String productId) {
    var products = firestore.collection(productCollection);
    return products.where('product_id', isEqualTo: productId).snapshots();
  }

  addToCart(String userId, CartModel cartModel) {
    firestore
        .collection(userCollection)
        .doc(userId)
        .collection("mycart")
        .add(cartModel.toMap());
  }
}
