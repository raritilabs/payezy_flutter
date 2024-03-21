// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/app_bar.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/firebase_options.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late final TextEditingController _password;
  late final TextEditingController _email;

  @override
  void initState() {
    _password = TextEditingController();
    _email=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: 'Login'),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 13.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //email field
                      customTextField(email,'',
                          controller: _email,
                          readOnly: true,
                         //  onChanged: (value) => emailProvider.(value),
                          textInputType: TextInputType.emailAddress),
                      SizedBox(
                        height: 1.h,
                      ),
                      customTextField(password,'',
                          controller: _password,
                         //   onChanged: (value) => emailProvider.setPassword(value),
                          readOnly: false, //readonly value
                          textInputType: TextInputType.text,
                          obscure: true),
                  
                     
                      SizedBox(
                        height: 8.h,
                      ),
                  
                      CustomButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try{
                          final userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                            print(userCredential);

                           
                          } on FirebaseAuthException catch (e){
                            
                           print('AuthException occured:${e.code}');


                            
                          
                          }
                           
                     
                      Navigator.pushNamed(context, '/mainscreen');
                        },
                        text: login,
                        size: 18.sp,
                      ),
                  TextButton(onPressed: (){
                  //   FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/mainscreen');}
                  , child: metrophobicText('Login'))
                     
                    ],
                  ),
                );
              default:
                return const LinearProgressIndicator();
            }
          }),
    );
  }
}
