import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor_app/Pages/otp_verification.dart';
import 'package:vendor_app/Services/forgot_pass_services.dart';

class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {

  String email='';
  bool isApiCallProcess=false;
  TextEditingController ob1=new TextEditingController();
  String invalid_email="";
  void otp_email()async{
    invalid_email="";
    final response=await ResetPasswordApiService().otpLogin(ob1.text);
    if(response.data!=null)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationPage(
          otpHash: response.data,
          email: ob1.text)));
    }
    if(response.message=="Email not registered")
    {
      print("email not registered");
      setState(() {
        invalid_email="Given Email Id is not registered";
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      icon: Icon(Icons.arrow_back_ios,color: Color(0xFF004225),size: 25,),)
                  ],
                ),
                SvgPicture.asset(height: 300,'assets/fp1.svg'),
                SizedBox(height: 20,),
                Text("Forgot Password ?",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    color: Color(0xFF004225)
                  ),),
                SizedBox(height: 10,),
                Text("Please enter your email address to recievce a verification code",
                  style: TextStyle(color: Colors.grey.shade800),),
                SizedBox(height: 20,),
                //Text("Email Address",style: TextStyle(color: Color(0xFF004225)),),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: ob1,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe1ead8),
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        //hintText: 'Email id',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 1,
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(onPressed:otp_email,
                    child: Text("Continue",style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004225),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )

                    ),),
                ),
                SizedBox(height: 20,),
                Text("$invalid_email",style: TextStyle(color: Colors.red),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
