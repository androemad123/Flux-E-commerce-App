import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/presentation/home/my_profile.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routing/routes.dart';
import '../resources/styles_manager.dart';

class BaseHomeScreen extends StatefulWidget {
  const BaseHomeScreen({super.key});

  @override
  State<BaseHomeScreen> createState() => _BaseHomeScreenState();
}

class _BaseHomeScreenState extends State<BaseHomeScreen> {
  int selectedIndex = 0;
  int _currentImg = 0;
  int _currentBottomNavIndex = 0;

  final List<IconData> categoryIcons = [
    Icons.female,
    Icons.male,
    Icons.watch,
    Icons.brush_rounded,
  ];

  final List<String> categoryNames = ["Women", "Men", "Accessories", "Beauty"];

  // dummy data
  final Map<String, Map<String, dynamic>> categoryData = {
    "Women": {
      "slider_images": [
        "https://images.pexels.com/photos/974911/pexels-photo-974911.jpeg",
        "https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg",
        "https://images.pexels.com/photos/1375736/pexels-photo-1375736.jpeg",
        "https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg"
      ],
      "header_image":
          "https://images.pexels.com/photos/1375736/pexels-photo-1375736.jpeg",
      "recommended": [
        {
          "name": "Women's Jacket",
          "price": 79.99,
          "image":
              "https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg"
        },
        {
          "name": "Summer Dress",
          "price": 55.00,
          "image":
              "https://images.pexels.com/photos/985635/pexels-photo-985635.jpeg"
        },
        {
          "name": "Casual Shirt",
          "price": 35.99,
          "image":
              "https://images.pexels.com/photos/2065195/pexels-photo-2065195.jpeg"
        },
      ],
      "collection_images": [
        "https://images.pexels.com/photos/1375736/pexels-photo-1375736.jpeg",
        "https://images.pexels.com/photos/974911/pexels-photo-974911.jpeg",
        "https://images.pexels.com/photos/2065200/pexels-photo-2065200.jpeg",
        "https://images.pexels.com/photos/994523/pexels-photo-994523.jpeg"
      ]
    },
    "Men": {
      "slider_images": [
        "https://images.pexels.com/photos/769733/pexels-photo-769733.jpeg",
        "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
        "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg"
      ],
      "header_image":
          "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
      "recommended": [
        {
          "name": "Men's Sweater",
          "price": 65.99,
          "image":
              "https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg"
        },
        {
          "name": "Formal Suit",
          "price": 199.99,
          "image":
              "https://images.pexels.com/photos/45055/pexels-photo-45055.jpeg"
        },
        {
          "name": "Casual T-Shirt",
          "price": 25.99,
          "image":
              "https://images.pexels.com/photos/1484807/pexels-photo-1484807.jpeg"
        },
      ],
      "collection_images": [
        "https://images.pexels.com/photos/769733/pexels-photo-769733.jpeg",
        "https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg",
        "https://images.pexels.com/photos/1598507/pexels-photo-1598507.jpeg",
        "https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg"
      ]
    },
    "Accessories": {
      "slider_images": [
        "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg",
        "https://images.pexels.com/photos/702251/pexels-photo-702251.jpeg",
        "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg"
      ],
      "header_image":
          "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg",
      "recommended": [
        {
          "name": "Backpack",
          "price": 85.00,
          "image":
              "https://images.pexels.com/photos/2905238/pexels-photo-2905238.jpeg"
        },
        {
          "name": "Necklace",
          "price": 45.00,
          "image":
              "https://images.pexels.com/photos/965981/pexels-photo-965981.jpeg"
        },
        {
          "name": "Bracelet",
          "price": 35.00,
          "image":
              "https://images.pexels.com/photos/1099816/pexels-photo-1099816.jpeg"
        },
      ],
      "collection_images": [
        "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg",
        "https://images.pexels.com/photos/702251/pexels-photo-702251.jpeg",
        "https://images.pexels.com/photos/1152077/pexels-photo-1152077.jpeg",
        "https://images.pexels.com/photos/2905238/pexels-photo-2905238.jpeg"
      ]
    },
    "Beauty": {
      "slider_images": [
        "https://images.pexels.com/photos/2536965/pexels-photo-2536965.jpeg",
        "https://images.pexels.com/photos/1040424/pexels-photo-1040424.jpeg",
        "https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg"
      ],
      "header_image":
          "https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg",
      "recommended": [
        {
          "name": "Lipstick Set",
          "price": 45.00,
          "image":
              "https://images.pexels.com/photos/2648705/pexels-photo-2648705.jpeg"
        },
        {
          "name": "Face Cream",
          "price": 55.00,
          "image":
              "https://images.pexels.com/photos/4041392/pexels-photo-4041392.jpeg"
        },
        {
          "name": "Hair Care",
          "price": 35.00,
          "image":
              "https://images.pexels.com/photos/4041391/pexels-photo-4041391.jpeg"
        },
      ],
      "collection_images": [
        "https://images.pexels.com/photos/2536965/pexels-photo-2536965.jpeg",
        "https://images.pexels.com/photos/1040424/pexels-photo-1040424.jpeg",
        "https://images.pexels.com/photos/3373739/pexels-photo-3373739.jpeg",
        "https://images.pexels.com/photos/2648705/pexels-photo-2648705.jpeg"
      ]
    }
  };

  Map<String, dynamic> get currentCategoryData {
    return categoryData[categoryNames[selectedIndex]] ?? {};
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDark =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteLight,
        title: Center(
          child: Text("GemStore",
              style: boldStyle(
                  fontSize: FontSize.s16, color: ColorManager.primaryLight)),
        ),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: ColorManager.primaryLight,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: ColorManager.primaryLight,
              ))
        ],
      ),

      drawer: Drawer(
      backgroundColor: ColorManager.whiteLight,

      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage("https://wallpapers.com/images/hd/generic-male-avatar-icon-piiktqtfffyzulft.jpg"),
                ),
                title: Text("Name of user" , style: TextStyle(
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.primaryLight,
                ),),
                subtitle: Text("his email", style: TextStyle(
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.primaryLight,
                  fontSize: FontSize.s16,
                ),),
              ),
            ),
          ),
          ListTile(leading: Icon(Icons.home , size: AppSize.s30,),
            title: Text('Home' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){},
          ),
          ListTile(leading: Icon(Icons.search , size: AppSize.s30,),
            title: Text('Discover' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){},
          ),
          ListTile(leading: Icon(Icons.shopping_bag , size: AppSize.s30,),
            title: Text('My Order' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){},
          ),
          ListTile(leading: Icon(Icons.person , size: AppSize.s30,),
            title: Text('My Profile' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> my_profile()));
            },
          ),

          Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: ListTile(title: Text('OTHER', style: TextStyle(
              fontSize: FontSize.s18,
            ),),),
          ),
          ListTile(leading: Icon(Icons.settings , size: AppSize.s30,),
            title: Text('Settings' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){

            },
          ),
          ListTile(leading: Icon(Icons.mail_outline_sharp , size: AppSize.s30,),
            title: Text('Support' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){},
          ),
          ListTile(leading: Icon(Icons.info_outline , size: AppSize.s30,),
            title: Text('About us' , style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),),
            onTap: (){},
          ),
          SizedBox(height:10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.lighterGrayLight,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isDark = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: !isDark ? ColorManager.whiteLight :Colors.transparent,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                size: AppSize.s28,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Light',
                                style: TextStyle(
                                  fontWeight: !isDark ? FontWeightManager.bold:FontWeightManager.regular,
                                  fontSize: FontSize.s18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isDark=true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark ? ColorManager.whiteLight : Colors.transparent,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.dark_mode_outlined,
                                size: AppSize.s28,
                                color: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Dark',
                                style: TextStyle(
                                  fontWeight: isDark? FontWeightManager.bold : FontWeightManager.regular,
                                  fontSize: FontSize.s18,
                                  color: Colors.black,
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
        ],
      ),
    ),


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              _buildCategorySection(),
              SizedBox(height: 20.h),
              _buildSliderBanner(),
              SizedBox(height: 20.h),
              _buildFeaturedProductsSection(),
              SizedBox(height: 10.h),
              _buildPromoBanner(),
              SizedBox(height: 20.h),
              _buildRecommendedSection(),
              SizedBox(height: 20.h),
              _buildTopCollectionSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(categoryIcons.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            context.read<ProductBLoC>().add(LoadCategoryProduct(ProductCategotry: categoryNames[index]));
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: ColorManager.primaryLight,
                          width: 2.w,
                        )
                      : null,
                ),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? ColorManager.primaryLight
                        : ColorManager.lighterGrayLight.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Icon(
                      categoryIcons[index],
                      color: isSelected
                          ? ColorManager.whiteLight
                          : ColorManager.primaryLight,
                      size: AppSize.s20, //12.sp
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                categoryNames[index],
                style: isSelected
                    ? boldStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.primaryLight,
                      )
                    : regularStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.lighterGrayLight,
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSliderBanner() {
    final sliderImages =
        (currentCategoryData["slider_images"] as List<dynamic>?)
                ?.cast<String>() ??
            [];

    return Container(
      height: 312.h,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: sliderImages.length,
            onPageChanged: (img) {
              setState(() {
                _currentImg = img;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  sliderImages[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          if (sliderImages.length > 1)
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(sliderImages.length, (index) {
                    final isActive = _currentImg == index;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: AppMargin.m4),
                      width: isActive ? 16.w : 8.w,
                      height: isActive ? 16.h : 8.h,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorManager.whiteLight,
                            width: 1.w,
                          )),
                      child: Center(
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: ColorManager.whiteLight,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProductsSection() {
    return BlocBuilder<ProductBLoC,ProductState>(builder: (context,state){
      final products = state.product;
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Products",
                  style: boldStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.darkGrayLight,
                  ),
                ),
                Text(
                  "Show all",
                  style: regularStyle(
                    fontSize: FontSize.s12,
                    color: ColorManager.lightGrayLight,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            height: 277.h, //200
            child: products.isEmpty ? Text("No product found") : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.orderDetailsScreen, arguments: product.ProductID);
                  },
                  child: Container(
                    width: 120.w,
                    margin: EdgeInsets.only(right: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            product.ProductImageURL,
                            height: 190.h,
                            width: 120.w,
                            fit: BoxFit.cover,
                            errorBuilder:  (context, error, stackTrace) => Icon(Icons.image_not_supported , size: AppSize.s32,),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          product.ProductName,
                          style: regularStyle(
                            color: ColorManager.primaryLight,
                            fontSize: FontSize.s12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "\$${product.ProductPrice.toStringAsFixed(2)}",
                          style: boldStyle(
                            color: ColorManager.primaryLight,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPromoBanner() {
    final headerImage = currentCategoryData["header_image"] as String? ?? "";

    return Container(
      width: double.infinity,
      height: 158.h,
      child: ClipRRect(
        child: Image.network(
          headerImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRecommendedSection() {
    final recommended = (currentCategoryData["recommended"] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>() ??
        [];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
                style: boldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.darkGrayLight,
                ),
              ),
              Text(
                "Show all",
                style: regularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.lightGrayLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommended.length,
            itemBuilder: (context, index) {
              final product = recommended[index];
              return Container(
                width: 213.w,
                margin: EdgeInsets.only(right: AppMargin.m12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ColorManager.lighterGrayLight.withOpacity(0.5),
                    width: 0.5.w,
                  ),
                  color: ColorManager.whiteLight,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                      child: Image.network(
                        product["image"],
                        height: 100.h,
                        width: 66.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"],
                            style: regularStyle(
                              fontSize: FontSize.s12,
                              color: ColorManager.primaryLight,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "\$${product["price"].toStringAsFixed(2)}",
                            style: boldStyle(
                              color: ColorManager.primaryLight,
                              fontSize: FontSize.s12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopCollectionSection() {
    final collectionImages =
        (currentCategoryData["collection_images"] as List<dynamic>?)
                ?.cast<String>() ??
            [];

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Collection",
                style: boldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.darkGrayLight,
                ),
              ),
              Text(
                "Show all",
                style: regularStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.lightGrayLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        if (collectionImages.length >= 1)
          Container(
            width: double.infinity,
            height: 141.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                collectionImages[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height: 15.h),
        if (collectionImages.length >= 2)
          Container(
            width: double.infinity,
            height: 229.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                collectionImages[1],
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height: 15.h),
        if (collectionImages.length >= 4)
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 194.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      collectionImages[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Container(
                  height: 194.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      collectionImages[3],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
