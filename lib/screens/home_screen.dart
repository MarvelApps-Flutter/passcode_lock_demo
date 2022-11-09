import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:passcode_lock_demo/constants/app_constants.dart';
import '../models/food_data.dart';
import '../models/food_model.dart';
import '../widgets/app_text_styles.dart';
import '../widgets/food_category.dart';
import 'lock_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgList = [
    AppConstants.image1,
    AppConstants.image2,
    AppConstants.image3,
    AppConstants.image4,
  ];
  int pageIndex = 0;
  List<Widget> imageSliders = [];
  final List<FoodData> _foods = foods;
  bool? isLinkedInLoggedIn;
  bool? isFacebookLoggedIn;
  void initSlider() {
    imageSliders = imgList
        .map((item) => Container(
          color: Colors.white,
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 400.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              )),
        ))
        .toList();
  }

  @override
  void initState() {
    initSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height:10),
          CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders),
          const SizedBox(height:10),
          const SizedBox(height:8),
          foodCategoryHeading(),
          const SizedBox(height:20),
          Column(
            children: _foods.map(buildFoodCategory).toList(),
          )
        ],
      )),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: const Center(
        child: Text(
          AppConstants.home,
          style: AppTextStyles.mediumBlackTextStyle,
        ),
      ),
      leading: IconButton(
        padding: const EdgeInsets.only(left: 10),
        onPressed: () {},
        icon: const Icon(Icons.menu),
        iconSize: 24,
        color: Colors.black,
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 15),
          onPressed: () {},
          icon: const Icon(Icons.search),
          iconSize: 24,
          color: Colors.black,
        ),
        IconButton(
          padding: const EdgeInsets.only(right: 15),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => const LockScreen()), (Route<dynamic> route) => false
                //context, MaterialPageRoute(builder: (context) => const LockScreen())
                );
          },
          icon: const Icon(Icons.logout),
          iconSize: 24,
          color: Colors.black,
        )
      ],
    );
  }

  Widget foodCategoryHeading() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              AppConstants.foodCat,
              style: AppTextStyles.boldTextStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text(
             AppConstants.viewAll,
              style: AppTextStyles.mediumTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Container buildBottomNavBar(BuildContext context) {
    return Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Color(0xFF0165ff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home_filled,
                color: Colors.white,
                size: 25,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 25,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 25,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 25,
              )),
        ],
      ),
    );
  }

  Widget buildFoodCategory(FoodData food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: FoodCategory(
          imagePath: food.imagePath,
          id: food.id,
          name: food.name,
          price: food.price),
    );
  }
}