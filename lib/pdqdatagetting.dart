
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Customcomponents/custom_button.dart';
import '../constants/colors.dart';
import '../controller/login_controller.dart';
import 'exam.dart';



class qrdatagetting extends StatefulWidget {
  const qrdatagetting({super.key});

  @override
  State<qrdatagetting> createState() => _qrdatagettingState();
}

class _qrdatagettingState extends State<qrdatagetting> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  String? email,
      password,
      bed_no,
      patname,
      uhid,
      ip_no,
      doctor_name,
      ward_name,
      primary_care_taker_no;
  String? getpatientname, getuhid, getipnum, getprimarydoc, getpctnum;
  String? ip_nos, names, uhids, primary_care_taker_nos, pctnumbers;
//final _formKey = GlobalKey<FormBuilderState>();
  LoginController controller = Get.put(LoginController());
  final _patnameFormFieldKey = GlobalKey<FormFieldState>();
  final _uhidFormFieldKey = GlobalKey<FormFieldState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _ipnumFormFieldKey = GlobalKey<FormFieldState>();

  final _pridocFormFieldKey = GlobalKey<FormFieldState>();

  final _pctconnumFormFieldKey = GlobalKey<FormFieldState>();

  //  final _multiKey = GlobalKey<MultiSelectFormField<String>>();
  late String username, qrcodes;

  List? _myActivities;
  bool _isVisible = true;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordFocusNode = FocusNode();
    _loadCounterqr();
    var _myActivities = [];
  }

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  _loadCounterqr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ip_no = (prefs.getString('ip_no') ?? '');
      uhid = (prefs.getString('uhid') ?? '');
      patname = (prefs.getString('patname') ?? '');
      doctor_name = (prefs.getString('doctor_name') ?? '');
      ward_name = (prefs.getString('ward_name') ?? '');
      bed_no = (prefs.getString('bed_no') ?? '');
      primary_care_taker_no = (prefs.getString('primary_care_taker_no') ?? '');

      print("fffff");
      print(bed_no);
      print("f1");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 173, 23, 143),
          title: const Center(child: Text('Nursing PDQ'))),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    patnameFormField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    uhidFormField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ipnumFormField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    pridocFormField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    pctconFormField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        title: "Next",
                        backgroundColor: primaryColor,
                        forgroundColor: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.18,
                        onPressed: () async {
                          //Get.off(CompleteForm());
                          if (controller.formKey.currentState!.validate())
                          {
                            controller.formKey.currentState!.save();
                            // controller.loginWithEmails2(
                            //     names: getpatientname,
                            //     ip_nos: getipnum,
                            //     uhids: getuhid,
                            //     primary_care_taker_nos: getprimarydoc,
                            //     pctnumbers: getpctnum);

                            SharedPreferences prefs = await _prefs;
                            await prefs.setString('ip_no', getipnum!);
                            await prefs.setString('uhid', getuhid!);
                            await prefs.setString('patname', getpatientname!);
                            await prefs.setString('doctor_name', getprimarydoc!);
                            await prefs.setString('primary_care_taker_no', getpctnum!);
                            Get.offAll(const testss());
                           // Get.offAll(const MyWidgettesting());
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField patnameFormField() {
    return TextFormField(
      key: _patnameFormFieldKey,
      controller: TextEditingController(text: patname),
      onSaved: (newEmail) {
        setState(() {
          getpatientname = newEmail;
        });
      },
      onChanged: (newEmail) {
        _patnameFormFieldKey.currentState!
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
        labelText: "Patient Name",
        hintText: 'Patient Name',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
      ),
    );
  }

  TextFormField ipnumFormField() {
    return TextFormField(
      //initialValue: bed_no,
      key: _ipnumFormFieldKey,
      controller: TextEditingController(text: ip_no),
      onSaved: (newipno) {
        setState(() {
          getipnum = newipno;
        });
      },
      onChanged: (newipno) {
        _ipnumFormFieldKey.currentState!
            .validate(); // call emailFormField validator
      },
      onFieldSubmitted: (newipno) {
        passwordFocusNode.requestFocus();
      },
      keyboardType: TextInputType.number,
      // decoration: const InputDecoration(
      //     labelText: "Username", hintText: "Enter your username"),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        filled: true,
        labelText: "IP Number",
        hintText: 'IP Number',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
      ),

    
    );
  }

  TextFormField uhidFormField() {
    return TextFormField(
      //initialValue: bed_no,
      key: _uhidFormFieldKey,
      controller: TextEditingController(text: uhid),
      onSaved: (newuhid) {
        setState(() {
          getuhid = newuhid;
        });
      },
      onChanged: (newuhid) {
        _uhidFormFieldKey.currentState!
            .validate(); // call emailFormField validator
      },
      onFieldSubmitted: (newuhid) {
        passwordFocusNode.requestFocus();
      },
      keyboardType: TextInputType.number,
      // decoration: const InputDecoration(
      //     labelText: "Username", hintText: "Enter your username"),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        filled: true,
        labelText: "UHID",
        hintText: 'UHID',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
      ),


    );
  }

  TextFormField pridocFormField() {
    return TextFormField(
      //initialValue: bed_no,
      key: _pridocFormFieldKey,
      controller: TextEditingController(text: doctor_name),
      onSaved: (newpridoc) {
        setState(() {
          getprimarydoc = newpridoc;
        });
      },
      onChanged: (newpridoc) {
        _pridocFormFieldKey.currentState!
            .validate(); // call emailFormField validator
      },
      onFieldSubmitted: (newpridoc) {
        passwordFocusNode.requestFocus();
      },
      keyboardType: TextInputType.number,
      // decoration: const InputDecoration(
      //     labelText: "Username", hintText: "Enter your username"),
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        filled: true,
        labelText: "Primary Dr",
        hintText: 'Primary Dr',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
      ),

      // validator: (newEmail) {
      //   if (newEmail!.isEmpty) {
      //     return kEmailNullError;
      //   }
      //   else if (newEmail.length < 5) {
      //     return kInvalidEmailError;
      //   }
      //   return newEmail;
      // },
    );
  }

  TextFormField pctconFormField() {
    return TextFormField(
      //initialValue: bed_no,
      key: _pctconnumFormFieldKey,
      controller: TextEditingController(text: primary_care_taker_no),
      onSaved: (newpctcon) {
        setState(() {
          getpctnum = newpctcon;
        });
      },
      onChanged: (newpctcon) {
        _pridocFormFieldKey.currentState!
            .validate(); // call emailFormField validator
      },
      onFieldSubmitted: (newpctcon) {
        passwordFocusNode.requestFocus();
      },
      keyboardType: TextInputType.number,

      // decoration: const InputDecoration(
      //     labelText: "Username", hintText: "Enter your username"),

      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        filled: true,
        labelText: "Patient Mobile Number",
        hintText: 'Patient  Mobile Number',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor)),
      ),

      // validator: (newEmail) {
      //   if (newEmail!.isEmpty) {
      //     return kEmailNullError;
      //   }
      //  else if (newEmail.length < 5) {
      //     return kInvalidEmailError;
      //   }
      //   return newEmail;
      // },

    );
  }
}
