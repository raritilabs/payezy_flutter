import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/providers/enter_details.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';

class EnterDetails extends StatefulWidget {
  const EnterDetails({super.key});

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {

final TextEditingController _fName=TextEditingController();
final TextEditingController _phone=TextEditingController();
final TextEditingController _bAccountNumber=TextEditingController();
final TextEditingController _iFSC=TextEditingController();

addData(String fname,int phone, int bankaccnum,num ifsc) async
{
  if(fname=="" && phone==0 && bankaccnum == 0 && ifsc==0){
    print('Enter Required Fields');
  }
  else{
    FirebaseFirestore.instance.collection('Users').doc(fname).set({
      "First Name":fname,
      "Phone":phone,
      "Bank Acc. Number" :bankaccnum,
      "IFSC Code":ifsc,
    }).then((value) => print('inserted'));
  }
}

  @override
  Widget build(BuildContext context) {
    final enterDetailsProvider = Provider.of<EnterDetailsProvider>(context,);

    return Column(
      children: [
        ///Enter the details...
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: titleText(enterthedetails),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
    
        details(fullname,controller: _fName,onChanged: (value)=>enterDetailsProvider.setfName(value)),
        details(phone,controller: _phone,onChanged: (value)=>enterDetailsProvider.setPhone(int.parse(value))),
        details(bankaccnum,controller:_bAccountNumber,onChanged: (value)=>enterDetailsProvider.setBankAccNum(int.parse(value))),
        details(confirmacc),
        details(ifsc,controller: _iFSC,onChanged: (value)=>enterDetailsProvider.setiFSC(int.parse(value))),
    
        Padding(
          padding:
              const EdgeInsets.only(bottom: 10, top: 15, left: 15, right: 15),
          child: CustomButton(onPressed:() {
            showDialog(
                barrierColor: blurColor,
                context: context,
                builder: (BuildContext context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: AlertDialog(
                        backgroundColor: mainBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: metrophobicText(
                          areyousure,
                          size: 25,
                        ),
                        content: metrophobicText(note,color:  lightBlueThemeColor, size: 12),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(onPressed: () {
    addData(
      enterDetailsProvider.fname,
      enterDetailsProvider.phone,
      enterDetailsProvider.bAccountNumber,
      enterDetailsProvider.iFSC,
    );
         Navigator.pushNamed(context, '/cybrid');
                                }, text:confirm,size: 15,color:
                                    lightBlueThemeColor),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: CustomButton(onPressed: () {
                                  Navigator.pop(context);
                                }, text:cancel, size:15, color:cancelButton,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ));
          }, text:proceed, size:22, color:white,rightAssetValue: "assets/nextIcon.png",),
        ),
      ],
    );
  }
}

Widget details(String title, {TextEditingController? controller,dynamic onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: customTextField(title,controller: controller,onChanged: onChanged),
  );
}
