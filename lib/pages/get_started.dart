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

  @override
  void initState() {
    _email = TextEditingController(); //controls the email text field
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();  //disposes the email controller
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<GetStartedProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents the bottom from coming up with the keyboard
        backgroundColor: mainBackgroundColor,  
        appBar: const CustomAppBar(title: getStarted, isVisible: false),  
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),  //side padding 5.w
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: spaceBetween(
                        metrophobicText(loginorsignup, size: 15.sp))),
                spaceBetween(
                  customTextField(email,'',
                     readOnly: false,
                      controller: _email,
                      onChanged: (value) => emailProvider.setEmail(value),
                      obscure: false,
                      textInputType: TextInputType.emailAddress),
                ),
                SizedBox(height: 2.h,),
                spaceBetween(CustomButton(
                  onPressed: () async{
                  //  emailProvider.setEmail(_email.text);
                    Navigator.pushNamed(context, '/signup');
                  },
                  text: 'Continue',
                  size: 18.sp,
                  color: white,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Center(
                    child: metrophobicText(or, size: 20.sp),
                  ),
                ),
                spaceBetween(
                  Center(
                    child: metrophobicText(loginquickly,
                        size: 15.sp, textAlign: TextAlign.justify),
                  ),
                ),
                spaceBetween(
                  CustomButton(
                    onPressed: () {},
                    text: google,
                    size: 16.sp,
                    leftAssetValue: 'assets/googleIcon.png',
                  ),
                ),
                spaceBetween(
                  CustomButton(
                      onPressed: () {},
                      text: meta,
                      size: 16.sp,
                      leftAssetValue: 'assets/metaIcon.png'),
                ),
                spaceBetween(
                  CustomButton(
                    onPressed: () {},
                    text: signinwith,
                    rightAssetValue: 'assets/XIcon.png',
                    size: 16.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: metrophobicText(
                     bySigning,
                     textAlign: TextAlign.justify,
                      size: 10.sp),
                )
              ],
            ),
          ),
        ));
  }
}

Widget spaceBetween(child) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: child,
  );
}
