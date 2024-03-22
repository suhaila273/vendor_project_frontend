import 'package:flutter/material.dart';
import 'package:vendor_app/Pages/login.dart';
import 'package:vendor_app/Services/user_service.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email1=new TextEditingController();
  TextEditingController pass1=new TextEditingController();
  TextEditingController cmp_name1=new TextEditingController();
  TextEditingController cmp_add1=new TextEditingController();
  TextEditingController person1=new TextEditingController();
  TextEditingController contact1=new TextEditingController();

  void SendValuesToApiSignUp() async {

    final response = await VendorApiService().addVendorApi(
        email1.text.toString(),
        pass1.text,
        cmp_name1.text,
        cmp_add1.text,
        person1.text,
        contact1.text.toString());
    if(response["status"]=="success")
    {
      print("successfully Registered");
    }
    else
    {
      print("Error");
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        icon: Icon(Icons.arrow_back_ios,color: Color(0xFF004225),size: 25,),)
                  ],
                ),
                Icon(Icons.person,color:Color(0xFF004225) ,size: 45,),
                Text("Create new Account !",style: TextStyle(color: Color(0xFF004225),fontSize: 22),),
                SizedBox(height: 15,),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email1,
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
                  obscureText: true,
                  controller: pass1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe1ead8),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    //hintText: "Enter password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
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
                  controller: cmp_name1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe1ead8),
                    labelText: "Enterprise Name",
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    //hintText: "Enter enterprise/company name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.home_work_outlined),
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
                  controller: cmp_add1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe1ead8),
                    labelText: "Enterprise Address",
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    //hintText: "Enter Enterprise/Company Address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.location_on_outlined),
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
                  controller: person1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe1ead8),
                    labelText: "Contact Person Name",
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    //hintText: "Enter contact person name",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.location_history_outlined),
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
                  controller: contact1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe1ead8),
                    labelText: "Contact Number",
                    labelStyle: TextStyle(color: Colors.grey.shade800),
                    //hintText: "Enter contact number",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.call_outlined),
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
                      onPressed:SendValuesToApiSignUp, child:Text("Sign Up",style: TextStyle(fontSize: 18),)),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: TextStyle(color: Colors.black,fontSize: 16 ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignInPage()));
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color:Color(0xFF004225),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
