// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/screens/login.dart';
import 'package:listing_app/services/global_method.dart';

class RegisterScreen extends StatefulWidget {
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation <double> _animation;
  late TextEditingController _fullnameTextController = 
  TextEditingController(text: " ");
  late TextEditingController _usernameTextController = 
  TextEditingController(text: " ");
  late TextEditingController _emailTextController = 
  TextEditingController(text: " ");
  late TextEditingController _passwordTextController = 
  TextEditingController(text: " ");
  late TextEditingController _confirmpasswordTextController = 
  TextEditingController(text: " ");

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  bool _obscureText = true;
  final _registerFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _animationController.dispose();
    _fullnameTextController.dispose();
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmpasswordTextController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)..addListener(() {setState(() {
      
    });
    })..addStatusListener((animationStatus) { 
      if (animationStatus == AnimationStatus.completed){
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
    super.initState();
  }

  void _SubmitFormLogin() async{
    final isValid = _registerFormKey.currentState!.validate();
    if(isValid){
      setState(() {
        _isLoading = true;
      });
     try{
        await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim().toLowerCase(),
        password: _passwordTextController.text.trim()  
      );
     }catch(errorrr){
       setState(() {
        _isLoading = false;
      });
      // showErrorDialog(errorrr.toString());
       GlobalMethod.showErrorDialog(error: errorrr.toString(), context: context);
     }
    }
    setState(() {
        _isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
            placeholder: (context, url) => Image.asset("assets/images/wal.png", fit:BoxFit.fill,),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0)
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                SizedBox(
                  height:size.height*0.1,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight:FontWeight.bold
                  )
                ),
                SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account',
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                        text: '   Login',
                        style: TextStyle(color: Colors.red )
                      )
                    ]
                  )
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _fullnameTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your Name";
                      }else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                       labelText: "Full Name",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20
                      ),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                   SizedBox(
                    height: 20,
                  ),
                   TextFormField(
                     textInputAction: TextInputAction.next,
                     onEditingComplete: () =>
                     FocusScope.of(context).requestFocus(_emailFocusNode),
                     focusNode: _usernameFocusNode,
                    keyboardType: TextInputType.name,
                    controller: _usernameTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your UserName";
                      }else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                       labelText: "Username",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20
                      ),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                   SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                     textInputAction: TextInputAction.next,
                     onEditingComplete: () =>
                     FocusScope.of(context).requestFocus(_passwordFocusNode),
                     focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your valid email address";
                      }
                      // }else if(value.contains("@")){
                      //   return "Please enter a valid email address";
                      // }
                      else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                       labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20
                      ),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                   SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                     textInputAction: TextInputAction.next,
                     onEditingComplete: () =>
                     FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
                     focusNode: _passwordFocusNode,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTextController,
                    validator: (value){
                      if(value!.isEmpty || value.length < 6){
                        return "Please enter a password";
                      }if(value.length > 10){
                        return "Password too long";
                      }
                      else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obscureText =! _obscureText;
                          });
                        },
                        child: Icon(
                           _obscureText ?Icons.visibility : Icons.visibility_off,
                            color: Colors.white
                          ),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20,),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                   SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                     textInputAction: TextInputAction.done,
                     onEditingComplete: () => _SubmitFormLogin,
                     focusNode: _confirmPasswordFocusNode,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmpasswordTextController,
                    validator: (value){
                      if(value!.isEmpty || value.length < 6){
                        return "Please enter a password";
                      }if(value.length > 10){
                        return "Password too long";
                      }
                      else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obscureText =! _obscureText;
                          });
                        },
                        child: Icon(
                           _obscureText ?Icons.visibility : Icons.visibility_off,
                            color: Colors.white
                          ),
                      ),
                      labelText: "Confirmpassword",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20,),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                      ],
                    )
                  ),
                  SizedBox(
                    height: 40,
                  ),
                _isLoading?  Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey ,
                    child:  CircularProgressIndicator(),
                  ),
                ): MaterialButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                    ),
                  onPressed: _SubmitFormLogin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.login,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  )
              ]
            ),
          )
        ],
      ),
    );
  }
}
