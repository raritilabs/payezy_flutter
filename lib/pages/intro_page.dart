import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/pages/get_started.dart';
import 'package:payezy/themes/colors.dart';
import 'package:sizer/sizer.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(contents.length, (index) => buildDot(index,context))),
          const SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(currentIndex == contents.length -1){
                  Navigator.push(context,MaterialPageRoute(builder: (_)=> const GetStarted()));
              }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100), 
                  curve: Curves.bounceIn,
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

  Container buildDot(int index, BuildContext context) {
    return Container(
            height: 10,
            width: currentIndex == index? 20:10,
            padding: const EdgeInsets.only(right: 10,left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: lightBlueThemeColor,
            ),
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
