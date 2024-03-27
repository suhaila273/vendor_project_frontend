import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor_app/Pages/BottomNavigationPage.dart';
import 'package:vendor_app/Pages/Menu_page.dart';
import 'package:vendor_app/Pages/forgot_pass_email_verif.dart';
import 'package:vendor_app/Pages/register_page.dart';
import 'package:vendor_app/Services/user_service.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _obscureText = true; // Track password visibility
  String respText="";

  TextEditingController email1=new TextEditingController();
  TextEditingController pass1=new TextEditingController();

  void SendValuesToApi() async {
    respText="";
    final response = await VendorApiService().VendorloginData(email1.text, pass1.text);
    if(response["status"]=="success")
    {
      String userId=response["userdata"]["_id"].toString();
      SharedPreferences.setMockInitialValues({});
      SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.setString("userId", userId);
      print("successfully login");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavPage()));
    }
    else if(response["status"]=="invalid email id")
    {
      print("Invalid email id");
      setState(() {
        respText="Please Enter valid Email Id";
      });
    }
    else if(response["status"]=="incorrect password")
    {
      print("Invalid password");
      setState(() {
        respText = "Incorrect Password";
      });
    }
    else
    {
      print("Error");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25,),
            SvgPicture.asset(height: 225,'assets/farm2.svg'),
            SizedBox(height: 25,),
          Text("Login to your Account !",style: TextStyle(color: Color(0xFF004225),fontSize: 22),),
          SizedBox(height: 25,),
          TextField(
            controller: email1,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffe1ead8),
              labelText: "Email Id",
              labelStyle: TextStyle(color: Colors.grey.shade800),
              //hintText: "Enter email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.email_outlined),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.green,
                    width: 1,
                  ),
                )
            ),
          ),
          SizedBox(height: 10,),
              TextField(
                controller: pass1,
                obscureText: _obscureText, // Maintain a boolean variable to track password visibility
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe1ead8),
                  labelText: "Password",
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

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Forgot_Password()));
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          SizedBox(
            height: 50,
            width: 250,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004225),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed:SendValuesToApi, child:Text("Log In",style: TextStyle(fontSize: 18),)),
          ),
          SizedBox(height: 15,),
              Text("$respText",
                style: TextStyle(color: Colors.red,fontSize: 15),),
              SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(color:Colors.black,fontSize: 16 ,),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:Color(0xFF004225),
                  ),
                ),
              )
            ],
            ),
          ]
          ),
        ),
    )
    );
  }
}
