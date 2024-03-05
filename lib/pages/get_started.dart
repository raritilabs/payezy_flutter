import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late final TextEditingController _email;
  late final TextEditingController _password;

   @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
_email.dispose();
_password.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final emailProvider=Provider.of<GetStartedProvider>(context);
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: getStarted, isVisible: false),
      body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(
                  height: 1.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: spaceBetween(metrophobicText(loginorsignup,size: 15.sp))),
                spaceBetween(
                  customTextField(email,'',_email,
                  (value)=>emailProvider.setEmail(value),false,TextInputType.emailAddress),            
                ),
                spaceBetween(CustomButton(
                  onPressed: () { 
                   
                   Navigator.pushNamed(context, '/signup'); 
                                       },
                  text: continu,
                  size: 18.sp,
                  color: white,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child:Center(
                    child: metrophobicText(or, size: 20.sp),
                  ),
                ),
                spaceBetween(
                  Center(
                    child: metrophobicText(

                        loginquickly,
                        size: 15.sp,
                        textAlign: TextAlign.justify),
                  ),
                ),
                spaceBetween(
                  CustomButton(
                    onPressed: () {
            
                    },
                    text: google,
                    leftAssetValue: 'assets/googleIcon.png',
                  ),
                ),
                spaceBetween(
                  CustomButton(
                      onPressed: () {},
                      text: meta,
                      leftAssetValue: 'assets/metaIcon.png'),
                ),
                spaceBetween(
                  CustomButton(
                    onPressed: () {},
                    text: signinwith,
                    rightAssetValue: 'assets/XIcon.png',
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 2.h),
                  child: metrophobicText('By signing up you confirm that you have read, accepted and agreed to Terms of Use and Privacy Policy.',
                  size: 12.sp),
                )
               
              ],
            ),
          ),
        ));
        }
  }


Widget spaceBetween(child) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical:1.h ),
    child: child,
  );
}
