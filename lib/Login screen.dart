import 'package:flutter/material.dart';
import 'package:task/Homescreen.dart';

import 'package:task/Register%20screen.dart';
import 'package:task/main.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool visiablePassword =false;

  TextEditingController emailTextEditController=TextEditingController();
  TextEditingController passwordTextEditController=TextEditingController();
  @override
  void initState() {
    bool? isUserLoginData=sharedPreferences.getBool("isUserLogin");
    if(isUserLoginData != null && isUserLoginData){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx)=>Homescreen()),
              (route)=>false);
    } else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx)=>Loginscreen()),
              (route)=>false);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Login screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailTextEditController,
          keyboardType: TextInputType.emailAddress,
          validator: (value){
              final boolemailValid=RegExp("@((\w+(-+\w+)*\.)+\w+(-+\w+)*\b");

                  print("emailValid ${boolemailValid}");

                   if(value==null||value.isEmpty){
                    return "email addrees should not be empty";
               }else if(value.isEmpty){
                 return "please enter valid email addrees";
              }
                return null;
    },
            decoration: InputDecoration(
              labelText: "Enter Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(height: 18,),
          TextFormField(
            controller: passwordTextEditController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Enter Password",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                  onTap:() {
                    setState(() {
                      visiablePassword = !visiablePassword;
                      print(visiablePassword);
                    });
                  },
                  child: Icon(visiablePassword
                      ?Icons.visibility_outlined
                      :Icons.visibility_off_outlined)),
                      ),
            ),

          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () async {
              await sharedPreferences.setString("email", emailTextEditController.text);
             await sharedPreferences.setBool("isUserLogin", true);
             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Homescreen()));
            },
            child: Text(
              "Log In",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),),
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(55),
              backgroundColor: Colors.red,),
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't Have an Account?",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Registerscreen(),));
              }, child: Text("Register",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),)),
            ],)

        ],
      ),

    );
  }
}