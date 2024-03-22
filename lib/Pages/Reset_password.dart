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

  TextEditingController ob1=new TextEditingController();
  TextEditingController ob2=new TextEditingController();
  String success="";
  void change_password() async{
    success="";
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
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: 'new password',
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
                SizedBox(height: 10,),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: ob2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_reset_outlined),
                        hintText: 'confirm password',
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
                SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed:change_password, child: Text("Continue"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )

                    ),),
                ),
                Text("$success",style: TextStyle(color: Colors.green),),
                GestureDetector(
                  child: Text("Back to login",style: TextStyle(color: Colors.teal),),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignInPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
