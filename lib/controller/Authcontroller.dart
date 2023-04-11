// ignore: file_names
// ignore_for_file: non_constant_identifier_names
import 'dart:convert';




import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/api_endpoints.dart';




class Authcontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey0 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  // Future<void> getImage(ImageSource imageSource) async {
  //   // ignore: deprecated_member_use
  //   final PickedFile = await ImagePicker().getImage(source: imageSource);
  //   if (PickedFile != null) {
  //     selectedImagePath.value = PickedFile.path;
  //     // selectedImageSize.value =
  //     //     ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
  //     //         .toStringAsFixed();
  //     Get.snackbar('Error', 'No Image Selected',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.blue[400],
  //         colorText: Colors.white);
  //   }
  // }
  //  static ImagePickerController get to => ImagePickerController();

  String loginmobile = '';
  String userEmail = '';
  String userfrstName = '';
  String userlstName = '';
  String userPassword = '';
  String usermobile = '';
  String useraltrmobile = '';

  String companyname = '';
  String companyaddress = '';
  String countrystr = '';
  String statestr = '';
  String citystr = '';
  String pincodestr = '';
  String GSTnumber = '';

  String pancard = '';
  String Aadharnumber = '';
  String aadharmobile = '';
  String otpaadhar = '';
  String aadharname = '';
  String aadharagenumber = '';
  String Aadhargender = '';
  String Aadharaddress = '';

  String selectedValue = '';
  String selectedValue1 = '';
  String selectedValue2 = '';

  void onSelected(String value) {
    selectedValue = value;

    update();

    print(selectedValue);
    changeLanguage(selectedValue);
  }

  void onSelected1(String value) {
    selectedValue1 = value;

    update();

    print(selectedValue1);
    changeLanguage1(selectedValue1);
  }

  void onSelected2(String value) {
    selectedValue2 = value;

    //update();

    print(selectedValue2);
    changeImage(selectedValue2);
  }
  // RxString  userEmail= ''.obs;
  // RxString  userName= ''.obs;
  // RxString  userPassword= ''.obs;
  // RxString  usermobile= ''.obs;
  // RxString  pancard= ''.obs;
  // RxString  companyname= ''.obs;
  // RxString  companyaddress= ''.obs;
  // RxString  GSTnumber= ''.obs;

  String? userfrstNameValidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Username must be at least 4 characters long.';
    }
    return null;
  }

  String? userlstNameValidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Username must be at least 4 characters long.';
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? mobileValidator(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Mobile number must be 10 digits long.';
    }
    return null;
  }

  String? mobilealtrValidator(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Alternate Mobile number must be 10 digits long.';
    }
    return null;
  }

  String? pancardValidator(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Pancard number must be 10 digits long.';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty || value.length < 7) {
      return 'Password must be at least 7 characters long.';
    }
    return null;
  }

  String? Companynamevalidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Company Name must be at least 4 characters long.';
    }
    return null;
  }

  String? Companyaddressvalidator(String value) {
    if (value.isEmpty) {
      return 'company Address must not be empty';
    }
    return null;
  }

  String? countryvalidator(String value) {
    if (value.isEmpty) {
      return 'country Name must not be empty';
    }
    return null;
  }

  String? statevalidator(String value) {
    if (value.isEmpty) {
      return 'State Name must not be empty';
    }
    return null;
  }

  String? cityvalidator(String value) {
    if (value.isEmpty) {
      return 'City Name must not be empty';
    }
    return null;
  }

  String? pincodevalidator(String value) {
    if (value.isEmpty) {
      return 'pincode must not be empty';
    }
    return null;
  }

  String? Gstvalidator(String value) {
    if (value.isEmpty) {
      return 'GSTNumber must not be empty.';
    }
    return null;
  }

  String? aadharnumbervalidator(String value) {
    if (value.isEmpty || value.length < 12) {
      return 'Aadhar number must be at least 12 characters long.';
    }
    return null;
  }

  String? aadharmobilevalidator(String value) {
    if (value.isEmpty || value.length < 10) {
      return 'Mobilenumber must be at least 10 characters long.';
    }
    return null;
  }

  String? Otpaadharvalidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'otp must be at least 4 characters long.';
    }
    return null;
  }

  String? Aadharnamevalidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Aadharname must be at least 4 characters long.';
    }
    return null;
  }

  String? Aadharagevalidator(String value) {
    if (value.isEmpty) {
      return 'Aadharname must be at least 2 characters long.';
    }
    return null;
  }

  String? Aadhargendervalidator(String value) {
    if (value.isEmpty) {
      return 'Aadhar gender must not empty';
    }
    return null;
  }

  String? Aadharaddressvalidator(String value) {
    if (value.isEmpty) {
      return 'Aadhar Address must not empty';
    }
    return null;
  }

  void trySubmit() {
    final isValid1 = formKey.currentState!.validate();
    final isValid2 = formKey1.currentState!.validate();
    final isValid3 = formKey2.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isValid1) {
      formKey.currentState!.save();
    } else {}
    if (isValid2) {
      formKey1.currentState!.save();
      print("ggggggg");
      print(GSTnumber);
    }
    if (isValid3) {
      formKey2.currentState!.save();
    }
  }

  changeLanguage(String selectedLanguage) {
    switch (selectedLanguage) {
      case 'aadharcard':
        Get.updateLocale(const Locale('aadharcard'));
        print('Changed to En');
        break;
      case 'pancard':
        Get.updateLocale(const Locale('pancard'));
        print('Changed to Es');
        break;

      case 'voterid':
        Get.updateLocale(const Locale('voterid'));
        print('Changed to Es');
        break;
      case 'drivinglicense':
        Get.updateLocale(const Locale('drivinglicense'));
        print('Changed to Es');
        break;
      default:
        Get.updateLocale(const Locale('aadharcard'));
        print('Fallback to En');
        break;
    }
  }

  changeLanguage1(String selectedLanguage1) {
    switch (selectedLanguage1) {
      case 'tanker':
        Get.updateLocale(const Locale('Tanker'));
        print('Changed to En');
        break;
      case 'cans':
        Get.updateLocale(const Locale('cans'));
        print('Changed to Es');
        break;
      default:
        Get.updateLocale(const Locale('Tanker'));
        print('Fallback to En');
        break;
    }
  }

  changeImage(String? selectedImage1) {
    switch (selectedImage1) {
      case 'camera':
        Get.updateLocale(const Locale('camera'));
        print('Changed to pn');
        break;
      case 'gallery':
        Get.updateLocale(const Locale('gallery'));
        print('Changed to ln');
        break;
      default:
        Get.updateLocale(const Locale('camera'));
        print('Fallback to sn');
        break;
    }
  }

  Future<void> providersignup(Map<String, dynamic> formdata
   // required String patmaritalstatus,
   // required String Edulvlpatient,
   // required String myActivitiesResult,
    // required String AltrMobile,
    // required String companyname,
    // required String companyaddress,
    // required String Email,
    // required String countrystr,
    // required String citystr,
    // required String statestr,
    // required String pincodestr,
    // required String GSTnumber,
    // required String Profile_image,
    // required String id_type,
    // required String id_image,
    // required String company_image,
    // required String provider_type,
    // required String device_token,
    // required String aadhar_verification,
    // required String aadhar_number,
    // required String password,
    // required String has_drivers,
    // required String role_id,
    // required String is_verified,
    // required String status,
    // required String pan_number,
   ) async {
    final response = await post(
      Uri.parse('https://kmc-ds.rathnacorp.com/api/v1/store-pdqform'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "name": "patmaritalstatus",
        "description": "Edulvlpatient",
      //  "fields": ["1","field1"],

        // "alternate_mobile": AltrMobile,
        // "company_name": companyname,
        // "company_address": companyaddress,
        // "email": Email,
        // "city": citystr,
        // "state": statestr,
        // "pincode": pincodestr,
        // "gst_number": GSTnumber,
        // "pan_number": pan_number,
        // "profile_image": Profile_image,
        // "id_type": id_type,
        // "id_image": id_image,
        // "company_image": company_image,
        // "provider_type": provider_type,
        // "device_token": "hdfjsldfjsdgyjg7876",
        // "aadhar_verification": aadhar_verification,
        // "aadhar_number": aadhar_number,
        // "password": password,
        // "has_drivers": has_drivers,
        // "role_id": role_id,
        // "is_verified": is_verified,
        // "status": status
      }),
     
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // return List.fromJson(jsonDecode(response.body));
      print("wwwww");
   //////////////////////////   Get.offAll(() => Dashboard());
      print(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<void> providersignin({
    required String mobile,
    required String password,
  }) async {
    final response = await post(
      Uri.parse('http://192.168.1.18:8080/api/provider/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "mobile": mobile,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // return List.fromJson(jsonDecode(response.body));
      print("wwwww22");
     ///////////////////Get.to(() => const hai());
      print(response.body);
    } else 
    {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<void> providersignin1({required String patientmarstares}) async {
    
  }

  providersignin6(List schema) async {

  }

 

  Future<void> providersignin8( {required patientmarstares}) async {
 final response = await post(
      Uri.parse(ApiEndPoints.mybaseurl + ApiEndPoints.authEndpoints.storepdqform),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "form_id": "91",
    "submitted_by": "11",
	"submitted_data": "{"
          "patientName"+":"+patientmarstares+
  "}"
 
        
        
      }),
      
    );
print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // return List.fromJson(jsonDecode(response.body));
      print("wwwww22");
     ///////////////////Get.to(() => const hai());
      print(response.body);
    } else 
    {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

 

//  Future<void> providersignin1(int patmarsta, int patmarsta, {
//     required String mobile,
//     required String password,
//   }) async {
//     final response = await post(
//       Uri.parse('http://192.168.1.18:8080/api/provider/signin'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         "mobile": mobile,
//         "password": password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // If the server did return a 201 CREATED response,
//       // then parse the JSON.
//       // return List.fromJson(jsonDecode(response.body));
//       print("wwwww22");
//      ///////////////////Get.to(() => const hai());
//       print(response.body);
//     } else 
//     {
//       // If the server did not return a 201 CREATED response,
//       // then throw an exception.
//       throw Exception('Failed to create album.');
//     }
//   }

}
