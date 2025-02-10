


// create a sign up page with creative design and using email and password

import 'package:bookmarker/core/routing/router.dart';
import 'package:bookmarker/core/shared/mobVeiw.dart';
import 'package:bookmarker/core/theming/size.dart';
import 'package:bookmarker/features/Auth/ui/screens/sign_up.dart';
import 'package:bookmarker/features/Auth/ui/screens/textfield.dart';
import 'package:bookmarker/features/splash&navi/ui/navi.dart';
import 'package:flutter/material.dart';
import 'package:bookmarker/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../cubit/cubit/auth_cubit.dart';
import '../widgets/forget_password_dialog.dart';
import '../widgets/loading_dialog.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool remember_me = true;

    final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthLoading) {
          // Show loading indicator
          showDialog(context: context, builder: (_) => LoadingDialog());
        } else if (state is AuthAuthenticated) {
          // Navigate to the next screen
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Signed in successfully",
                style: TextStyle(color: colors.text),
              )));
          context.navigateTo(navi());
        } else if (state is AuthError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colors.liveText,
              content: Text(
                state.message,
                style: TextStyle(color: colors.text),
              )));
        }
      }, builder: (context, state) {
        final cubit = BlocProvider.of<AuthCubit>(context);
      
    return Scaffold(
      body: MobView(
        widget: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.all(20.0),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/logo_png.png', // Replace with your image path
                      height: context.height(0.1),
                    ),
                    
                    context.height_box(0.005),
                    Text(
                      "Keep It Together",
                      style: TextStyle(
                        fontSize: context.fontSize(18),
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    context.height_box(0.03),
      
                    Text(
                      'please sign in to continue',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    context.height_box(0.02),
                  Form(
          key: _formKey,
          child: Column(
            children: [
           // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: colors.coco,),
                   enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.coco, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.coco, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              context.height_box(0.03),
              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                   labelStyle: TextStyle(
                    color: colors.coco,),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.coco, width: 1.0),
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.coco, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
             
            ],
          ),
        ),
                    context.height_box(0.01),

                    // forget password text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => ForgetPasswordDialog());
                        },
                       child: Text('Forget password?',
                            style: TextStyle(
                                fontSize: context.fontSize(14),
                                fontFamily: 'Manrope',
                                color: colors.coco)),
                      ),
                    ),
                    context.height_box(0.01),       
           
           // continue with google and facebook
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text('Or continue with',
                    style: TextStyle(
                        fontSize: context.fontSize(16),
                        fontFamily: 'Manrope',
                        color: colors.coco
                        )),
              ],
            ),
                    context.height_box(0.01),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              // google icon
              GestureDetector(
                onTap: () {
                  cubit.signInWithGoogle();
                },
                child: CircleAvatar(
                  radius: context.fontSize(25),
                  backgroundColor: colors.coco,
                  child: Icon(
                    Bootstrap.google,
                    color: colors.text,
                    size: context.fontSize(22),
                  ),
                ),
              ),
             
            ]),
         
      
                    context.height_box(0.01),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Checkbox(
                            activeColor: colors.coco,
                            value: remember_me, onChanged: (value) {setState(() {
                            remember_me = value!;
                          });}),
                          Text(
                            'Remember me',
                            style: TextStyle(
                                fontSize: context.fontSize(14),
                                fontWeight: FontWeight.normal,
                                color: colors.primary,
                                fontFamily: 'Manrope'),
                          ),
                         
                        ],
                      ),
                    ),
                    context.height_box(0.02),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          cubit.signIn(_emailController.text.trim(), _passwordController.text.trim());
                        }
                      },
                      child: Text('Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.0),
                        backgroundColor: colors.coco.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 20.0),
                        // don't have account text
                        Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //context.width_box(0.05),
                Text('Don\'t have an account?',
                    style: TextStyle(
                        fontSize: context.fontSize(13),
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.normal,
                        color: colors.coco)),
                //context.width_box(0.03),
                GestureDetector(
                    onTap: () {
                      context.navigateTo(SignUpPage());
                    },
                    child: Text('Sign Up',
                        style:TextStyle(
                            fontSize: context.fontSize(13),
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.bold,
                            color: colors.primary))),
              ],
            ),
         
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
      })    );
  
  }
}