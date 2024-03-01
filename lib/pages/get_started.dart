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

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late final TextEditingController _email;
    late final TextEditingController _password;

  @override

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
    
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const CustomAppBar(title: getStarted, value: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: spaceBetween(alertText('Login/Sign up', white, 18))),
            spaceBetween(
              customTextField('Email','',_email),
            ),
            spaceBetween(CustomButton(
              onPressed: () { //async
              //await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
                Navigator.pushNamed(context, '/homepage');
              //  final email=_email.text;
              //final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              //email:email,
              //password:password,)

                },
              text: 'Continue',
              size: 20,
              color: white,
            )),
            spaceBetween(
              Center(
                child: alertText('Or', white, 20),
              ),
            ),
            spaceBetween(
              Center(
                child: alertText(
                    'Log in quickly using one of your social accounts',
                    white,
                    15),
              ),
            ),
            spaceBetween(
              CustomButton(
                onPressed: () {

                },
                text: 'Google',
                size: 20,
                color: white,
                leftAssetValue: 'assets/googleIcon.png',
              ),
            ),
            spaceBetween(
              CustomButton(
                  onPressed: () {},
                  text: 'Meta',
                  size: 20,
                  color: white,
                  leftAssetValue: 'assets/metaIcon.png'),
            ),
            spaceBetween(
              CustomButton(
                onPressed: () {},
                text: 'Sign in with',
                size: 20,
                color: white,
                rightAssetValue: 'assets/XIcon.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget spaceBetween(child) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: child,
  );
}
