// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/providers/get_started_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 // late final TextEditingController _password;
   final TextEditingController _password = TextEditingController();

  // @override
  // void initState() {
  //   _password = TextEditingController();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _password.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<GetStartedProvider>(
      context,
    );

    return Scaffold(
            resizeToAvoidBottomInset: false,
            
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: 'Sign Up'),
      body:
       FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return 
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 13.h),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //email field
                        customTextField(email,'',
                      
                            label: emailProvider.email,
                            readOnly: true,
                            textInputType: TextInputType.emailAddress,
                         
                            ),

                            
                        SizedBox(
                          height: 3.h,
                        ),
                        customTextField(password,
                        '',
                            controller: _password,
                              onChanged: (value) { 
                                emailProvider.setPassword(value);
                              
                              },
                            readOnly: false, //readonly value
                            textInputType: TextInputType.text,
                            obscure: true),

                        SizedBox(
                          height: 3.h,
                        ),
                        customTextField('Confirm Password','',

                            // controller:  _password,

                            readOnly: false, //readonly value
                            textInputType: TextInputType.text,
                            obscure: true),

                        SizedBox(
                          height: 8.h,
                        ),

                        CustomButton(
                          onPressed: () async {
                            //final email = emailProvider.email;
                            //final password = _password.text;
                         
                            // try{
                            //   //final userCredential = 
                            //   await FirebaseAuth.instance
                            //     .createUserWithEmailAndPassword(
                            //   email: email,
                            //   password: password,
                            // );
                            // // print("value is $userCredential");
                            // }
                         //   catch (e){
                           //   print('error:$e');
                         //   }
                            
                           
                          },
                          text: signup,
                          size: 18.sp,
                        ),
SizedBox(height: 2.h,),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: metrophobicText('Already Registered? Login here',color: lightBlueThemeColor),
                        ),
                      ],
                    ),
                  ),
                
     ) ;
              default:
               return const LinearProgressIndicator();
            }
          }
          ),
    )
    ;
  }
}
