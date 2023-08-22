import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketjet/firebase/firebase_provider.dart';
import 'package:marketjet/models/order_detail_model.dart';
import 'package:marketjet/ui_helpher.dart';

import '../../models/cart_model.dart';

class Cart_Screen extends StatefulWidget {
  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> cartStream;

  List<String> arrProductId = [];

  int totalAmt = 0;

  int totalCount = 0;

  @override
  void initState() {
    super.initState();

    cartStream = FirebaseProvider().getUserCart("XVVrqOb6RDFpd7hjCOjt");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: StreamBuilder(
        stream: cartStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              List<CartModel> arrCart = [];

              for (DocumentSnapshot doc in snapshot.data!.docs) {
                var model =
                    CartModel.fromMap(doc.data() as Map<String, dynamic>);
                arrCart.add(model);
                arrProductId.add(model.product_id);
                totalAmt += int.parse(model.price) * model.count;
                totalCount += model.count;
              }

              return Stack(
                children: [
                  ListView.builder(
                      itemCount: arrCart.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: Image.network(arrCart[index].image),
                          title: Text('${arrCart[index].name}'),
                          subtitle: Text('${arrCart[index].desc}'),
                          trailing: Text(
                              '\$ ${int.parse(arrCart[index].price) * arrCart[index].count}'),
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseProvider().placeOrder(
                            "XVVrqOb6RDFpd7hjCOjt",
                            OrderDetailModel(
                                "XVVrqOb6RDFpd7hjCOjt",
                                "1",
                                arrProductId,
                                totalAmt.toString(),
                                totalCount,
                                "address"));
                      },
                      child: Text('Checkout'),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text('Cart Empty!!'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.OrangeColor,
            ),
          );
        },
      )),
    );
  }
}
