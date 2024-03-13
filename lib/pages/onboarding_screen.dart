import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/pages/get_started.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
    int currentIndex=0;
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
      backgroundColor: mainBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: 7.h,),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index){
                setState(() {
                  currentIndex = index;
                });
              },
                itemCount: contents.length,
                itemBuilder: (_, i) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.w ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: double.infinity,
                         
                          child: Text(
                            contents[i].title,
                            style: GoogleFonts.michroma(
                                color: white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                         SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 3.h),
                          child: Text(contents[i].description,
                              style: GoogleFonts.metrophobic(
                                  color: lightBlueThemeColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp),
                              textAlign: TextAlign.center),
                        ),
                        

                        
                      ],
                      
                    ),
                  );
                }),
          ),
            SmoothPageIndicator(controller: _controller, count: 3,effect: const ExpandingDotsEffect(
              dotColor: grey,
              expansionFactor: 3,
               dotHeight: 10,
               dotWidth: 10,
               activeDotColor: lightBlueThemeColor,
               
              
             ),), 
          
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(currentIndex == contents.length -1){
                  // Navigator.push(context,MaterialPageRoute(
                    
                  //   builder: (_)=> const GetStarted())
                  //   );
                  {
            Navigator.of(context).push(_createRoute(const GetStarted()));
          };
              }
              
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeIn,
                  );
              
            },
            child: Container(
             
              decoration: BoxDecoration(
               
                borderRadius: BorderRadius.circular(5),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contents[currentIndex].btnName,style: GoogleFonts.roboto(color: white),textAlign: TextAlign.center,),
               Padding(
                 padding:  EdgeInsets.only(left: 1.h),
                 child: Image.asset('assets/nextIcon.png'),
               ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
  
  Route<Object?> _createRoute(Widget route) {
    return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>route,
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

  IntroPageContent({required this.title, required this.description,required this.btnName});
}

List<IntroPageContent> contents = [
   IntroPageContent(
      title: 'Borderless Payments Feeless Transactions',
      description: 'With ZERO Fees, Payezy is the cheapest money transfer platform in USA',
       btnName:'Next',),
  IntroPageContent(
      title: 'Getting money to where it matters',
      description: 'Send payments instantly from USA to your friends and family back in India',
       btnName:'Next',),
     
  IntroPageContent(
      title: 'Safe & Secure Transactions',
      description: 'Your financial data is encrypted and stored securely, ensuring that your money is in safe hands',
       btnName:'Get Started',),
];
