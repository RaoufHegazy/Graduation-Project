import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:v46/shared/components/components.dart';
import 'package:v46/shared/network/local/cache_helper.dart';

import '../fee_login/fee_login_screen.dart';

class fee_on_boarding_model {
  final String image;
  final String text1;

  fee_on_boarding_model(
    this.image,
    this.text1,
  );
}

List<fee_on_boarding_model> boarding_list = [
  fee_on_boarding_model(
      'assets/images/fee2.jpeg', 'كلية الهندسة الالكترونية بمنوف ترحب بكم'),
  fee_on_boarding_model('assets/images/fee1.jpeg',
      ' هذا التطبيق خاص بالكلية والطلبة وهيئة اعضاء التدريس'),
  fee_on_boarding_model(
      'assets/images/fee3.jpeg', 'يمكنك تسجيل الدخول من خلال الصفحة القادمة'),
];

bool is_last = false;

class fee_on_boarding_screen extends StatefulWidget {
  @override
  State<fee_on_boarding_screen> createState() => fee_on_boarding_screenState();
}

class fee_on_boarding_screenState extends State<fee_on_boarding_screen> {
  var boarding_controller = PageController();

  void on_submit() {
    cache_helper.save_data(key: 'on_boarding', value: true).then((value) {
      if (value) {
        navigate_and_finish(context, fee_login_screen());
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: default_text_button(
                function: on_submit,
                text: 'Skip',
                fontweight: FontWeight.bold,
                font: 25),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    build_boarding_item(boarding_list[index]),
                physics: BouncingScrollPhysics(),
                controller: boarding_controller,
                itemCount: boarding_list.length,
                onPageChanged: (int index) {
                  if (index == boarding_list.length - 1) {
                    setState(() {
                      is_last = true;
                    });
                  } else {
                    setState(() {
                      is_last = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boarding_controller,
                  count: boarding_list.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.lightBlue,
                    expansionFactor: 1.5,
                    dotWidth: 16,
                    dotColor: Colors.grey,
                    dotHeight: 16,
                    spacing: 8,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  child: TextButton(
                      onPressed: () {
                        boarding_controller.previousPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: 6,
                ),
                CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  child: TextButton(
                      onPressed: () {
                        if (is_last) {
                          on_submit();
                        } else {
                          boarding_controller.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget build_boarding_item(fee_on_boarding_model m) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage('${m.image}'),
              height: 300,
              width: 350,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlueAccent,
            ),
            child: Text(
              '${m.text1}',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
