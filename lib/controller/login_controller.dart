import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../pdqdatagetting.dart';

import '../qrcode.dart';
import '../utils/api_endpoints.dart';



class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey0 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController selectedSalutation = TextEditingController();
  String companyname = '';
  String usermobile = '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void loginWithEmails(
      {required name, required pswd, required unitselect,required axpapp,required baseurl}) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
         baseurl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        "_parameters": [
          {
            "login": {
              "axpapp": axpapp,
              "username": name,
              "password": pswd,
              "seed": "",
              "other": "Chrome"
            }
          }
        ]
      };
      print("haiiiii");
      print(url);
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        final List<dynamic> jobs = json['result'];
        print("fsjdfjhsdfjs");
        print(jobs[0]['error']);
        print("jjjjjjj");
        if (jobs[0]['error'].toString() == "null") {
          final Map<String, dynamic> joby1 = jobs.first['result'];
          final String statusapi = joby1['status'];
            // final String sessionid = joby1['s'];
          final String username = joby1['USERNAME'];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', statusapi);
          await prefs.setString('username', username);
          await prefs.setString('password', pswd);
          await prefs.setString('session',unitselect);
          await prefs.setString('axpapp',axpapp);
          await prefs.setString('baseurl',baseurl);

          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text(statusapi),
                  contentPadding: const EdgeInsets.all(20),
                  children: [Text(statusapi.toString())],
                );
              });
         
          Get.off(const QRViewExample());
        } else if (jobs[0]['error']['status'] == 'Failed') {
          final Map<String, dynamic> joby = jobs.first['error'];
          final String jobTitle = joby['status'];
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text(jobTitle),
                  contentPadding: const EdgeInsets.all(20),
                  children: [Text(jobTitle.toString())],
                );
              });
        }
      }
    }
    catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  String? Companynamevalidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Company Name must be at least 4 characters long.';
    }
    return null;
  }
  String? mobileValidator(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Mobile number must be 10 digits long.';
    }
    return null;
  }
  void getqrresponse({required name, required pswd,required axpapp,required baseurl, String? qrcodes, required sessions}) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          baseurl + ApiEndPoints.authEndpoints.qrcodegenerate);

      Map body = {
        "_parameters": [
          {
            "getchoices": {
              "name": "pdcinv",
              "axpapp": axpapp,
              "username": name,
              "password": pswd,
              "s": "",
              "sql":
                  "Select  ip.Ip_no,ip.uhid,ip.WARD_PATIENTNAME patname,cd.DOCTOR_NAME,cd.DOCTOR_SHRT Doctor_shortName,cw.WARD_NAME,cb.BED_NO,ip.attender_name  primary_care_taker,ip.CONTACT_NO primary_care_taker_no , case when ip.is_vip = 'T'  then 'VIP' else '' end is_vip from ip_admission ip join REGISTRATION r on r.uhid=ip.uhid join cm_ward cw on cw.CM_WARDID=ip.ward join cm_bed cb on cb.CM_BEDID=ip.BED_NO join cm_doctor cd on cd.cm_doctorid=ip.ATTENDING_PHYSICIAN join CM_SPECIALITY cs on cs.CM_SPECIALITYID=cd.SPECIALTY left join MG_PARTYHDR mp on mp.MG_PARTYHDRID=ip.COMPANY_name join cm_casetype cat on cat.cm_casetypeid=ip.case_type where  ip.ip_no ='" +
                      qrcodes! +
                      "' and ip.cancel='F'"
            }
          }
        ]
      };

      print(body);
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        final List<dynamic> jobs = json['result'];
        print("fsjdfjhsdfjs");
        print(jobs[0]['error']);
        print("jjjjjjj");
        if (jobs[0]['error'].toString() == "null") {
          final Map<String, dynamic> joby1 = jobs.first['result'];
          print(joby1);
          final List<dynamic> joby2 = joby1['row'];
          //   final Map<String, dynamic> joby3 = joby2.first['ip_no'];

          final String ipNo = joby2[0]['ip_no'];
          final String uhid = joby2[0]['uhid'];
          final String patname = joby2[0]['patname'];
          final String doctorName = joby2[0]['doctor_shortname'];
          final String wardName = joby2[0]['ward_name'];
          final String bedNo = joby2[0]['bed_no'];
          final String primaryCareTakerNo = joby2[0]['primary_care_taker_no'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('ip_no', ipNo);
          await prefs.setString('uhid', uhid);
          await prefs.setString('patname', patname);
          await prefs.setString('doctor_name', doctorName);
          await prefs.setString('ward_name', wardName);
          await prefs.setString('bed_no', bedNo);
          await prefs.setString('primary_care_taker_no', primaryCareTakerNo);
          print(ipNo);
          print(joby2);
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text(ipNo),
                  contentPadding: const EdgeInsets.all(20),
                  children: [Text(ipNo.toString())],
                );
              });
          // emailController.clear();
          // passwordController.clear();
          // Get.off(const CompleteForm());
          Get.off(() => qrdatagetting());
        } else if (jobs[0]['error']['status'] == 'Failed') {
          final Map<String, dynamic> joby = jobs.first['error'];
          final String jobTitle = joby['status'];
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: Text(jobTitle),
                  contentPadding: const EdgeInsets.all(20),
                  children: [Text(jobTitle.toString())],
                );
              });
        }
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }

  void loginWithEmails2({
    required names, String? ip_nos, String? pctnumbers, String? primary_care_taker_nos, String? uhids,
  }) async {
    var headers = {'Content-Type': 'application/json'};
    // try {
    //   var url = Uri.parse(
    //       ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
    //   Map body = {
    //     "_parameters": [
    //       {
    //         "login": {
    //           "axpapp": "hmstest",
    //           "username": name,
    //           "password": "a5aed24e2169a4c8f717ecc1142104c7",
    //           "seed": "1983",
    //           "other": "Chrome"
    //         }
    //       }
    //     ]
    //   };
    //   print(body);
    //   http.Response response =
    //       await http.post(url, body: jsonEncode(body), headers: headers);

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> json = jsonDecode(response.body);

    //     final List<dynamic> jobs = json['result'];
    //     print("fsjdfjhsdfjs");
    //     print(jobs[0]['error']);
    //     print("jjjjjjj");
    //     if (jobs[0]['error'].toString() == "null") {
    //       final Map<String, dynamic> joby1 = jobs.first['result'];
    //       final String statusapi = joby1['status'];
    //       final String username = joby1['USERNAME'];
    //       print("usernamessssssss");
    //       print(username);
    //       final SharedPreferences prefs = await _prefs;
    //       await prefs.setString('token', statusapi);
    //       await prefs.setString('username', username);
    //       await prefs.setString('password', "a5aed24e2169a4c8f717ecc1142104c7");
    //       showDialog(
    //           context: Get.context!,
    //           builder: (context) {
    //             return SimpleDialog(
    //               title: Text(statusapi),
    //               contentPadding: const EdgeInsets.all(20),
    //               children: [Text(statusapi.toString())],
    //             );
    //           });
    //       emailController.clear();
    //       passwordController.clear();
    //       Get.off(const QRViewExample());
    //     } else if (jobs[0]['error']['status'] == 'Failed') {
    //       final Map<String, dynamic> joby = jobs.first['error'];
    //       final String jobTitle = joby['status'];
    //       showDialog(
    //           context: Get.context!,
    //           builder: (context) {
    //             return SimpleDialog(
    //               title: Text(jobTitle),
    //               contentPadding: const EdgeInsets.all(20),
    //               children: [Text(jobTitle.toString())],
    //             );
    //           });
    //     }
    //   }
    // } catch (error) {
    //   Get.back();
    //   showDialog(
    //       context: Get.context!,
    //       builder: (context) {
    //         return SimpleDialog(
    //           title: const Text('Error'),
    //           contentPadding: const EdgeInsets.all(20),
    //           children: [Text(error.toString())],
    //         );
    //       });
    // }
  }

  Future<void> providersignup(formdata) async {
var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.mybaseurl + ApiEndPoints.authEndpoints.storepdqform);
      Map body = 
        {
            "form_id":"1",
            "submitted_by":"22",
            "submitted_data":formdata,
        };
      print(body);
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        print("haiiiii");
        print(response.body);
        print("haiiiii123");
        final Map<String, dynamic> json = jsonDecode(response.body);
           print(json);
           final String statusapi = json['message'];
        Get.off(const QRViewExample());
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  contentPadding: const EdgeInsets.all(20),
                  children: [Text(statusapi.toString())],
                );
              });
               
        // }
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });

    }
  }

  Future<void> submitresult(String? respatmatsta,
      String? ressleep,
      String? resEdulvlpatient,
      String? resbladderreason,
      List? myActivities7,
      String? resbladderhabbits,
      String? resustandinglevelpatient,
      String? respctname,
      String?  usermobile,
      String? respctrelationship,
      String? resedulevelpct,
      String? resundlevelpct,
      String? rescontpdccall,
      String? reslanguagewanted,
      String? resdischargetype,
      String? psd,
      String? resambulantorbedridden,
      String? comor,
      List? myActivities1,
      String? rescomoribtesreason,
      String? distubesdrains,
      List? myActivities2,
      String? restubesdrainagesreason,
      String? diswithosotomy,
      List? myActivities3,
      String? resosotomyreason,
      String? diswithhai,
      List? myActivities4,
      String? reshaidreason,
      String? diswithlatinj,
      List? myActivities5,
      String? reslatrogenicreasons,
      String? compduringdis,
      List? myActivities6,
      String? rescomplicationdisreason,
      String? allergy,
      String? resfood,
      String? resreaction,
      String? resdrug,
      String? resdrugreaction,
      String? sursite,
      List? myActivities,
      String? reshealthedu,
      List? myActivities8,
      String? myActivities10,
      String? resbowelrhabbits,
      String uhid,
      String patname,
      String session,
      String doctor_name,
      String ip_no)async
  {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.mybaseurl + ApiEndPoints.authEndpoints.storepdqform);
      Map body =
      {
        "form_id":"1",
        "submitted_by":"22",
        "submitted_data":{
          "patientMaritalstatus":respatmatsta,
          "resultsleep":ressleep,
          "resEdulvlpatient":resEdulvlpatient,
          "resbladderreason":resbladderreason,
          "Bladderhabits":myActivities7,
          "Reasonbladderhabbits":resbladderhabbits,
          "resustandinglevelpatient":resustandinglevelpatient,
          "respctname":respctname,
          "usermobile":usermobile,
          "respctrelationship":respctrelationship,
          "resedulevelpct":resedulevelpct,
          "resundlevelpct":resundlevelpct,
          "rescontpdccall":rescontpdccall,
          "reslanguagewanted":reslanguagewanted,
          "resdischargetype":resdischargetype,
          "psd":psd,
          "resambulantorbedridden":resambulantorbedridden,
          "comor":comor,
          "Co-Morbidities":myActivities1,
          "rescomoribtesreason":rescomoribtesreason,
          "distubesdrains":distubesdrains,
          "Discharged-with-tubes-and-drainages":myActivities2,
          "restubesdrainagesreason":restubesdrainagesreason,
          "diswithosotomy":diswithosotomy,
          "Ostomy":myActivities3,
          "resosotomyreason":resosotomyreason,
          "diswithhai":diswithhai,
          "HAI":myActivities4,
          "reshaidreason":reshaidreason,
          "diswithlatinj":diswithlatinj,
          "IatrogenicInjuries":myActivities5,
          "reslatrogenicreasons":reslatrogenicreasons,
          "compduringdis":compduringdis,
          "Complications":myActivities6,
          "rescomplicationdisreason":rescomplicationdisreason,
          "compduringdis":compduringdis,

          "rescomplicationdisreason":rescomplicationdisreason,
          "allergy":allergy,
          "resfood":resfood,
          "resreaction":resreaction,
          "resdrug":resdrug,
          "resdrugreaction":resdrugreaction,
          "sursite":sursite,
          "Complaints":myActivities,
          "reshealthedu":reshealthedu,
          "Instructions":myActivities8,
          "patientpresentdiet":myActivities10,
          "resbowelrhabbits":resbowelrhabbits
        },
        "unit_name":session,
        "patient_ip_no":ip_no,
        "patient_meta":{
          "first_name":patname,
          "whatsapp_no":doctor_name,
        }

      };
      print(body);
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        print("haiiiii");
        print(response.body);
        print("haiiiii");
        final Map<String, dynamic> json = jsonDecode(response.body);
        print(json);
        final String statusapi = json['message'];
        Get.off(const QRViewExample());
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                contentPadding: const EdgeInsets.all(20),
                children: [Text(statusapi.toString())],
              );
            });

        // }
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });

    }
  }
}
