class ProductModel {
  String cat_id;
  String sub_cat_id;
  String product_id;
  List<dynamic> colors;
  String desc;
  String discount;
  List<dynamic> images;
  String name;
  String price;
  Map<String, dynamic> sizes;

  ProductModel(this.cat_id, this.sub_cat_id, this.colors, this.desc, this.discount, this.images, this.name,
      this.price, this.product_id, this.sizes);

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        map['cat_id'],
        map['sub_cat_id'],
        map['colors'],
        map['desc'],
        map['discount'],
        map['images'],
        map['name'],
        map['price'],
        map['product_id'],
        map['sizes']);
  }

  Map<String, dynamic> toMap(){
    return {
      'cat_id':cat_id,
      'sub_cat_id':sub_cat_id,
      'product_id':product_id,
      'colors':colors,
      'name':name,
      'desc':desc,
      'images':images,
      'price':price,
      'sizes':sizes,
      'discount':discount,
    };
  }
}
