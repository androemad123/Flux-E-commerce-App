import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/presentation/home/my_profile.dart';
import 'package:depi_graduation/presentation/home/notifications_screen.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/BLoC/ProductBLoC/ProductEvent.dart';
import '../../routing/routes.dart';
import '../resources/styles_manager.dart';
import '../shop together/shop_together_screen.dart';
import 'widgets/category_section.dart';
import 'widgets/slider_banner.dart';
import 'widgets/featured_products_section.dart';
import 'widgets/promo_banner.dart';
import 'widgets/recommended_section.dart';
import 'widgets/top_collection_section.dart';

class BaseHomeScreen extends StatefulWidget {
  const BaseHomeScreen({super.key});

  @override
  State<BaseHomeScreen> createState() => _BaseHomeScreenState();
}

class _BaseHomeScreenState extends State<BaseHomeScreen> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDark = true;

  final List<String> categoryNames = ["Women", "Men", "Accessories", "Beauty"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBLoC>().add(LoadAllProducts());
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NotificationsScreen()));              },
              icon: Icon(
                Icons.notifications,
                color: ColorManager.primaryLight,
              ))
        ],
      ),
      drawer: _buildDrawer(),
      body: BlocConsumer<ProductBLoC, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p12),
              child: Column(
                children: [
                  CategorySection(
                    selectedIndex: selectedIndex,
                    onCategorySelected: _onCategorySelected,
                  ),
                  SizedBox(height: 20.h),
                  SliderBanner(selectedCategory: categoryNames[selectedIndex]),
                  SizedBox(height: 20.h),
                  FeaturedProductsSection(),
                  SizedBox(height: 10.h),
                  PromoBanner(),
                  SizedBox(height: 20.h),
                  RecommendedSection(),
                  SizedBox(height: 20.h),
                  TopCollectionSection(
                      selectedCategory: categoryNames[selectedIndex]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: ColorManager.whiteLight,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(
                      "https://wallpapers.com/images/hd/generic-male-avatar-icon-piiktqtfffyzulft.jpg"),
                ),
                title: Text(
                  "Name of user",
                  style: TextStyle(
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.primaryLight,
                  ),
                ),
                subtitle: Text(
                  "his email",
                  style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.primaryLight,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ),
          ),
          _buildDrawerItem(Icons.add_shopping_cart_rounded, 'Shop Together',
              () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ShopTogetherScreen()));
          }),
          _buildDrawerItem(Icons.search, 'Discover', () {}),
          _buildDrawerItem(Icons.shopping_bag, 'My Orders', () {
            Navigator.pushNamed(context, Routes.myOrdersScreen);
          }),
          _buildDrawerItem(Icons.person, 'My Profile', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyProfile()));
          }),
          Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: ListTile(
                title: Text('OTHER', style: TextStyle(fontSize: FontSize.s18))),
          ),
          _buildDrawerItem(Icons.settings, 'Settings', () {}),
          _buildDrawerItem(Icons.mail_outline_sharp, 'Support', () {}),
          _buildDrawerItem(Icons.info_outline, 'About us', () {}),
          SizedBox(height: 10.h),
          _buildThemeSwitch(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: AppSize.s30,
        color: Colors.black87,
      ),
      title: Text(title,
          style: semiBoldStyle(fontSize: FontSize.s18, color: Colors.black87)),
      onTap: onTap,
    );
  }

  Widget _buildThemeSwitch() {
    return Padding(
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
                  onTap: () => setState(() => isDark = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      color: !isDark
                          ? ColorManager.whiteLight
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.wb_sunny_outlined,
                            size: AppSize.s28, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Light',
                          style: TextStyle(
                            fontWeight: !isDark
                                ? FontWeightManager.bold
                                : FontWeightManager.regular,
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
                  onTap: () => setState(() => isDark = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      color:
                          isDark ? ColorManager.whiteLight : Colors.transparent,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.dark_mode_outlined,
                            size: AppSize.s28, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Dark',
                          style: TextStyle(
                            fontWeight: isDark
                                ? FontWeightManager.bold
                                : FontWeightManager.regular,
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
    );
  }
}
