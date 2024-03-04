import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';

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
      appBar: const CustomAppBar(title: getStarted, value: false),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: spaceBetween(alertText(loginorsignup, white, 18))),
                spaceBetween(
                  customTextField(email,'',_email,
                  (value)=>emailProvider.setEmail(value),false,TextInputType.emailAddress),            
                ),
                spaceBetween(CustomButton(
                  onPressed: () { 
                   
                   Navigator.pushNamed(context, '/signup'); 
                    
                  
                    
                   },
                  text: continu,
                  size: 20,
                  color: white,
                )),
                spaceBetween(
                  Center(
                    child: alertText(or, white, 20),
                  ),
                ),
                spaceBetween(
                  Center(
                    child: alertText(
                        loginquickly,
                        white,
                        15),
                  ),
                ),
                spaceBetween(
                  CustomButton(
                    onPressed: () {
            
                    },
                    text: google,
                    size: 20,
                    color: white,
                    leftAssetValue: 'assets/googleIcon.png',
                  ),
                ),
                spaceBetween(
                  CustomButton(
                      onPressed: () {},
                      text: meta,
                      size: 20,
                      color: white,
                      leftAssetValue: 'assets/metaIcon.png'),
                ),
                spaceBetween(
                  CustomButton(
                    onPressed: () {},
                    text: signinwith,
                    size: 20,
                    color: white,
                    rightAssetValue: 'assets/XIcon.png',
                  ),
                ),
              ],
            ),
          ),
        ));
        }
  }


Widget spaceBetween(child) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: child,
  );
}
