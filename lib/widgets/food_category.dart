import 'package:flutter/material.dart';
import 'app_config.dart';
import 'app_text_styles.dart';
import 'star_display.dart';

class FoodCategory extends StatefulWidget {
  final String? id;
  final String? name;
  final String? category;
  final String? imagePath;
  final double? price;
  final double? discount;
  final double? ratings;

  @override
  _FoodCategoryState createState() => _FoodCategoryState();

  FoodCategory(
      {this.id,
      this.name,
      this.category,
      this.imagePath,
      this.discount,
      this.price,
      this.ratings});
}

class _FoodCategoryState extends State<FoodCategory> {
  late AppConfig appC;
  @override
  Widget build(BuildContext context) {
    appC = AppConfig(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: [
          Container(
            height: appC.rH(26),
            width: appC.rW(92),
            child: Image.asset(
              widget.imagePath!,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 60.0,
              width: 340.0,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black12,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name!,
                      style: AppTextStyles.boldWhiteTextStyle,
                    ),
                    IconTheme(
                      data: IconThemeData(
                        size: 20,
                      ),
                      child: StarDisplay(value: 4),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "${widget.price}",
                      style: AppTextStyles.boldWhiteTextStyle,
                    ),
                    const Text(
                      "Min Order",
                      style: AppTextStyles.mediumWhiteTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}