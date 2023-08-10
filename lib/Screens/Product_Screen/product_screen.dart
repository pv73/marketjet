import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:marketjet/Screens/List/special_product_list.dart';
import 'package:marketjet/ui_helpher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Product_Screen extends StatefulWidget {
  var speIndex;
  Product_Screen({required this.speIndex});
  @override
  State<Product_Screen> createState() =>
      _Product_ScreenState(speIndex: speIndex);
}

class _Product_ScreenState extends State<Product_Screen>
    with TickerProviderStateMixin {
  var speIndex;
  _Product_ScreenState({required this.speIndex});

  late TabController _tabController;
  var activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeef5fa),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    //// product slider section /////
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 300,
                      child: Stack(
                        children: [
                          PageView(
                            // itemCount: (speProductList[speIndex]['spe_ProImages'] as List).length,
                            pageSnapping: true,
                            onPageChanged: (index) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                            children: [
                              Container(
                                padding: EdgeInsets.all(35),
                                child: Image.asset(
                                    speProductList[speIndex]['spe_Image'].toString()),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                child:
                                    Image.asset("assets/image/product/product_2.png"),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                child:
                                    Image.asset("assets/image/product/product_3.png"),
                              ),
                            ],
                          ),

                          /// top Btn ///
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColor.WhiteColor,
                                      ),
                                      child: Icon(Icons.arrow_back_ios_new, size: 20),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColor.WhiteColor,
                                    ),
                                    child: Icon(Icons.share, size: 20),
                                  ),
                                  widthSpacer(),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColor.WhiteColor,
                                    ),
                                    child: Icon(Icons.favorite_border, size: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// bottom Indicator ///
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: buildIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Product Name And Rating //
                    heightSpacer(mHeight: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                          color: AppColor.WhiteColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            speProductList[speIndex]['spe_Name'].toString(),
                            style:
                                TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          heightSpacer(mHeight: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    speProductList[speIndex]['spe_Prise'].toString(),
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w700),
                                  ),
                                  heightSpacer(mHeight: 8),
                                  Row(
                                    children: [
                                      Container(
                                        width: 45,
                                        height: 17,
                                        decoration: BoxDecoration(
                                            color: AppColor.OrangeColor,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star,
                                                color: AppColor.WhiteColor, size: 15),
                                            Text(
                                              "4.8",
                                              style: mTextStyle13(
                                                  mColor: AppColor.WhiteColor),
                                            )
                                          ],
                                        ),
                                      ),
                                      widthSpacer(mWidth: 5),
                                      Text(
                                        speProductList[speIndex]['spe_Rating'],
                                        style: mTextStyle13(),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                "Seller : ${speProductList[speIndex]['spe_Seller']}",
                                style: mTextStyle13(mFontWeight: FontWeight.w500),
                              ),
                            ],
                          ),

                          /// color Section //
                          heightSpacer(mHeight: 15),
                          Text("Color",
                              style: mTextStyle16(
                                  mFontWeight: FontWeight.w700,
                                  mColor: AppColor.BlackColor)),
                          heightSpacer(mHeight: 7),
                          Container(
                            height: 25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    (speProductList[speIndex]['spe_Color'] as List)
                                        .length,
                                itemBuilder: (context, colorIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Container(
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Color(speProductList[speIndex]
                                              ['spe_Color'][colorIndex] as int),
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),

                    //// Taping Selection////
                    Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      child: DefaultTabController(
                        length: 3,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          color: AppColor.WhiteColor,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                controller: _tabController,
                                labelColor: AppColor.WhiteColor,
                                unselectedLabelColor: AppColor.BlackColor,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                indicator: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(50), // Creates border
                                    color: AppColor.OrangeColor),
                                tabs: <Widget>[
                                  Tab(text: 'Description'),
                                  Tab(text: 'Specifications'),
                                  Tab(text: 'Reviews'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: <Widget>[
                                    // first tab bar view widget
                                    Container(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                            speProductList[speIndex]['spe_Desc'],
                                          textAlign: TextAlign.justify,
                                        ),
                                    ),

                                    // second tab bar view widget
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                          speProductList[speIndex]['spe_Spec'],
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),

                                    // third tab bar view widget
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                          speProductList[speIndex]['spe_Spec'],
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ),
          ),

          /// Bottom Button Section ///
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.07,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.BlackColor,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: AppColor.WhiteColor)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.remove, color: AppColor.WhiteColor, size: 17),
                            Text("1", style: TextStyle(color: Colors.white)),
                            Icon(Icons.add, color: AppColor.WhiteColor, size: 17)
                          ],
                        ),
                    ),
                  ),

                  widthSpacer(mWidth: 20),
                  Expanded(
                    flex: 2,
                      child: Container(
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.OrangeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            )
                          ),
                          child: Text("Add to Cart"),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),

    );
  }



  /// slider Indicator //
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      count: 3,
      activeIndex: activeIndex,
      effect: WormEffect(
          spacing: 4.0,
          radius: 10.0,
          dotWidth: 9.0,
          dotHeight: 7.0,
          paintStyle: PaintingStyle.stroke,
          activeDotColor: Colors.indigo),
    );
  }
}
