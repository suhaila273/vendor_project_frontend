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
        invalid_email="Email not registered";
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
                Text("Enter email id",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),),
                SizedBox(height: 10,),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: ob1,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        hintText: 'email',
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
                Text("$invalid_email",style: TextStyle(color: Colors.red),),
                SizedBox(height: 10,),
                Text("We'll send a verification code to this email"),
                SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed:otp_email,
                    child: Text("Continue"),
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
