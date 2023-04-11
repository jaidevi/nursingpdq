import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/login_controller.dart';
import 'sign_in_screen.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Barcode? result;
  QRViewController? controller;
  late String password,
      username,
      qrcodes,
      ip_no,
      uhid,
      patname,
      doctor_name,
      ward_name,
      sessions,
      bed_no='',
      primary_care_taker_no,
  axpapp,
  baseurl;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  LoginController _loginController = LoginController();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      password = (prefs.getString('password') ?? '');
      username = (prefs.getString('username') ?? '');
      sessions = (prefs.getString('sessionid') ?? '');
      baseurl=(prefs.getString('baseurl')??'');
      axpapp=(prefs.getString('axpapp')??'');
      print(password + " " + username + bed_no);
    });
  }

  @override
  void initState()
  {
    super.initState();
    _loadCounter();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
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
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text('Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}')
                  //Mycuswiget(),
                  else
                    const Text('Scan a code'),
                  // Mycuswiget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 173, 23, 143)),
                            ),
                            onPressed: () async {
                              //await controller?.toggleFlash();
                              setState(() async {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 173, 23, 143)),
                            ),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 173, 23, 143)),
                          ),
                          onPressed: () async {
                            FlutterBeep.playSysSound(
                                AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
                            await controller?.stopCamera();

                            if (result!.code == null) {
                              const Text('Scan a code');
                            } else {

                              _loginController.getqrresponse(
                                  name: username,
                                  pswd: password,
                                  axpapp:axpapp,
                                  baseurl:baseurl,
                                  qrcodes: result!.code,sessions:sessions);
                              // _loadCounterqr();

                            }
                          },
                          child: const Text('Submit QR',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // Mycuswiget() {}

  // ignore: non_constant_identifier_names

  void _decrementCounter() {
    setState(() async {
      final SharedPreferences prefs = await _prefs;
      prefs.clear();
      Get.offAll(const SignInScreen());
    });
  }
}
