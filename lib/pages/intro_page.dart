import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payezy/pages/home_page.dart';
import 'package:payezy/themes/colors.dart';

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
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          contents[i].title,
                          style: GoogleFonts.roboto(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(contents[i].description,
                            style: GoogleFonts.roboto(
                                color: white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            textAlign: TextAlign.center),
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
                  Navigator.push(context,MaterialPageRoute(builder: (_)=> const HomePage()));
              }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100), 
                  curve: Curves.bounceIn,
                  );
              
            },
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: white,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child:  Text('Next',style: GoogleFonts.roboto(color: white),textAlign: TextAlign.center,),
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
              color: white
            ),
          );
  }
}

class IntroPageContent {
  String title;
  String description;

  IntroPageContent({required this.title, required this.description});
}

List<IntroPageContent> contents = [
  IntroPageContent(
      title: 'Get money to where it matters',
      description: 'Instant payments to your friends and family back home'),
  IntroPageContent(
      title: 'Get money to where it matters',
      description: 'Instant payments to your friends and family back home'),
  IntroPageContent(
      title: 'Get money to where it matters',
      description: 'Instant payments to your friends and family back home'),
];
