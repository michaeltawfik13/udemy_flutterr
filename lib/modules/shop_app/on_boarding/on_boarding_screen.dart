import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutterr/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutterr/shared/components/components.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

import '../../../shared/network/local/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding.jpg',
        title: 'Boarding 1',
        body: 'Body 1'),
    BoardingModel(
        image: 'assets/images/onboarding.jpg',
        title: 'Boarding 2',
        body: 'Body 2'),
    BoardingModel(
        image: 'assets/images/onboarding.jpg',
        title: 'Boarding 3',
        body: 'Body 3')
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
        key: 'onBoarding', value: true).then((value) {
      if (value!) {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: submit, child: Text('SKIP')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    onBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print('Last Page');
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('Not Last');
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image.asset(
            '${model.image}',
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 15),
          ),
        ],
      );
}
