class CartModel {
  String cart_id;
  String cat_id;
  String sub_cat_id;
  String product_id;
  String desc;
  String image;
  String name;
  String price;
  int count;

  CartModel(this.cart_id, this.cat_id, this.sub_cat_id, this.product_id,
      this.desc, this.image, this.name, this.price, this.count);

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      map['cart_id'],
      map['cat_id'],
      map['sub_cat_id'],
      map['product_id'],
      map['desc'],
      map['image'],
      map['name'],
      map['price'],
      map['count'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cart_id': cart_id,
      'cat_id': cat_id,
      'sub_cat_id': sub_cat_id,
      'product_id': product_id,
      'name': name,
      'desc': desc,
      'image': image,
      'price': price,
      'count': count
    };
  }
}
