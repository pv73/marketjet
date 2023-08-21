import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketjet/Screens/List/special_product_list.dart';
import 'package:marketjet/Screens/Product_Screen/product_screen.dart';
import 'package:marketjet/firebase/firebase_provider.dart';
import 'package:marketjet/ui_helpher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/product_model.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> bannersStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> catStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> productStream;

  @override
  void initState() {
    super.initState();
    bannersStream = FirebaseProvider().getBanners();
    catStream = FirebaseProvider().getCategories();
    productStream = FirebaseProvider().getProducts();
  }


  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                /// top Btn ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.GreyColor,
                      ),
                      child: Image.asset("assets/image/icons/ic_more.png"),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.GreyColor,
                      ),
                      child:
                          Image.asset("assets/image/icons/ic_notification.png"),
                    ),
                  ],
                ),

                // Search Bar
                heightSpacer(mHeight: 17),
                Container(
                  height: 45,
                  child: TextFormField(
                    decoration: mInputDecoration(
                        padding: EdgeInsets.only(bottom: 5),
                        hint: "Search...",
                        hintColor: AppColor.GreyDark,
                        prefixIcon: Icon(Icons.search),
                        radius: 25,
                        suffixIcon: Icons.compare_arrows),
                  ),
                ),

                /// Slider Section ////
                heightSpacer(),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: bannersStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else if(snapshot.hasData){
                      sliderImage.clear();
                      for(DocumentSnapshot doc in snapshot.data!.docs){
                        sliderImage.add(doc.get('img'));
                      }

                      return CarouselSlider.builder(
                        itemCount: sliderImage.length,
                        itemBuilder: (context, index, realIndex) {
                          //// Widget Return
                          return sliderContainer(sliderImage, index);
                        },
                        options: CarouselOptions(
                            height: 160,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            autoPlayInterval: Duration(seconds: 2),
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            }),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: AppColor.OrangeColor,),);
                  }
                ),

                //// Slider Indicator ///
                heightSpacer(mHeight: 8),
                buildIndicator(),

                /// Row Slider Section ///
                heightSpacer(mHeight: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: catStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(child: Text('${snapshot.error}'),);
                    } else if(snapshot.hasData){
                      var data = snapshot.data;
                      
                      var catList = [];
                      
                      for(DocumentSnapshot doc in data!.docs){
                        catList.add({
                          'img': doc.get('img'),
                          'name': doc.get('cat_name')
                        });
                      }

                      
                      return Container(
                        height: 110,
                        child: ListView.builder(
                            itemCount: catList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, proIndex) {
                              return Container(
                                width: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 33,
                                      backgroundColor: AppColor.OrangeColor,
                                      backgroundImage: NetworkImage(catList[proIndex]['img']),
                                    ),
                                    heightSpacer(mHeight: 5),
                                    Text(catList[proIndex]['name'],
                                        style: mTextStyle13()),
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: AppColor.OrangeColor,),);
                  }
                ),

                /// Special For You Selection ///
                heightSpacer(mHeight: 15),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Special For You",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("See all", style: mTextStyle13()),
                      )
                    ],
                  ),
                ),

                heightSpacer(mHeight: 15),
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  // color: Colors.red,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: productStream,
                    builder: (context, snapshot) {

                      if(snapshot.hasData){
                        List<ProductModel> listProduct = [];

                        for(DocumentSnapshot doc in snapshot.data!.docs){
                          listProduct.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
                        }

                          return GridView.builder(
                            itemCount: listProduct.length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 190),
                            itemBuilder: (context, speIndex) {
                              return InkWell(
                                onTap: () {
                                  print(speIndex);

                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> Product_Screen(speIndex: speIndex, productId: listProduct[speIndex].product_id,)),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.GreyColor,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(listProduct[speIndex].images[0]),
                                                    fit: BoxFit.cover)),
                                          ),
                                          heightSpacer(),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(
                                              listProduct[speIndex].name,
                                              style:
                                              mTextStyle16(mFontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          heightSpacer(mHeight: 5),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(listProduct[speIndex].price,
                                                  style: TextStyle(fontWeight: FontWeight.w700),
                                                ),

                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.red.shade800
                                                        ),
                                                      ),
                                                      widthSpacer(mWidth: 3),
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.grey.shade800
                                                        ),
                                                      ),
                                                      widthSpacer(mWidth: 3),
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.green.shade800
                                                        ),
                                                      ),
                                                      widthSpacer(mWidth: 3),
                                                      Container(
                                                        height: 12,
                                                        width: 12,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: Colors.blue.shade800
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),

                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: AppColor.OrangeColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              topRight: Radius.circular(10)
                                          ),
                                        ),
                                        child: Icon(Icons.favorite_border, color: AppColor.WhiteColor,size: 20),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                      }
                      return Center(child: CircularProgressIndicator(color: AppColor.OrangeColor),);
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Slider Container ////
  Widget sliderContainer(sliderImage, index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.GreyLight),
              image: DecorationImage(
                  image: NetworkImage(sliderImage[index]), fit: BoxFit.cover)),
        ),

        /// Order button selection //
        if (index == 0)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  print("order Now");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.OrangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                child: Text("Order Now",
                    style: mTextStyle13(mColor: AppColor.WhiteColor)),
              ),
            ),
          )
        else if (index == 2)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.OrangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                child: Text("Order Now",
                    style: mTextStyle13(mColor: AppColor.WhiteColor)),
              ),
            ),
          )
        else
          Container()
      ],
    );
  }

  /// slider Indicator //
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      count: sliderImage.length,
      activeIndex: activeIndex,
      effect: WormEffect(
          spacing: 4.0,
          radius: 8.0,
          dotWidth: 8.0,
          dotHeight: 5.0,
          paintStyle: PaintingStyle.stroke,
          activeDotColor: Colors.indigo),
    );
  }

  /// Slider Image List //
  final sliderImage = [
    /*"assets/image/slider/slider_1.jpg",
    "assets/image/slider/slider_2.jpg",
    "assets/image/slider/slider_3.jpg",
    "assets/image/slider/slider_4.jpg",*/
  ];

}
