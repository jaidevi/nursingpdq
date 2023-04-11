import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/login_controller.dart';

import 'sign_in_screen.dart';

class testss extends StatefulWidget {
  const testss({super.key});

  @override
  State<testss> createState() => _testssState();
}

class _testssState extends State<testss> {
  bool autoValidate = true;
  bool readOnly = false;
  var formdata;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //  final _multiKey = GlobalKey<MultiSelectFormField<String>>();
  late String password,
      username,
      qrcodes,
      ip_no,
      uhid,
      patname,
      doctor_name,
      ward_name,
      bed_no,
      session,
      primary_care_taker_no;
  List? _myActivities,
      _myActivities1,
      _myActivities2,
      _myActivities3,
      _myActivities4,
      _myActivities5,
      _myActivities6,
      _myActivities7,
      _myActivities8,
      _myActivities9;

  late String _myActivities1Result, _myActivities2Result, _myActivitiesResult;
  late String _myActivities3Result, _myActivities4Result;
  String? respatmatsta,resPatientpresentdiet,usermobile,resEdulvlpatient,resustandinglevelpatient,ressleep,resbladderreason,resbladderhabbits,reshealthedu,resdrug,sursite,resdrugreaction,resreaction,respctname,distubesdrains,respctrelationship,resedulevelpct,resundlevelpct,rescontpdccall,reslanguagewanted,resdischargetype,resambulantorbedridden,rescomoribtesreason,restubesdrainagesreason,diswithosotomy,resosotomyreason,diswithhai,reshaidreason,diswithlatinj,reslatrogenicreasons,compduringdis,rescomplicationdisreason,allergy,resfood,resbowelrhabbits;
  bool _isVisible = false;
  LoginController controller = Get.put(LoginController());
  String? patmaritalstatus;
  bool _isVisibles = false;
  bool _isVisible2 = false;
  bool _isVisible3 = false;
  bool _isVisible4 = false;
  bool _isVisible5 = false;
  bool _isVisible6 = false;
  bool _isVisible7 = false;
  bool _isVisible8 = false;
  bool _isVisible9 = false;
  bool _comoribitiesothers = false;
  bool _tubesdrainagesothers = false;
  bool _ostomyothers = false;
  bool _haidothers = false;
  bool _latrogenicothers = false;
  bool _compduringdis = false;
  bool _bladderhabits = false;
  String? gender, psd, comor;

  int _radioValue1 = -1;
  int  correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;
  var genderOptions = [
    'Father',
    'Mother',
    'Son',
    'Daughter',
    'Husband',
    'Wife',
    'Brother',
    'Sister',
    'Grandfather',
    'Grandmother',
    'Grandson',
    'Uncle',
    'Aunt',
    'Nephew',
    'Niece',
    'Cousins'
  ];
  void _onChanged(dynamic val) => debugPrint(val.toString());

  void showToast2(bool bool) {
    setState(() {
      _isVisible2 = bool;
    });
  }

  void showToast3(bool bool) {
    setState(() {
      _isVisible3 = bool;
    });
  }

  void showtoastcomoribites(bool bool) {
    setState(() {
      _comoribitiesothers = bool;
    });
  }

  void showtoasttubesdrainages(bool bool) {
    setState(() {
      _tubesdrainagesothers = bool;
    });
  }

  void showToastosotomy(bool bool) {
    setState(() {
      _ostomyothers = bool;
    });
  }

  void showToasthaid(bool bool) {
    setState(() {
      _haidothers = bool;
    });
  }

  void showtoastlatrogenic(bool bool) {
    setState(() {
      _latrogenicothers = bool;
    });
  }

  void showtoastcompdurdis(bool bool) {
    setState(() {
      _compduringdis = bool;
    });
  }
  void showtoastbladder(bool bool) {
    setState(() {
      _bladderhabits = bool;
    });
  }
  void showToast4(bool bool) {
    setState(() {
      _isVisible4 = bool;
    });
  }

  void showToast5(bool bool) {
    setState(() {
      _isVisible5 = bool;
    });
  }

  void showToast6(bool bool) {
    setState(() {
      _isVisible6 = bool;
    });
  }

  void showToast7(bool bool) {
    setState(() {
      _isVisible7 = bool;
    });
  }

  void showToast8(bool bool) {
    setState(() {
      _isVisible8 = bool;
    });
  }

  void showToast9(bool bool) {
    setState(() {
      _isVisible9 = bool;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounterqr();
    _myActivities = [];
    _myActivities1 = [];
    _myActivities2 = [];
    _myActivities3 = [];
    _myActivities4 = [];
    _myActivities5 = [];
    _myActivities6 = [];
    _myActivities7 = [];
    _myActivities8 = [];
    _myActivities9 = [];

    _myActivitiesResult = '';
    _myActivities1Result = '';
    _myActivities2Result = '';
    _myActivities3Result = '';
    _myActivities4Result = '';
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
      session=(prefs.getString('session') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: _onBackPressed),
        backgroundColor: const Color.fromARGB(255, 173, 23, 143),
        title: const Center(child: Text('Nursing PDQ')),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // L'icône de notre choix
            onPressed:
                _decrementCounter, // La méthode à appeler lorsque l'action est déclenché
          ),
        ],
      ),
      body: FormBuilder(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //Marital status

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Marital Status of the Patient',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'patmaritalstatus',
                        onChanged: (onChanged){
                          respatmatsta = onChanged.toString();
                      },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Single', 'Married']
                            .map((lang) => FormBuilderFieldOption(
                                  value: lang,
                                  child: Text(lang),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //Education Level of the patient//

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Education Level of the Patient',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'Edulvlpatient',
                        onChanged: (_onChanged){
                          resEdulvlpatient = _onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Literate', 'Illiterate']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      ///Understanding level of the Patient
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Understanding level of the Patient',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'ustandinglevelpatient',
                        onChanged: (_onChanged){
                          resustandinglevelpatient=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options:
                            ['Very Good', 'Good', 'Average', 'Below Average']
                                .map((lang) => FormBuilderFieldOption(
                                      value: lang,
                                      child: Text(lang),
                                    ))
                                .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),
                      //Name of pct
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.always,
                          name: 'pctname',
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                              labelText: 'Name of Primary care taker',
                              border: OutlineInputBorder()),
                          onChanged: (val) {
                            setState(() {
                              respctname=val.toString();
                            });
                          },
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          // initialValue: '12',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            0, 20, 0, 0),
                        child: TextFormField(
                          validator: (value) {
                            return controller
                                .mobileValidator(value!);
                          },
                          // controller: mobileController,
                          maxLength: 10,
                          keyboardType:
                          TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Primary care taker contact no",
                              border: OutlineInputBorder()
                          ),
                          onChanged: (value){
                            setState(() {
                              usermobile=value.toString();
                            });

                          },
                          onSaved: (value) {
                            usermobile = controller.mobileValidator(value.toString());
                            print(controller.mobileValidator(value.toString()));
                          },
                        ),
                      ),
                      //Primary care taker relationship
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: DropdownButtonHideUnderline(
                          child: FormBuilderDropdown(
                            name: 'pctrelationship',
                            // ignore: deprecated_member_use
                            isExpanded: true,
                            onChanged: (_onChanged){
                              respctrelationship=_onChanged.toString();
                            },
                            decoration: const InputDecoration(
                                labelText: 'Primary care taker relationship',
                                border: OutlineInputBorder()),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: [
                              "Father",
                              "Mother",
                              "Son",
                              "Son in Law",
                              "Daughter in Law",
                              "Daughter",
                              "Husband",
                              "Wife",
                              "Brother",
                              "Sister",
                              "Grandfather",
                              "Grandmother",
                              "Grandson",
                              "Uncle",
                              "Aunt",
                              "Nephew",
                              "Niece",
                              "Cousins",
                              "Others"
                            ].map((option) {
                              return DropdownMenuItem(
                                child: Text("$option"),

                                value: option,
                              );
                            }).toList(),
                            valueTransformer: (value) => value.toString(),
                          ),
                        ),
                      ),

                      //Education Level of the PCT
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Education Level of the Pt.Attender',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'edulevelpct',
                        onChanged: (_onChanged)
                        {
                          resedulevelpct=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Literate', 'Illiterate']
                            .map((lang) => FormBuilderFieldOption(
                                  value: lang,
                                  child: Text(lang),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //Understanding Level of the PCT
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Understanding Level of the Pt.Attender',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'undlevelpct',
                        onChanged: (_onChanged){
                          resundlevelpct=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options:
                            ['very Good', 'Good', 'Average', 'Below Average']
                                .map((undlevelpct) => FormBuilderFieldOption(
                                      value: undlevelpct,
                                      child: Text(undlevelpct),
                                    ))
                                .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),
                      //whom to contact for pdc call

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Whom to contact for PDC call',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'contactpdccall',
                        onChanged: (_onChanged){
                          rescontpdccall=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Pt.Attender', 'Patient']
                            .map((languagewanted) => FormBuilderFieldOption(
                                  value: languagewanted,
                                  child: Text(languagewanted),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //Language Preferred
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Language Preferred',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'languagewanted',
                        onChanged: (_onChanged){
                          reslanguagewanted=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Tamil', 'English', 'Both']
                            .map((languagewanted) => FormBuilderFieldOption(
                                  value: languagewanted,
                                  child: Text(languagewanted),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //Type Of Discharge
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Type Of Discharge',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'dischargetype',
                        onChanged: (_onChanged){
                          resdischargetype=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Planned', 'Transfer', 'Referral']
                            .map((dischargetype) => FormBuilderFieldOption(
                                  value: dischargetype,
                                  child: Text(dischargetype),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //Patient Status during Discharge: Stable
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText:
                                'Patient Status during Discharge: Stable',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'patientstatusdischarge',
                        onChanged: (onChanged) {
                          psd = onChanged.toString();

                          if (psd == 'Yes') {


                            showToast(false);
                          } else if (psd == 'No') {

                            showToast(true);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((patientstatusdischarge) =>
                                FormBuilderFieldOption(
                                  value: patientstatusdischarge,
                                  child: Text(patientstatusdischarge),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //ambulantorbedridden
                      Visibility(
                        visible: !_isVisible,
                        child: FormBuilderRadioGroup<String>(
                          decoration: const InputDecoration(),
                          initialValue: null,
                          name: 'ambulantorbedridden',
                          onChanged: (_onChanged){
                            resambulantorbedridden=_onChanged.toString();
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.notEqual(Null)
                          ]),
                          options: ['Ambulant', 'Bed ridden']
                              .map((edulvlpat) => FormBuilderFieldOption(
                                    value: edulvlpat,
                                    child: Text(edulvlpat),
                                  ))
                              .toList(growable: false),
                          controlAffinity: ControlAffinity.trailing,
                        ),
                      ),

                      //co-moribities   radio group yes no

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Co-Morbidities',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'comoribites',
                        onChanged: (onChanged) {

                          comor = onChanged.toString();

                          if (comor == 'Yes') {

                            showToast1(true);
                          } else if (comor == 'No') {

                            showToast1(false);
                            showtoastcomoribites(false);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((comrbits) => FormBuilderFieldOption(
                                  value: comrbits,
                                  child: Text(comrbits),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      ////dropdown comoribites
                      Visibility(
                        visible: _isVisibles,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Co-Morbidities",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Please select one or more options';
                            }
                            return null;
                          },
                          dataSource: const [
                            {
                              "display": "DM",
                              "value": "DM",
                            },
                            {
                              "display": "HTN",
                              "value": "HTN",
                            },
                            {
                              "display": "CKD",
                              "value": "CKD",
                            },
                            {
                              "display": "CAD",
                              "value": "CAD",
                            },
                            {
                              "display": "CVA",
                              "value": "CVA",
                            },
                            {
                              "display": "Br.Asthma",
                              "value": "Br.Asthma",
                            },
                            {
                              "display": "Thyroidism",
                              "value": "Thyroidism",
                            },
                            {
                              "display": "Anaemia",
                              "value": "Anaemia",
                            },
                            {
                              "display": "Others",
                              "value": "Others",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities,
                          onSaved: (value) {
                            if (value == 'Others') return;
                            setState(() {
                              _myActivities1 = value;
                            });
                            _myActivities1 = value;
                            if (_myActivities1?.length == 0) {
                              showtoastcomoribites(false);
                            } else if (_myActivities1!.contains("Others")) {
                              showtoastcomoribites(true);
                            } else {
                              showtoastcomoribites(false);
                            }
                          },
                        ),

                      ),

                      Visibility(
                        visible: _comoribitiesothers,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'comoribtesreason',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                rescomoribtesreason=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      ///radio  tubes and drainages
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Discharge with tubes and drainages',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'dwithtd',
                        onChanged: (onChanged) {
                           distubesdrains = onChanged.toString();

                          if (distubesdrains == "Yes") {
                            showToast2(true);
                          } else if (distubesdrains == "No") {
                            showToast2(false);
                            showtoasttubesdrainages(false);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      ////dropdown  discharge tubes and drainages
                      Visibility(
                        visible: _isVisible2,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Discharged with tubes and drainages",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          dataSource: const [
                            {
                              "display": "Ryles tube",
                              "value": "Ryles tube",
                            },
                            {
                              "display": "Urinary catheter ",
                              "value": "Urinary catheter ",
                            },
                            {
                              "display": "PCNL catheter",
                              "value": "PCNL catheter",
                            },
                            {
                              "display": "SPC catheter",
                              "value": "SPC catheter",
                            },
                            {
                              "display": "DJ Stent",
                              "value": "DJ Stent",
                            },
                            {
                              "display": "Drain Tubes",
                              "value": "Drain Tubes",
                            },
                            {
                              "display": "Others",
                              "value": "Others",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities2,
                          onSaved: (value) {
                            if (value == 'Others') return;
                            setState(() {
                              _myActivities2 = value;
                            });
                            _myActivities2 = value;
                            if (_myActivities2?.length == 0) {
                              showtoasttubesdrainages(false);
                            } else if (_myActivities2!.contains("Others")) {
                              showtoasttubesdrainages(true);
                            } else {
                              showtoasttubesdrainages(false);
                            }
                          },
                        ),
                      ),

                      /////textfield tubes drainages////

                      Visibility(
                        visible: _tubesdrainagesothers,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'tubesdrainagesreason',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                restubesdrainagesreason=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      ////radio osotomy/////

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Discharge with Ostomy',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'dwithosotomy',
                        onChanged: (onChanged) {
                           diswithosotomy = onChanged.toString();

                          if (diswithosotomy == "Yes") {
                            showToast3(true);
                          } else if(diswithosotomy =='No'){
                            showToast3(false);
                            showToastosotomy(false);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      /////////drop down osotomy

                      Visibility(
                        visible: _isVisible3,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Ostomy",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          dataSource: const [
                            {
                              "display": "Tracheostomy",
                              "value": "Tracheostomy",
                            },
                            {
                              "display": "Jejunostomy",
                              "value": "Jejunostomy",
                            },
                            {
                              "display": "Colostomy",
                              "value": "Colostomy",
                            },
                            {
                              "display": "Others",
                              "value": "Others",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities3,


                          onSaved: (value) {
                            if (value == 'Others') return;
                            setState(() {
                              _myActivities3 = value;
                            });
                            _myActivities3 = value;
                            if (_myActivities3?.length == 0) {
                              showToastosotomy(false);
                            } else if (_myActivities3!.contains("Others")) {
                              showToastosotomy(true);
                            } else {
                              showToastosotomy(false);
                            }
                          },
                        ),
                      ),

                      /////textfield osotomy
                      Visibility(
                        visible: _ostomyothers,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'osotomyreason',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                resosotomyreason=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      //Haid radio button
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Discharge with HAI',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'dwithhai',
                        onChanged: (onChanged) {
                           diswithhai = onChanged.toString();

                          if (diswithhai == "Yes") {
                            showToast4(true);
                          } else if(diswithhai =='No'){
                            showToast4(false);
                            showToasthaid(false);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //haid dropdown
                      Visibility(
                        visible: _isVisible4,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "HAI",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          dataSource: const [
                            {
                              "display": "Phlebhitis",
                              "value": "Phlebhitis",
                            },
                            {
                              "display": "Cauti",
                              "value": "Cauti",
                            },
                            {
                              "display": "SSI",
                              "value": "SSI",
                            },
                            {
                              "display": "VAP",
                              "value": "VAP",
                            },
                            {
                              "display": "Clabsi",
                              "value": "Clabsi",
                            },
                            {
                              "display": "Others",
                              "value": "Others",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities4,
                          onSaved: (value) {
                            if (value == 'Others') return;
                            setState(() {
                              _myActivities4 = value;
                            });
                            _myActivities4 = value;
                            if (_myActivities4?.length == 0) {
                              showToasthaid(false);
                            } else if (_myActivities4!.contains("Others")) {
                              showToasthaid(true);
                            } else {
                              showToasthaid(false);
                            }
                          },
                        ),
                      ),

                      //haid others reason

                      Visibility(
                        visible: _haidothers,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'haidreason',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                reshaidreason=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      //latrogenic yes no

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Discharge with Iatrogenic Injuries',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'dwithlatroinj',
                        onChanged: (onChanged) {
                           diswithlatinj = onChanged.toString();

                          if (diswithlatinj == "Yes") {
                            showToast5(true);
                          } else if(diswithlatinj=='No'){

                            showToast5(false);
                            showtoastlatrogenic(false);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      //latrogenic dropdown
                      Visibility(
                        visible: _isVisible5,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Iatrogenic Injuries",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          dataSource: const [
                            {
                              "display": "Pressure Injury",
                              "value": "Pressure Injury",
                            },
                            {
                              "display": "Ryles Tube",
                              "value": "Ryles Tube",
                            },
                            {
                              "display": "Plasters",
                              "value": "Plasters",
                            },
                            {
                              "display": "Masks",
                              "value": "Masks",
                            },
                            {
                              "display": "Stockings",
                              "value": "Stockings",
                            },
                            {
                              "display": "ECG Leads",
                              "value": "ECG Leads",
                            },
                            {
                              "display": "POP",
                              "value": "POP",
                            },
                            {
                              "display": "Others",
                              "value": "Others",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities5,
                          onSaved: (value) {
                            if (value == 'Others') return;
                            setState(() {
                              _myActivities5 = value;
                            });
                            _myActivities5 = value;
                            if (_myActivities5?.length == 0) {
                              showtoastlatrogenic(false);
                            } else if (_myActivities5!.contains("Others")) {
                              showtoastlatrogenic(true);
                            } else {
                              showtoastlatrogenic(false);
                            }
                          },
                        ),
                      ),

                      //latrogenic reason others

                      Visibility(
                        visible: _latrogenicothers,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'latrogenicreasons',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                reslatrogenicreasons=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      //cpmplications yes no
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Complications During Discharge',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'compdurdis',
                        onChanged: (onChanged) {
                           compduringdis = onChanged.toString();

                          if (compduringdis == "Yes") {
                            showToast6(true);
                          } else if(compduringdis=='No'){
                            showToast6(false);
                            showtoastcompdurdis(false);
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      ////complication dur discharge dropdown
                      Visibility(
                        visible: _isVisible6,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Complications",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          dataSource: const [
                            {
                              "display": "Anesthesia Related",
                              "value": "Anesthesia Related",
                            },
                            {
                              "display": "ADR/ADE",
                              "value": "ADR/ADE",
                            },
                            {
                              "display": "Sore Throat",
                              "value": "Sore Throat",
                            },
                            {
                              "display": "Hoarseness of voice",
                              "value": "Hoarseness of voice",
                            },
                            {
                              "display": "Others",
                              "value": "Others",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities6,
                          onSaved: (value) {
                            if (value == 'Others') return;
                            setState(() {
                              _myActivities6 = value;
                            });
                            _myActivities6 = value;
                            if (_myActivities6?.length == 0) {
                              showtoastcompdurdis(false);
                            } else if (_myActivities6!.contains("Others")) {
                              showtoastcompdurdis(true);
                            } else {
                              showtoastcompdurdis(false);
                            }
                          },
                        ),
                      ),

                      ///comp during dis reason
                      Visibility(
                        visible: _compduringdis,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'complicationdisreason',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                rescomplicationdisreason=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      ////Allergic


                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Allergic',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'allergic',
                        onChanged: (onChanged) {
                           allergy = onChanged.toString();

                          if (allergy == "Yes") {
                            showToast7(true);
                          } else if(allergy=='No') {
                            showToast7(false);

                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.notEqual(Null)
                        ]),
                        options: ['Yes', 'No']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      ////food////

                      Visibility(
                        visible: _isVisible7,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            name: 'Food',
                            decoration: const InputDecoration(
                                labelText: 'Food',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                resfood=val.toString();
                              });
                            },

                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      ////reaction
                      Visibility(
                        visible: _isVisible7,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(

                            name: 'Reaction',
                            decoration: const InputDecoration(
                                labelText: 'Reaction',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                resreaction=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(),
                            // ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      /////drug
                      Visibility(
                        visible: _isVisible7,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(

                            name: 'drug',
                            decoration: const InputDecoration(
                                labelText: 'Drug',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                resdrug=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(),
                            // ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      /////reaction

                      Visibility(
                        visible: _isVisible7,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(

                            name: 'drugReaction',
                            decoration: const InputDecoration(
                                labelText: 'Reaction',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                resdrugreaction =val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            // validator: FormBuilderValidators.compose([
                            //   FormBuilderValidators.required(),
                            // ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),

                      /////surgical site healed infected

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Surgical Site',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'surgicalsite',
                        onChanged: (onChanged) {
                           sursite = onChanged.toString();

                          if (sursite == "Infected") {
                            showToast8(true);
                          } else {
                            showToast8(false);
                          }
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Healed', 'Infected','NA']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      ///dropdown surgical site

                      Visibility(
                        visible: _isVisible8,
                        child: MultiSelectFormField(
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.deepPurple[600],
                          chipLabelStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.deepPurple[600],
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          title: const Text(
                            "Complaints",
                            style: TextStyle(
                                fontSize: 16,
                                backgroundColor:
                                    Color.fromARGB(255, 209, 199, 230)),
                          ),
                          dataSource: const [
                            {
                              "display": "Pain",
                              "value": "Pain",
                            },
                            {
                              "display": "Swelling",
                              "value": "Swelling",
                            },
                            {
                              "display": "Redness",
                              "value": "Redness",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          hintWidget: const Text('Please choose one or more'),
                          initialValue: _myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),

                      ////health edu given on yes no
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Health Education Given On',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'Healthedu',
                        onChanged: (onChanged) {
                          reshealthedu = onChanged.toString();

                          if (reshealthedu == "Yes") {
                            showToast9(true);
                          } else {
                            showToast9(false);
                          }
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Yes']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),
                      //Visibility(visible: _isVisible9, child: healedgivenon()),



        Visibility(
          visible: _isVisible9,
          child: MultiSelectFormField(
            autovalidate: AutovalidateMode.disabled,
            chipBackGroundColor: Colors.deepPurple[600],
            chipLabelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            checkBoxActiveColor: Colors.deepPurple[600],
            checkBoxCheckColor: Colors.white,
            dialogShapeBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: const Text(
              "Instructions",
              style: TextStyle(
                  fontSize: 16, backgroundColor: Color.fromARGB(255, 209, 199, 230)),
            ),

            dataSource: const [
              {
                "display": "Personal Hygiene",
                "value": "Personal Hygiene",
              },
              {
                "display": "Diet",
                "value": "Diet",
              },
              {
                "display": "Activities",
                "value": "Activities",
              },
              {
                "display": "Wound Care",
                "value": "Wound Care",
              },
              {
                "display": "Advice Medicine",
                "value": "Advice Medicine",
              },
              {
                "display": "Review follow up",
                "value": "Review follow up",
              },
            ],
            textField: 'display',
            valueField: 'value',
            okButtonLabel: 'OK',
            cancelButtonLabel: 'CANCEL',
            hintWidget: const Text('Please choose one or more'),
            initialValue: _myActivities8,
            onSaved: (value) {
              if (value == null) return;
              setState(() {
                _myActivities8 = value;
              });
            },
          ),
        ),
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Patient present diet',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'Patientpresentdiet',
                        onChanged: (_onChanged){
                          resPatientpresentdiet=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Normal', 'Liquid','Semisolid','Soft','Diabetic','Therapeutic']
                            .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),
                      // Bowelhabits(),
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Bowel Habits',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'bowelrhabbits',
                        onChanged: (_onChanged){
                          resbowelrhabbits=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Normal', 'Constipation','Loose Tools']
                            .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),

                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Bladder Habits',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'bladderhabbits',
                        onChanged: (_onChanged){
                          resbladderhabbits=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Normal', 'Retention','Incontinence']
                            .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),
                 //     Bladderhabits(),

                      Visibility(
                        visible: _bladderhabits,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: FormBuilderTextField(
                            autovalidateMode: AutovalidateMode.always,
                            name: 'Bladder reason',
                            decoration: const InputDecoration(
                                labelText: 'Type Reason',
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 199, 24, 164)),
                                border: OutlineInputBorder()),
                            onChanged: (val) {
                              setState(() {
                                resbladderreason=val.toString();
                              });
                            },
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            // initialValue: '12',
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                      FormBuilderRadioGroup<String>(
                        decoration: const InputDecoration(
                            labelText: 'Sleep',
                            labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 199, 24, 164))),
                        initialValue: null,
                        name: 'Sleep',
                        onChanged: (_onChanged){
                          ressleep=_onChanged.toString();
                        },
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        options: ['Normal', 'Disturbed']
                            .map((edulvlpat) => FormBuilderFieldOption(
                                  value: edulvlpat,
                                  child: Text(edulvlpat),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  debugPrint(_formKey.currentState?.value.toString());
                                  debugPrint('haisd');
                                 // debugPrint(respatmatsta+ressleep+resEdulvlpatient+resbladderreason+_myActivities7+resbladderhabbits+resustandinglevelpatient+respctname+ controller.usermobile+respctrelationship+resedulevelpct+resundlevelpct+reslanguagewanted+resdischargetype+psd+resambulantorbedridden+comor+_myActivities1+rescomoribtesreason+distubesdrains+_myActivities2+restubesdrainagesreason+diswithosotomy+_myActivities3+resosotomyreason+diswithhai+_myActivities4+reshaidreason+diswithlatinj+_myActivities5+reslatrogenicreasons+compduringdis+_myActivities6+rescomplicationdisreason+allergy+resfood+resreaction+resdrug+resdrugreaction+sursite+_myActivities+reshealthedu+_myActivities8+_myActivities10+resbowelrhabbits);
                               //   controller.providersignup(_formKey.currentState?.value.toString());

                                  controller.submitresult(respatmatsta,ressleep,resEdulvlpatient,resbladderreason,_myActivities7,resbladderhabbits,resustandinglevelpatient,respctname,usermobile,respctrelationship,resedulevelpct,resundlevelpct,rescontpdccall,reslanguagewanted,resdischargetype,psd,resambulantorbedridden,comor,_myActivities1,rescomoribtesreason,distubesdrains,_myActivities2,restubesdrainagesreason,diswithosotomy,_myActivities3,resosotomyreason,diswithhai,_myActivities4,reshaidreason,diswithlatinj,_myActivities5,reslatrogenicreasons,compduringdis,_myActivities6,rescomplicationdisreason,allergy,resfood,resreaction,resdrug,resdrugreaction,sursite,_myActivities,reshealthedu,_myActivities8,resPatientpresentdiet,resbowelrhabbits,uhid,patname,session,doctor_name,ip_no);
                                  print(_formKey.currentState?.runtimeType);
                                } else {
                                  debugPrint(_formKey.currentState?.value.toString());
                                  debugPrint('validation failed');
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),



                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void showToast1(bool bool) {
    setState(() {
      _isVisibles = bool;
    });
  }

  void showToast(bool bool) {
    setState(() {
      _isVisible = bool;
      print("mmmmm");
      print(_isVisible);
    });
  }

  void _decrementCounter() {
    setState(() async {
      final SharedPreferences prefs = await _prefs;
      prefs.clear();
      Get.offAll(const SignInScreen());
    });
  }

  void _onBackPressed() {
    /////////////////  Get.offAll(const QRViewExample());
  }
}




MultiSelectFormField Bowelhabits() {
  // ignore: no_leading_underscores_for_local_identifiers
  var _myActivities = [];
  return MultiSelectFormField(
    autovalidate: AutovalidateMode.disabled,
    chipBackGroundColor: Colors.deepPurple[600],
    chipLabelStyle:
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
    checkBoxActiveColor: Colors.deepPurple[600],
    checkBoxCheckColor: Colors.white,
    dialogShapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    title: const Text(
      "Bowel Habits",
      style: TextStyle(
        fontSize: 13,
        color: Color.fromARGB(255, 199, 24, 164),
      ),
    ),



    dataSource: const [
      {
        "display": "Normal",
        "value": "Normal",
      },
      {
        "display": "Constipation",
        "value": "Constipation",
      },
      {
        "display": "Loose Tools",
        "value": "Loose Tools",
      },
    ],
    textField: 'display',
    valueField: 'value',
    okButtonLabel: 'OK',
    cancelButtonLabel: 'CANCEL',
    hintWidget: const Text('Bowel Habits'),
    initialValue: _myActivities,

  );
}

MultiSelectFormField Bladderhabits() {
  // ignore: no_leading_underscores_for_local_identifiers
  var _myActivities = [];
  return MultiSelectFormField(
    autovalidate: AutovalidateMode.disabled,
    chipBackGroundColor: Colors.deepPurple[600],
    chipLabelStyle:
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
    checkBoxActiveColor: Colors.deepPurple[600],
    checkBoxCheckColor: Colors.white,
    dialogShapeBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0))),
    title: const Text("Bladder Habits",
        style: TextStyle(
          fontSize: 13,
          color: Color.fromARGB(255, 199, 24, 164),
        )
    ),
    dataSource: const [
      {
        "display": "Normal",
        "value": "Normal",
      },
      {
        "display": "Retention",
        "value": "Retention",
      },
      {
        "display": "Incontinence",
        "value": "Incontinence",
      },
      {
        "display": "Others",
        "value": "Others",
      },
    ],
    textField: 'display',
    valueField: 'value',
    okButtonLabel: 'OK',
    cancelButtonLabel: 'CANCEL',
    hintWidget: const Text('Bowel Habits'),
    initialValue: _myActivities,
  );
}
