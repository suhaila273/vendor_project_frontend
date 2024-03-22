import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vendor_app/Pages/login.dart';
import 'package:vendor_app/Services/forgot_pass_services.dart';

class ResetPassword extends StatefulWidget {
  final String? email;
  const ResetPassword({super.key,this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  bool _obscureText = true; // Track password visibility

  TextEditingController ob1=new TextEditingController();
  TextEditingController ob2=new TextEditingController();
  String success="";
  String notmatch="";
  void change_password() async{
    success="";
    notmatch="";
    if(ob1.text == ob2.text)
    {
      final response=await ResetPasswordApiService().changePassword(widget.email!, ob1.text);
      if(response["message"]=="Success")
      {
        print("Success");
        setState(() {
          success="Password reset successfully";
        });

      }
      else
      {
        print("Failed");
      }
    }
    else
      {
        setState(() {
          notmatch="Password do not match";
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
                SvgPicture.asset(height: 250,'assets/cyber.svg'),
                //SvgPicture.asset("assets/farm2.svg",height: 300,width: 300,alignment: Alignment.center,),
                SizedBox(height: 15,),
                Text("Create New Password !",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004225)
                  ),),
                SizedBox(height: 10,),
                Text("Create a new password",
                  style: TextStyle(color: Colors.grey.shade800),),
                SizedBox(height: 20,),
                TextField(
                  controller: ob1,
                  obscureText: _obscureText, // Maintain a boolean variable to track password visibility
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffe1ead8),
                      labelText: "New Password",
                      labelStyle: TextStyle(color: Colors.grey.shade800),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), // Toggle icon based on _obscureText
                        onPressed: () {
                          // Toggle password visibility
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 1,
                        ),
                      )
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: ob2,
                  obscureText: true, // Maintain a boolean variable to track password visibility
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffe1ead8),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.grey.shade800),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock_reset_outlined),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1,
                        ),
                      )
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(onPressed:change_password, child: Text("Reset Password",style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004225),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )

                    ),),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: OutlinedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                  },
                      child: Text("Back to LogIn",style: TextStyle(fontSize: 18 ),),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF004225)),
                      foregroundColor: Color(0xFF004225),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("$success",style: TextStyle(color: Colors.green),),
                Text("$notmatch",style: TextStyle(color: Colors.red),),
               /* GestureDetector(
                  child: Text("Back to login",style: TextStyle(color: Colors.grey.shade800),),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignInPage()));
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
