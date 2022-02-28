import 'package:flutter/material.dart';

import 'package:fyp_lms/utils/constant.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin{
  //====================== VARIABLES =================================

  bool _registerState = false;

  TextEditingController? _usernameController;
  String? usernameErrorMessage;

  TextEditingController? _passwordController;
  String? passwordErrorMessage;
  bool passwordVisibility = false;

  TextEditingController? _confirmPasswordController;
  String? confirmPasswordErrorMessage;
  bool confirmPasswordVisibility2 = false;

  //bool _nameAutoFocus = true;


  //===================== METHODS ====================================
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  loginViaEmail() {
    usernameErrorMessage = null; passwordErrorMessage = null;

    if (_usernameController!.text.validateEmail() == false) usernameErrorMessage = 'Please enter valid email address';
    if (_passwordController!.text.length < 8) passwordErrorMessage = 'Password Must be at least 8 characters';

    setState(() {});
    if (passwordErrorMessage != null || usernameErrorMessage != null) return;


  }

  registerViaEmail() {
    usernameErrorMessage = null; passwordErrorMessage = null; confirmPasswordErrorMessage = null;

    if (_usernameController!.text.validateEmail() == false) usernameErrorMessage = 'Please enter valid email address';
    if (_passwordController!.text.length < 8) passwordErrorMessage = 'Password Must be at least 8 characters';
    if (_confirmPasswordController!.text.length < 8 || _confirmPasswordController!.text != _passwordController!.text) confirmPasswordErrorMessage = 'Confirm Password must be the same as password.';

    setState(() {});
    if (passwordErrorMessage != null || usernameErrorMessage != null || confirmPasswordErrorMessage != null) return;


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 2.0,
            colors: [
              BG_COLOR_1,
              BG_COLOR_1,
              BG_COLOR_4,
            ],
            stops: [
              0.0,
              0.9,
              1.0,
            ]
          )
        ),
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, left: 24.0, right: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // LOGO
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: LARGE_V_GAP,),
                // USERNAME
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: LARGE_V_GAP, bottom: SMALL_V_GAP),
                  child: TextField(
                    controller: _usernameController,
                    maxLines: 1,
                    minLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: BORDER_BLUE, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: BORDER_BLUE, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: BORDER_BLUE, width: 2.0),
                      ),
                      hintText: 'e.g: xxx@gmail.com',
                      hintStyle: GoogleFonts.poppins().copyWith(color: HINT_TEXT_COLOR),
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins().copyWith(color: BORDER_BLUE),
                      errorStyle: GoogleFonts.poppins().copyWith(
                        color: ERROR_RED,
                        fontSize: SUB_TITLE,
                      ),
                      errorText: usernameErrorMessage,
                      prefixIcon: const Icon(Icons.email, color: BORDER_BLUE, size: 22,),
                      suffixIcon: _usernameController!.text.isEmpty ? const SizedBox() :
                      const Icon(Icons.cancel, color: Colors.grey, size: 18).onTap(() {
                        setState(() {
                          _usernameController!.text = '';
                        });
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: V_GAP),

                // PASSWORD
                Container(
                  height: 56,
                  margin: const EdgeInsets.only(top: LARGE_V_GAP, bottom: SMALL_V_GAP),
                  child: TextField(
                    controller: _passwordController,
                    maxLines: 1,
                    minLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passwordVisibility,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: BORDER_BLUE, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: BORDER_BLUE, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: BORDER_BLUE, width: 2.0),
                      ),
                      errorStyle: GoogleFonts.poppins().copyWith(
                        color: ERROR_RED,
                        fontSize: SUB_TITLE,
                      ),
                      hintText: 'e.g: xxxxxxxx',
                      hintStyle: GoogleFonts.poppins().copyWith(color: HINT_TEXT_COLOR),
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins().copyWith(color: BORDER_BLUE),
                      errorText: passwordErrorMessage,
                      prefixIcon: const Icon(Icons.lock, color: BORDER_BLUE, size: 22,),
                      suffixIcon: Icon(passwordVisibility ? Icons.visibility_off : Icons.visibility, color: BORDER_BLUE, size: 18).onTap(() {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: V_GAP),

                // CONFIRM PASSWORD
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: ANIMATION_DURATION),
                  height: _registerState ? 72 : 0,
                  child: !_registerState ? const SizedBox() : Container(
                    margin: const EdgeInsets.only(top: LARGE_V_GAP, bottom: SMALL_V_GAP),
                    child: TextField(
                      controller: _confirmPasswordController,
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: confirmPasswordVisibility2,
                      onChanged: (value) {
                        setState(() {

                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: BORDER_BLUE, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: BORDER_BLUE, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: BORDER_BLUE, width: 2.0),
                        ),
                        errorStyle: GoogleFonts.poppins().copyWith(
                          color: ERROR_RED,
                          fontSize: SUB_TITLE,
                        ),
                        hintText: 'e.g: xxxxxxxx',
                        hintStyle: GoogleFonts.poppins().copyWith(color: HINT_TEXT_COLOR),
                        labelText: 'Confirm Password',
                        labelStyle: GoogleFonts.poppins().copyWith(color: BORDER_BLUE),
                        errorText: confirmPasswordErrorMessage,
                        prefixIcon: const Icon(Icons.lock, color: BORDER_BLUE, size: 22,),
                        suffixIcon: Icon(confirmPasswordVisibility2 ? Icons.visibility_off : Icons.visibility, color: BORDER_BLUE, size: 18).onTap(() {
                          setState(() {
                            confirmPasswordVisibility2 = !confirmPasswordVisibility2;
                          });
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: X_LARGE_V_GAP),

                //LOGIN BUTTON
                Container(
                  padding: const EdgeInsets.only(left: X_LARGE_H_GAP, right: X_LARGE_H_GAP, top: V_GAP, bottom: V_GAP),
                  decoration: const BoxDecoration(
                    color: BG_COLOR_4,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(_registerState ? 'REGISTER VIA EMAIL' : 'LOGIN VIA EMAIL', style: GoogleFonts.poppins().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),),
                ).onTap(() {
                  if (_registerState) {
                    registerViaEmail();
                  } else {
                    loginViaEmail();
                  }
                }),

                const SizedBox(height: X_LARGE_V_GAP,),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  constraints: _registerState
                      ? const BoxConstraints(maxHeight: 0.0)
                      : const BoxConstraints(maxHeight: 25),
                  duration: const Duration(milliseconds: ANIMATION_DURATION),
                  child: _registerState ? const SizedBox() : Center(
                    child: Text('Don\'t have an account?', style: GoogleFonts.poppins().copyWith(
                      color: HINT_TEXT_COLOR,
                      fontSize: HINT_TEXT,
                    ),),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  constraints: _registerState
                      ? const BoxConstraints(maxHeight: 0.0)
                      : const BoxConstraints(maxHeight: 25),
                  duration: const Duration(milliseconds: ANIMATION_DURATION),
                  child: _registerState ? const SizedBox() : Center(
                    child: Text('Register Here', style: GoogleFonts.poppins().copyWith(
                      color: BG_COLOR_2,
                      fontSize: SUB_TITLE,
                    )),
                  ).onTap(() {
                    //ENABLE REGISTER FIELD
                    setState(() {
                      _registerState = true;
                    });
                  }),
                ),

                AnimatedContainer(
                  curve: Curves.easeInOut,
                  constraints: _registerState
                      ? const BoxConstraints(maxHeight: 25)
                      : const BoxConstraints(maxHeight: 0.0),
                  duration: const Duration(milliseconds: ANIMATION_DURATION),
                  child: !_registerState ? const SizedBox() : Center(
                    child: Text('Already have an account?', style: GoogleFonts.poppins().copyWith(
                      color: HINT_TEXT_COLOR,
                      fontSize: HINT_TEXT,
                    )),
                  ).onTap(() {
                    //DISABLE REGISTER FIELD
                    setState(() {
                      _registerState = false;
                    });
                  }),
                ),

                AnimatedContainer(
                  curve: Curves.easeInOut,
                  constraints: _registerState
                      ? const BoxConstraints(maxHeight: 25)
                      : const BoxConstraints(maxHeight: 0.0),
                  duration: const Duration(milliseconds: ANIMATION_DURATION),
                  child: !_registerState ? const SizedBox() : Center(
                    child: Text('Login Here', style: GoogleFonts.poppins().copyWith(
                      color: BG_COLOR_2,
                      fontSize: SUB_TITLE,
                    )),
                  ).onTap(() {
                    //DISABLE REGISTER FIELD
                    setState(() {
                      _registerState = false;
                    });
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
    super.dispose();
  }
}
