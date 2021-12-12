import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:souq/models/on_boarding_model.dart';
import 'package:souq/modules/login/login_screen.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/network/local/cache_helper.dart';
import 'package:souq/shared/styles/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  // const OnBoardingScreen({Key? key}) : super(key: key);

  // const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/shopping1.png', title: 'Title 1', body: 'Body 1'),
    BoardingModel(
        image: 'assets/images/shopping2.png', title: 'Title 2', body: 'Body 2'),
    BoardingModel(
        image: 'assets/images/shopping3.png', title: 'Title 3', body: 'Body 3'),
  ];

  var boardController = PageController();
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Souq',
            // style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: JumpingDotEffect(
                        dotColor: Colors.grey.withOpacity(0.4),
                        activeDotColor: defaultColor,
                        spacing: 10),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {}
                      boardController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}
