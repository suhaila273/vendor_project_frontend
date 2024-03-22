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
                SvgPicture.asset("assets/farm2.svg",height: 300,width: 300,alignment: Alignment.center,),
                SizedBox(height: 10,),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: ob1,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.verified_outlined),
                        hintText: 'verification code',
                        border: OutlineInputBorder(),
                        labelText: '',
                        fillColor: Colors.grey,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        )
                    ),
                  ),
                ),
                Text("$invalid_otp",style: TextStyle(color: Colors.red),),
                SizedBox(height: 10,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed:otp_verify, child: Text("Continue"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )

                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
