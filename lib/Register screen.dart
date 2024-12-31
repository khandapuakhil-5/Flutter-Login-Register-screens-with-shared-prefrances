import 'package:flutter/material.dart';
import 'package:task/Homescreen.dart';
import 'package:task/Login%20screen.dart';
class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  bool visiablePassword =false;

  TextEditingController nameTextEditController=TextEditingController();
  TextEditingController emailTextEditController=TextEditingController();
  TextEditingController passwordTextEditController=TextEditingController();
  TextEditingController conformpasswordTextEditController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Login screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameTextEditController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 18,),
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
            SizedBox(height: 18,),
            TextFormField(
              controller: conformpasswordTextEditController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter Conform Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () async {

                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Homescreen()));
              },
              child: Text(
                "Register",
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
                Text("Already Have an Account?",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Loginscreen(),));
                }, child: Text("Login",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),)),
              ],)

          ],
        ),
      ),
    );
  }
}

