import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_hops/Provider/MyProvider.dart';
import 'package:secure_hops/Screens/Home%20Page/Empty%20Home/EmptyHome.dart';
import 'package:secure_hops/Widgets/button.dart';
import 'package:secure_hops/Widgets/navigator.dart';
import '../../Components/constants.dart';
import 'Content_OnBoarding.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    isFirstTime();
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          pageViewWidget(size),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          continueButton(),
        ],
      ),
    );
  }

  pageViewWidget(Size size) {
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        itemCount: contents.length,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 220),
                  child: TextButton(
                    onPressed: () {
                      push(context, AppHomePage());
                    },
                    child: Text(
                      currentIndex == contents.length - 1 ? "" : "Skip>",
                      style: TextStyle(color: btncolor),
                    ),
                  ),
                ),
                Image.asset(
                  contents[i].image,
                  height: size.height / 3.3,
                  width: 250,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  contents[i].title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  contents[i].discription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  continueButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, top: 30),
      child: MyButton(
          text: currentIndex == contents.length - 1 ? "Continue" : "Next",
          onPressed: () {
            if (currentIndex == contents.length - 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AppHomePage(),
                ),
              );
            }
            _controller.nextPage(
              duration: Duration(milliseconds: 100),
              curve: Curves.bounceIn,
            );
          }),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: btncolor,
      ),
    );
  }

  isFirstTime() {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    provider.saveFirstTime();
  }
}
