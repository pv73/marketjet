import 'package:flutter/material.dart';

class Product_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 250,
              child: PageView.builder(
                  itemCount: 2,
                  pageSnapping: true,
                  itemBuilder: (context,pagePosition){
                    return Container(
                        color: Colors.red,
                        child: Image.asset("assets/image/product/product_1.png"),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
