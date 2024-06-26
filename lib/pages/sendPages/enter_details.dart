import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payezy/components/custom_button.dart';
import 'package:payezy/components/custom_container.dart';
import 'package:payezy/components/text_field.dart';
import 'package:payezy/functions/add_transaction_details.dart';
import 'package:payezy/functions/format_epoch_time.dart';
import 'package:payezy/providers/ifsc_validator.dart';
import 'package:payezy/providers/enter_details_provider.dart';
import 'package:payezy/providers/send_provider.dart';
import 'package:payezy/themes/colors.dart';
import 'package:payezy/themes/fonts.dart';
import 'package:payezy/functions/add_data.dart';
import 'package:payezy/themes/string_constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnterDetails extends StatefulWidget {
  const EnterDetails({super.key});

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {


  //initialising texteditingcontrollers to save the textfield values
  final TextEditingController _nickName = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _bAccountNumber = TextEditingController();
  final TextEditingController _iFSC = TextEditingController();
  final TextEditingController _confirmAccount = TextEditingController();


@override
  void dispose() {
    _nickName.dispose();
    _fName.dispose();
    _phone.dispose();
    _email.dispose();
    _bAccountNumber.dispose();
    _iFSC.dispose();
    _confirmAccount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String selectedNickname = '';
    

    //provider for state management
    final enterDetailsProvider = Provider.of<EnterDetailsProvider>(
      context,listen: true
    );

    final sendPageProvider =
        Provider.of<SendPageProvider>(context, listen: true);

    final ifscApiProvider=Provider.of<ApiProvider>(context,listen: true);
    int epochTime = DateTime.now().millisecondsSinceEpoch; //calculating epochtime
    return FutureBuilder(
      future: _fetchAccountDetails(),
      builder: (context,snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator(color: lightBlueThemeColor,);      
        return SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              ///Enter the details...
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 4.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: metrophobicText(enterthedetails, size: 12.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              //nickname selector
Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),  
    child: Container(
         width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: Colors.transparent,
          border: Border.all(color: lightBlueThemeColor)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0.5.w,
        ),
        //expansion title 
        child: ExpansionTile(title:metrophobicText('Select a nick name',size: 14.sp,textAlign: TextAlign.left,color: lightBlueThemeColor),
        collapsedIconColor: lightBlueThemeColor,
        iconColor: lightBlueThemeColor,
        initiallyExpanded: enterDetailsProvider.expansionTileExpanded,
        onExpansionChanged: (bool expanded){
          enterDetailsProvider.setExpansionTileExpanded(expanded);
        },
        ),
        ),),
),
//expansion body
          //textfields
              Visibility(
                visible:enterDetailsProvider.expansionTileExpanded,
                child: GestureDetector(
                  onTap: (){
                  enterDetailsProvider.setDetails(true);
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: CustomContainer(
                      color1: expansiontilegradientone,
                      color2: expansiontilegradienttwo,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(vertical: 2.h,
                        horizontal: 4.w),
                        child: SizedBox(
                          height: 3.h,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                                selectedNickname = snapshot.data!.docs[index]['nickName'];
                                return GestureDetector(
                              child: metrophobicText(selectedNickname,
                              size: 14.sp,color: greyFontThemeColor),
                               onTap: () {
                                enterDetailsProvider.setIndex(index);
                               }
              
                            );}
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),        
              textfieldWithPadding(nickname,
              label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['nickName']):
              '',
                  controller: _nickName,
                  textInputType: TextInputType.name,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z\\s]'))],//regexp to only allow letters
                  onChanged: (value) {
                   
                    if(enterDetailsProvider.nickNameAvailable){
                      enterDetailsProvider.setnickName(snapshot.data!.docs[enterDetailsProvider.index]['nickName']); 
                    }
                  enterDetailsProvider.setnickName(value);
                  } ), //saving the name to provider
              textfieldWithPadding(fullname,
              label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['fullName']):
              '',
                  controller: _fName,
                  textInputType: TextInputType.name,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z\\s]'))],
                  onChanged: (value) => enterDetailsProvider.setfName(value)), 
              textfieldWithPadding(phone, 
              label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['phoneNumber']):
              '',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputType:TextInputType.phone,
              controller: _phone, onChanged: (value) {
                if(enterDetailsProvider.nickNameAvailable){
               enterDetailsProvider.setPhone(snapshot.data!.docs[enterDetailsProvider.index]['phoneNumber']);
                }
                    enterDetailsProvider.setPhone(int.tryParse(value)??0);
                               }),
               textfieldWithPadding(email, 
               label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['email']):
              '', 
              textInputType:TextInputType.emailAddress,
              controller: _email, onChanged: (value) { 
                if(enterDetailsProvider.nickNameAvailable){
                 enterDetailsProvider.setEmail(snapshot.data!.docs[enterDetailsProvider.index]['email']); 
                }
              enterDetailsProvider.setEmail(value); 
              }),
              textfieldWithPadding(bankaccnum,
               label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['accountNumber']):
              '',
              textInputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
               controller: _bAccountNumber, onChanged: (value) {
                               enterDetailsProvider.setBankAccNum(int.tryParse(value)??0);
                       
              }),
              textfieldWithPadding(confirmacc, 
       label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['accountNumber'].toString()):
              '',
              obscure: true,
              textInputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _confirmAccount, onChanged: (value) {
                                enterDetailsProvider.setconfirmAcc(int.tryParse(value)??0);
        
              }),
              textfieldWithPadding(ifsc
              ,
               label: enterDetailsProvider.nickNameAvailable==true?(snapshot.data!.docs[enterDetailsProvider.index]['IFSCCode']):
              '',
                  controller: _iFSC,
                  inputFormatters: [UpperCaseTextFormatter()], //converting the typed letter to uppercase
                  onChanged: (value) async{
                    enterDetailsProvider.setVisibility(false);
                    try{
                   ifscApiProvider.setiFSC((value));
                   //fetching ifsc from url
                   var result= await ifscApiProvider.getDataFromAPI();
                  //if no connection
                   if(result=='404'){
                      enterDetailsProvider.setValidationMessage(ValidationMessage.iFSCVMError);
                    }
                    //set the value of ifsc and make the values visible
                    else{
                   enterDetailsProvider.setValidationMessage(ValidationMessage.iFSCVM);
                   enterDetailsProvider.setiFSC(value);
                   enterDetailsProvider.setIFSCDetails(result.branch,result.city,result.bank);
                   enterDetailsProvider.setVisibility(true);
                    }
                    }
                    catch(e){
                      log(e.toString());
                    }
                    
                  },
                  ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: SizedBox(
                  width: double.infinity,
                  child: switch (enterDetailsProvider.validationMessage) {
                    ValidationMessage.fnameVM => metrophobicText(
                       "Please enter a full name",
                           
                        color: Colors.red,
                        size: 11.sp),
                    ValidationMessage.bAccountNumberVM => metrophobicText(
                             "Please enter a valid account number",
                        color: Colors.red,
                        size: 11.sp),
                    ValidationMessage.confirmAccountVM => metrophobicText(
                       
                             "Please confirm the account number"
                            ,
                        color: Colors.red,
                        size: 11.sp),
                    ValidationMessage.iFSCVMError => metrophobicText(
                            "IFSC should be 4 letters, followed by 7 letters or digits"
                          ,
                        color: Colors.red,
                        size: 11.sp),
                    ValidationMessage.phoneVM => metrophobicText(
                             "Please enter a 10-digit phone number"
                          ,
                        color: Colors.red,
                        size: 11.sp),
                    ValidationMessage.initial => metrophobicText(''),
                      
                    ValidationMessage.iFSCVM => metrophobicText("Branch:${enterDetailsProvider.branch}\nCity:${enterDetailsProvider.city}\nBank:${enterDetailsProvider.bank}\n",textAlign: TextAlign.left),
                   
                    ValidationMessage.nicknameVM => metrophobicText(
                             "Please enter a Nick Name"
                          ,
                        color: Colors.red,
                        size: 11.sp),
                    
                    ValidationMessage.emailVM => metrophobicText(
                             "Please enter a valid email address"
                          ,
                        color: Colors.red,
                        size: 11.sp),
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 2.h, top: 1.h, left: 5.w, right: 5.w),
                child: CustomButton(
                  onPressed: ()  {
                     enterDetailsProvider.setValidationMessage(ValidationMessage.initial);

                     if(enterDetailsProvider.nickNameAvailable){
                  enterDetailsProvider.setnickName(snapshot.data!.docs[0]['nickName']);
                  enterDetailsProvider.setfName(snapshot.data!.docs[0]['fullName']);
               enterDetailsProvider.setPhone(int.tryParse(snapshot.data!.docs[0]['phoneNumber'])??0);
                  enterDetailsProvider.setEmail(snapshot.data!.docs[0]['email']);
                  enterDetailsProvider.setBankAccNum((int.tryParse(snapshot.data!.docs[0]['accountNumber'])??0));
                  enterDetailsProvider.setconfirmAcc((int.tryParse(snapshot.data!.docs[0]['accountNumber'])??0));
                     } 
                   //checking if nick name is not empty
                   if (enterDetailsProvider.nickName.isEmpty) {
                      enterDetailsProvider.setValidationMessage(ValidationMessage.nicknameVM);
                    } 
                    //checking if name is not empty
                    else if (enterDetailsProvider.fname.isEmpty) {
                      enterDetailsProvider.setValidationMessage(ValidationMessage.fnameVM);
                    }
                                    //checking if phone number has 10 digits
        
                     else if (enterDetailsProvider.phone.toString().length != 10) {
                enterDetailsProvider.setValidationMessage(ValidationMessage.phoneVM);
          
                    } 
                 //checking if email id is valid
        
                    //  else if (enterDetailsProvider.email.length>5) {
                    //   enterDetailsProvider.setValidationMessage(ValidationMessage.emailVM);
                    // }
                      else if (enterDetailsProvider.email.toString().contains('@') == false
                 ) {
                       enterDetailsProvider.setValidationMessage(ValidationMessage.emailVM);
                     }
                   
        
                    //checking if account number has 16 digits
                    else if(enterDetailsProvider.bAccountNumber.toString().length !=16) {
                      enterDetailsProvider.setValidationMessage(ValidationMessage.bAccountNumberVM);
                    }
                    //checking if account number = confirm account
                    else if (enterDetailsProvider.confirmAccount !=
                        enterDetailsProvider.bAccountNumber) {
          enterDetailsProvider.setValidationMessage(ValidationMessage.confirmAccountVM);
                    } 
                    else 
                    {
                      enterDetailsProvider.setVisibility(false);
                      //dialog box
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
                                    size: 15.sp,
                                  ),
                                  content: metrophobicText(note,
                                      color: lightBlueThemeColor, size: 10.sp,textAlign: TextAlign.justify),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //confirm button
                                        Expanded(
                                          child: CustomButton(
                                              onPressed: () {
                                                //add data to firestore database
                                            if(!enterDetailsProvider.nickNameAvailable){
                                              addData(
                                            
                                                  enterDetailsProvider.iFSC.toString(),
                                                 enterDetailsProvider.bAccountNumber.toString(),
                                                 enterDetailsProvider.email.toString(),
                                                  enterDetailsProvider.fname,
                                                  enterDetailsProvider.nickName,
                                                  enterDetailsProvider.phone.toString(),
                                                );
                                            }
                                              String formattedTime = DateUtilsFunction.formatEpochTime(epochTime);
                                               sendPageProvider.setCurrentTime(formattedTime); 
                                              String email=FirebaseAuth.instance.currentUser!.email.toString();
                                               addTransactionDetails(sendPageProvider.youSend.toString(), 
                                               sendPageProvider.youReceiveBank==00.00?sendPageProvider.youReceiveCard.toString():sendPageProvider.youReceiveBank.toString(), 
                                               formattedTime,email,enterDetailsProvider.iFSC.toString(), enterDetailsProvider.phone.toString(),
                                                enterDetailsProvider.bAccountNumber.toString(),);
                                                
                                                Navigator.pushNamed(
                                                    context, '/cybrid');
                                              },
                                              text: confirm,
                                              size: 15,
                                              color: lightBlueThemeColor),
                                        ),
                                        //space b/w
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        //cancel button
                                        Expanded(
                                          child: CustomButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            text: cancel,
                                            size: 15,
                                            color: cancelButton,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ));
                    }
                  },
                  text: proceed,
                  size: 17.sp,
                  color: white,
                  rightAssetValue: "assets/nextIcon.png",
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
//custom widget to add textfield

Widget textfieldWithPadding(String title,
    {TextEditingController? controller,String? label = '', bool?visible=false,bool? obscure = false, String? details='', TextInputType? textInputType, dynamic onChanged, List<TextInputFormatter>? inputFormatters
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
    child: customTextField(title,
        controller: controller, onChanged: onChanged,
        inputFormatters:inputFormatters,
        textInputType: textInputType,
        label: label,
        obscure: obscure,
        ),
  );
}
//to convert the given text to uppercase
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

Future<QuerySnapshot> _fetchAccountDetails() async {
  String? email = FirebaseAuth.instance.currentUser!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .where('email', isEqualTo: email)
      .get();
  final userId = querySnapshot.docs.first.id;
  final accountDetailsSnapshot = await FirebaseFirestore.instance
      .collection('userData')
      .doc(userId)
      .collection('accountDetails')
      .get();
  return accountDetailsSnapshot;
}
