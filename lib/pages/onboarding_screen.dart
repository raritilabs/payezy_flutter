import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:payezy/pages/home_page.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: mainBackgroundColor,
      body: Column(
        children: [
          SizedBox(   //initial gap 
            height: 20.h,
          ),
          Expanded(
            child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: contents.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w,),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            contents[i].title,
                            style: GoogleFonts.michroma(
                              color: white,
                              fontWeight: FontWeight.w400,
                              fontSize: 19.sp,
                              fontStyle: FontStyle.normal,
                              height: 1.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child:LottieBuilder.asset(contents[i].animation), 
                        ),
                        
                        SizedBox(
                          height: 5.h,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(contents[i].description,
                              style: GoogleFonts.metrophobic(
                                wordSpacing: 0,
                                letterSpacing: 0,
                                  color: lightBlueThemeColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                              textAlign: TextAlign.center),
                        ),
                        
                      ],
                    ),
                  );
                }),
          ),
          //page indicator
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotColor: grey,
              expansionFactor: 2,
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: lightBlueThemeColor,
            ),
          ),
          
SizedBox(height: 3.h,),
          GestureDetector(
            onTap: () {
              if (currentIndex == contents.length - 1) {

                {
                  Navigator.of(context).push(_createRoute(const HomePage()));
                }
              }

              _controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            
            child: Padding(
              padding:  EdgeInsets.only(top: 2.h),
              child: Container(
                width: 40.w,
                height: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: mainBackgroundColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      contents[currentIndex].btnName,
                      style: GoogleFonts.roboto(color: white),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.h),
                      child: Image.asset('assets/nextIcon.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
           SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }

  Route<Object?> _createRoute(Widget route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class IntroPageContent {
  String title;
  String description;
  String btnName;
  String animation;

  IntroPageContent(
      {required this.title, required this.description, required this.btnName,required this.animation});
}

List<IntroPageContent> contents = [
  IntroPageContent(
    title: 'Borderless Payments Feeless Transactions',
    description:
        'With ZERO Fees, Payezy is the cheapest money transfer platform in USA',
    btnName: 'Next',
    animation:'assets/animation_1.json'
  ),
  IntroPageContent(
    title: 'Getting money to where it matters',
    description:
        'Send payments instantly from USA to your friends and family back in India',
    btnName: 'Next',
    animation: 'assets/animation_2.json'
  ),
  IntroPageContent(
    title: 'Safe & Secure Transactions',
    description:
        'Your financial data is encrypted and stored securely, ensuring that your money is in safe hands',
    btnName: 'Get Started',
    animation: 'assets/animation_3.json'
  ),
];
