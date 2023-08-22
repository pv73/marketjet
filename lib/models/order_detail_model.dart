class OrderDetailModel {
  String user_id;
  String order_id;
  List<String> product_id;
  String totalAmt;
  int totalQty;
  String address;

  OrderDetailModel(
      this.user_id,
      this.order_id,
      this.product_id,
      this.totalAmt,
      this.totalQty,
      this.address);

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
        map['user_id'],
        map['order_id'],
        map['product_id'],
        map['totalAmt'],
        map['totalQty'],
        map['address']);
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id':user_id,
      'order_id': order_id,
      'product_id': product_id,
      'totalAmt': totalAmt,
      'totalQty': totalQty,
      'address': address,
    };
  }
}
