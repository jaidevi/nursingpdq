import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Customcomponents/custom_button.dart';
import '../constants/colors.dart';
import 'controller/login_controller.dart';
import 'form_messages.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  LoginController controller = Get.put(LoginController());
  // final SqliteDbHelper _sqliteDbHelper = SqliteDbHelper();
  var selectedSalutation;
  final _emailFormFieldKey = GlobalKey<FormFieldState>();
  final _passwordFormFieldKey = GlobalKey<FormFieldState>();
  String? email, password,axpapp,baseurl;
  late FocusNode passwordFocusNode;
  String paswordFieldSuffixText = "Show";
  var newBase64;
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
  }
  bool? _popupBuilderSelection = false;
  final _popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final _multiKey = GlobalKey<DropdownSearchState<String>>();

  //LoginController _loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: 
      Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text("Login",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                emailFormField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                passwordFormField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Select unit'),
                  value: selectedSalutation,

                  validator: (value) => value == null ? 'field required' : null,
                  decoration: InputDecoration(
                    labelText: "Unit",
                    labelStyle: const TextStyle(color: primaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: primaryColor)),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    // const DropdownMenuItem(
                    //   value: 'KCH',
                    //   child: Text("KCH"),
                    // ),
                    // const DropdownMenuItem(
                    //   value: 'KCN',
                    //   child: Text("KCN"),
                    // ),
                    // const DropdownMenuItem(
                    //   value: 'KSM',
                    //   child: Text("KSM"),
                    // ),
                    const DropdownMenuItem(
                      value: 'KTN',
                      child: Text("KTN"),
                    ),
                    const DropdownMenuItem(
                      value: 'KHC',
                      child: Text("KHC"),
                    ),
                    // const DropdownMenuItem(
                    //   value: 'KTV',
                    //   child: Text("KTV"),
                    // ),
                    // const DropdownMenuItem(
                    //   value: 'KEB',
                    //   child: Text("KEB"),
                    // ),
                  ],

                  onChanged: (newValue) {
                    setState(() {
                      selectedSalutation = newValue;
                      if(selectedSalutation=='KTN'){
                        axpapp="hmsktn";
                        baseurl="https://hmsktn06.kauverykonnect.com/hmsktnscripts/ASBMenuRest.dll/datasnap/rest/TASBMenuREST/";
                      }
                      else if(selectedSalutation=='KHC'){
                        axpapp="hmsheartcity";
                      //  https://hmsktn06.kauverykonnect.com/hmsktnscripts/ASBMenuRest.dll/datasnap/rest/TASBMenuREST/getchoices
                        baseurl="https://telemedicinescripts.kauveryhospital.com/hmsheartcityscripts/ASBMenuRest.dll/datasnap/rest/TASBMenuREST/";
                      }
                      print("hai");

                      print(selectedSalutation);
                      print(baseurl);
                      print(axpapp);
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomButton(
                  title: "Login",
                  backgroundColor: primaryColor,
                  forgroundColor: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.85,
                  onPressed: () async {
                    //Get.off(CompleteForm());
                    if (controller.formKey.currentState!.validate())
                    {
                      controller.formKey.currentState!.save();
                      controller.loginWithEmails(name: email, pswd: password, unitselect: selectedSalutation,axpapp: axpapp,baseurl: baseurl);
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
generateMd5(String data) {
  // var bytes = utf8.encode(data);
  // var md5Bytes = md5.convert(bytes);
  // newBase64 = base64.encode(md5Bytes.bytes);
 newBase64=md5.convert(utf8.encode(data)).toString();
 return newBase64;
}
  TextFormField emailFormField() {
    return TextFormField(
      
      key: _emailFormFieldKey,
      controller: controller.emailController,
      onSaved: (newEmail) {
        setState(() {
          email = newEmail;
        });
      },
      onChanged: (newEmail) {
        _emailFormFieldKey.currentState!
            .validate(); // call emailFormField validator
      },
      onFieldSubmitted: (newEmail) {
        passwordFocusNode.requestFocus();
      },
      keyboardType: TextInputType.number,
      // decoration: const InputDecoration(
      //     labelText: "Username", hintText: "Enter your username"),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        filled: true,
        labelText: "Employee Id",
        hintText: 'Employee Id',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
      ),

      validator: (newEmail) {
        if (newEmail!.isEmpty) {
          return kEmailNullError;
        }
        else if (newEmail.length < 5) {
          return kInvalidEmailError;
        }
        return null;
      },
    );
  }

  TextFormField passwordFormField() {
    return TextFormField(
      key: _passwordFormFieldKey,
      controller: controller.passwordController,
      focusNode: passwordFocusNode,
      onSaved: (newPassword) {
        generateMd5(newPassword!);
        setState(() {
          password = newBase64;
        });
      },
      onChanged: (newPassword) {
        _passwordFormFieldKey.currentState!
            .validate(); // call passowrd field validator
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      decoration: InputDecoration(
          labelText: "Password",
          labelStyle: const TextStyle(color: primaryColor),
          hintText: "Enter your password",
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor)),
          suffixIcon: TextButton(
            child: Text(
              paswordFieldSuffixText,
              style: const TextStyle(color: primaryColor),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
                paswordFieldSuffixText =
                    (paswordFieldSuffixText == "Show") ? "Hide" : "Show";
              });
            },
          )),
      validator: (newPassword) {
        if (newPassword!.isEmpty) {
          return kPasswordNullError;
        } else if (newPassword.length < 2) {
          return kShortPasswordError;
        }
        return null;
      },
    );
  }
  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }
}
class ScreenArgs {
  final String email;
  final String password;
  const ScreenArgs({required this.email, required this.password});
}