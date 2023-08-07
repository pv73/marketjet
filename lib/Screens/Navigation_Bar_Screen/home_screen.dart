import 'package:flutter/material.dart';
import 'package:marketjet/Screens/Product_Screen/product_screen.dart';
import 'package:marketjet/ui_helpher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
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
                      height: 45,
                      width: 45,
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.GreyColor,
                      ),
                      child: Image.asset("assets/image/icons/ic_more.png"),
                    ),
                    Container(
                      height: 45,
                      width: 45,
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
                CarouselSlider.builder(
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
                ),

                //// Slider Indicator ///
                heightSpacer(mHeight: 8),
                buildIndicator(),

                /// Row Slider Section ///
                heightSpacer(mHeight: 20),
                Container(
                  height: 110,
                  child: ListView.builder(
                      itemCount: productList.length,
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
                                backgroundImage: AssetImage(
                                    productList[proIndex]['proImage']
                                        .toString()),
                              ),
                              heightSpacer(mHeight: 5),
                              Text(productList[proIndex]['proName'].toString(),
                                  style: mTextStyle13()),
                            ],
                          ),
                        );
                      }),
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
                  child: GridView.builder(
                    itemCount: speProductList.length,
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
                              MaterialPageRoute(builder: (context)=> Product_Screen()),
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
                                            image: AssetImage(speProductList[speIndex]
                                                    ['spe_Image']
                                                .toString()),
                                            fit: BoxFit.cover)),
                                  ),
                                  heightSpacer(),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      speProductList[speIndex]['spe_Name'].toString(),
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
                                          Text(speProductList[speIndex]['spe_Prise']
                                              .toString(),
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
                  image: AssetImage(sliderImage[index]), fit: BoxFit.cover)),
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
    "assets/image/slider/slider_1.jpg",
    "assets/image/slider/slider_2.jpg",
    "assets/image/slider/slider_3.jpg",
    "assets/image/slider/slider_4.jpg",
  ];

  ///// Product List ////
  final productList = [
    {'proName': 'Shoes', 'proImage': 'assets/image/product/shoe.jpg'},
    {'proName': 'Beauty', 'proImage': 'assets/image/product/makeup.jpg'},
    {
      'proName': "Women's \nFashion",
      'proImage': 'assets/image/product/makeup.jpg'
    },
    {'proName': 'Jewelry', 'proImage': 'assets/image/product/jewellery.jpg'},
    {
      'proName': "Men's Fashion",
      'proImage': 'assets/image/product/man_fasion.jpeg'
    },
    {'proName': 'Shirt', 'proImage': 'assets/image/product/shirt.jpg'},
    {'proName': 'Fashion', 'proImage': 'assets/image/product/shoe_2.jpg'}
  ];

  ///// Special Product List ////
  List<Map<String, dynamic>> speProductList = [
    {
      'spe_Name': 'Shoes',
      'spe_Image': 'assets/image/product/product_1.png',
      'spe_Prise': 'INR 200'
    },
    {
      'spe_Name': "Shoes",
      'spe_Image': 'assets/image/product/product_2.png',
      'spe_Prise': 'INR 300'
    },
    {
      'spe_Name': 'HeadPhone',
      'spe_Image': 'assets/image/product/product_3.png',
      'spe_Prise': 'INR 450'
    },
    {
      'spe_Name': "wireless Earbuds",
      'spe_Image': 'assets/image/product/product_4.png',
      'spe_Prise': 'INR 250'
    },
    {
      'spe_Name': 'wireless Earbuds',
      'spe_Image': 'assets/image/product/product_5.png',
      'spe_Prise': 'INR 500'
    },
    {
      'spe_Name': 'Kids shirt',
      'spe_Image': 'assets/image/product/product_6.png',
      'spe_Prise': 'INR 600'
    },
    {
      'spe_Name': 'Ladies Shirt',
      'spe_Image': 'assets/image/product/product_7.png',
      'spe_Prise': 'INR 280'
    }
  ];
}
