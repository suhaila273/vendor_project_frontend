import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor_app/Pages/Reset_password.dart';
import 'package:vendor_app/Services/forgot_pass_services.dart';

class VerificationPage extends StatefulWidget {
  final String? email;
  final String? otpHash;
  const VerificationPage({super.key, this.email, this.otpHash});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  TextEditingController ob1=new TextEditingController();
  String invalid_otp="";
  void otp_verify()async{
    invalid_otp="";
    final response=await ResetPasswordApiService().verifyOtp(widget.email!, widget.otpHash!, ob1.text);
    if(response.data!=null)
    {
      Navigator.push(context, MaterialPageRoute(builder:(context)=>ResetPassword(
        email:widget.email,
      )));
    }
    else
    {
      print("Invalid otp");
      setState(() {
        invalid_otp="Invalid OTP";
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
                SvgPicture.asset(height: 300,'assets/otp.svg'),
                //SvgPicture.asset("assets/farm2.svg",height: 250,width: 250,alignment: Alignment.center,),
                SizedBox(height: 20,),
                Text("Verify OTP",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004225)
                  ),),
                SizedBox(height: 10,),
                Text("Please enter the verification code",
                  style: TextStyle(color: Colors.grey.shade800),),
                SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: ob1,
                    decoration: InputDecoration(
                      filled: true,
                        fillColor: Color(0xffe1ead8),
                        prefixIcon: Icon(Icons.password_outlined),
                        labelText: '',
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        hintText: 'verification code',
                        border: OutlineInputBorder(),
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
                  width: 200,
                  child: ElevatedButton(onPressed:otp_verify, child: Text("Verify",style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004225),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),),
                ),
                SizedBox(height: 20,),
                Text("$invalid_otp",style: TextStyle(color: Colors.red),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
