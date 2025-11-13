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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../app/BLoC/ProductBLoC/ProductEvent.dart';
import '../../routing/routes.dart';
import '../../generated/l10n.dart';
import '../../app/provider/language_provider.dart';
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
    // Check if this screen is currently the active route
    final isScreenActive = ModalRoute.of(context)?.isCurrent ?? true;
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteLight,
        title: Center(
          child: Text(S.of(context).appName,
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
          // Only reload products if this screen is active (visible)
          // When product details screen is shown, this screen is not active, so don't interfere
          if (!isScreenActive) {
            // Screen is not active - return normal UI if we have products, otherwise loading
            if (state is AllProductsLoaded || state is SpecificProducts || state is initialState) {
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
            }
            // Don't show anything when screen is not active - let other screens render
            return SizedBox.shrink();
          }
          
          // Screen is active - handle state normally
          // If state is ProductLoaded or ErrorState from product details, reload products
          if (state is ProductLoaded || (state is ErrorState && state.errorMSG.contains("Product"))) {
            // Reload products when coming back from product details
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && isScreenActive) {
                context.read<ProductBLoC>().add(LoadAllProducts());
              }
            });
            return Center(child: CircularProgressIndicator());
          }
          
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
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    final user = _auth.currentUser;

    return Drawer(
      backgroundColor: ColorManager.whiteLight,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: FutureBuilder<DocumentSnapshot>(
                future: user != null
                    ? _firestore.collection('users').doc(user.uid).get()
                    : null,
                builder: (context, snapshot) {
                  String userName = S.of(context).nameOfUser;
                  String userEmail = S.of(context).hisEmail;

                  if (user != null) {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      final data = snapshot.data!.data() as Map<String, dynamic>?;
                      userName = data?['name'] as String? ?? user.displayName ?? S.of(context).user;
                      userEmail = data?['email'] as String? ?? user.email ?? S.of(context).noEmail;
                    } else if (user.displayName != null || user.email != null) {
                      userName = user.displayName ?? S.of(context).user;
                      userEmail = user.email ?? S.of(context).noEmail;
                    }
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30.r,
                      backgroundImage: NetworkImage(
                          "https://wallpapers.com/images/hd/generic-male-avatar-icon-piiktqtfffyzulft.jpg"),
                    ),
                    title: Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.primaryLight,
                      ),
                    ),
                    subtitle: Text(
                      userEmail,
                      style: TextStyle(
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.primaryLight,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          _buildDrawerItem(Icons.add_shopping_cart_rounded, S.of(context).shopTogether,
              () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const ShopTogetherScreen()));
          }),
          _buildDrawerItem(Icons.search, S.of(context).discover, () {}),
          _buildDrawerItem(Icons.shopping_bag, S.of(context).myOrdersTitle, () {
            Navigator.pushNamed(context, Routes.myOrdersScreen);
          }),
          _buildDrawerItem(Icons.person, S.of(context).myProfile, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyProfile()));
          }),
          Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: ListTile(
                title: Text(S.of(context).other, style: TextStyle(fontSize: FontSize.s18))),
          ),
          _buildDrawerItem(Icons.settings, S.of(context).settings, () {}),
          _buildDrawerItem(Icons.mail_outline_sharp, S.of(context).support, () {}),
          _buildDrawerItem(Icons.info_outline, S.of(context).aboutUs, () {}),
          SizedBox(height: 10.h),
          _buildLanguageSwitch(),
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

  Widget _buildLanguageSwitch() {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: true);
    final isEnglish = languageProvider.isEnglish;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p4),
            child: Text(
              S.of(context).language,
              style: TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeightManager.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
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
                      onTap: () async {
                        await languageProvider.setLocale(const Locale('en'));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: isEnglish
                              ? ColorManager.whiteLight
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.language,
                                size: AppSize.s26, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              S.of(context).english,
                              style: TextStyle(
                                fontWeight: isEnglish
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
                      onTap: () async {
                        await languageProvider.setLocale(const Locale('ar'));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: !isEnglish
                              ? ColorManager.whiteLight
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.language,
                                size: AppSize.s26, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              S.of(context).arabic,
                              style: TextStyle(
                                fontWeight: !isEnglish
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
        ],
      ),
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
                          S.of(context).light,
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
                          S.of(context).dark,
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
