// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:usb_serial/transaction.dart';
// import 'package:usb_serial/usb_serial.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   UsbPort? _port;
//   String _status = "Idle";
//   List<Widget> _ports = [];
//   List<Widget> _serialData = [];
//   double myValue = 0;
//   List<String> _debugMessages = [];
//
//   StreamSubscription<String>? _subscription;
//   Transaction<String>? _transaction;
//   UsbDevice? _device;
//
//   Future<bool> _connectTo(device) async {
//     _serialData.clear();
//
//     setState(() {
//       _debugMessages.add("Connecting to device: $device");
//     });
//
//     if (_subscription != null) {
//       _subscription!.cancel();
//       _subscription = null;
//     }
//
//     if (_transaction != null) {
//       _transaction!.dispose();
//       _transaction = null;
//     }
//
//     if (_port != null) {
//       _port!.close();
//       _port = null;
//     }
//
//     if (device == null) {
//       _device = null;
//       setState(() {
//         _status = "Disconnected";
//       });
//       return true;
//     }
//
//     _port = await device.create();
//     if (await (_port!.open()) != true) {
//       setState(() {
//         _status = "Failed to open port";
//       });
//       return false;
//     }
//
//     _device = device;
//     setState(() {
//       _debugMessages.add("Device: $_device");
//     });
//
//     await _port!.setDTR(true);
//     await _port!.setRTS(true);
//     await _port!.setPortParameters(
//         115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);
//
//     _transaction = Transaction.stringTerminated(
//         _port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));
//
//     _subscription = _transaction!.stream.listen((String line) {
//       setState(() {
//         _serialData.clear();
//         _serialData.add(Text(
//           line + "CM",
//           style: TextStyle(
//               fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
//         ));
//
//         myValue = double.parse(line);
//       });
//     });
//
//     setState(() {
//       _status = "Connected";
//     });
//     return true;
//   }
//
//   void _getPorts() async {
//     _ports = [];
//     List<UsbDevice> devices = await UsbSerial.listDevices();
//     print("Devices: $devices");
//
//     devices.forEach((device) {
//       _ports.add(ListTile(
//           leading: Icon(Icons.usb),
//           title: Text(device.productName ?? 'Unknown product name'),
//           subtitle: Text(device.manufacturerName ?? 'Unknown manufacturer name'),
//           trailing: ElevatedButton(
//             child: Text(_device == device ? "Disconnect" : "Connect"),
//             onPressed: () {
//               _connectTo(device).then((res) {
//                 _getPorts();
//               });
//             },
//           )));
//     });
//
//     setState(() {
//       print("Ports: $_ports");
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     UsbSerial.usbEventStream!.listen((UsbEvent event) {
//       _getPorts();
//     });
//     _getPorts();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _connectTo(null);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('HC SR04 Distance'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               SfRadialGauge(
//                 axes: <RadialAxis>[
//                   RadialAxis(
//                     axisLineStyle: AxisLineStyle(color: Colors.blue),
//                     minimum: 0,
//                     maximum: 200,
//                     pointers: <GaugePointer>[
//                       NeedlePointer(value: myValue),
//                     ],
//                   ),
//                 ],
//               ),
//               ..._serialData,
//               ..._ports,
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _debugMessages.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_debugMessages[index]),
//                     );
//                   },
//                 ),
//               ),
//               Card(
//                 child: Text(
//                   'https://diyusthad.com',
//                   style: TextStyle(color: Colors.yellow.shade700),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:usb_serial/transaction.dart';
// import 'package:usb_serial/usb_serial.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   UsbPort? _port;
//   String _status = "Idle";
//   List<Widget> _ports = [];
//   double myValue = 0;
//   List<String> _debugMessages = [];
//
//   StreamSubscription<Uint8List>? _subscription;
//   Transaction<Uint8List>? _transaction;
//   UsbDevice? _device;
//
//   Future<bool> _connectTo(device) async {
//     _debugMessages.clear();
//
//     setState(() {
//       _debugMessages.add("Connecting to device: $device");
//     });
//
//     if (_subscription != null) {
//       _subscription!.cancel();
//       _subscription = null;
//     }
//
//     if (_transaction != null) {
//       _transaction!.dispose();
//       _transaction = null;
//     }
//
//     if (_port != null) {
//       _port!.close();
//       _port = null;
//     }
//
//     if (device == null) {
//       _device = null;
//       setState(() {
//         _status = "Disconnected";
//       });
//       return true;
//     }
//
//     _port = await device.create();
//     if (await (_port!.open()) != true) {
//       setState(() {
//         _status = "Failed to open port";
//       });
//       return false;
//     }
//
//     _device = device;
//     setState(() {
//       _debugMessages.add("Device: $_device");
//     });
//
//     await _port!.setDTR(true);
//     await _port!.setRTS(true);
//     await _port!.setPortParameters(
//         115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);
//
//     if (_port != null && _port!.inputStream != null) {
//       _transaction = Transaction.terminated(
//           _port!.inputStream!, Uint8List.fromList([0xFF, 0xFF, 0xFF, 0xFF]));
//     }
//
//
//     _subscription = _transaction!.stream.listen((Uint8List data) {
//       if(data.length >= 1) {
//         int msgType = data[0];
//         if(msgType == 1) {  // 1 refers to MCU_RESPONSE_MSG
//           int activeState = data[1];
//           setState(() {
//             myValue = activeState.toDouble();
//           });
//         }
//       }
//     });
//
//     setState(() {
//       _status = "Connected";
//     });
//     return true;
//   }
//
//   void _getPorts() async {
//     _ports = [];
//     List<UsbDevice> devices = await UsbSerial.listDevices();
//     print("Devices: $devices");
//
//     devices.forEach((device) {
//       _ports.add(ListTile(
//           leading: Icon(Icons.usb),
//           title: Text(device.productName ?? 'Unknown product name'),
//           subtitle: Text(device.manufacturerName ?? 'Unknown manufacturer name'),
//           trailing: ElevatedButton(
//             child: Text(_device == device ? "Disconnect" : "Connect"),
//             onPressed: () {
//               _connectTo(device).then((res) {
//                 _getPorts();
//               });
//             },
//           )));
//     });
//
//     setState(() {
//       print("Ports: $_ports");
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     UsbSerial.usbEventStream!.listen((UsbEvent event) {
//       _getPorts();
//     });
//     _getPorts();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _connectTo(null);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('HC SR04 Distance'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               SfRadialGauge(
//                 axes: <RadialAxis>[
//                   RadialAxis(
//                     axisLineStyle: AxisLineStyle(color: Colors.blue),
//                     minimum: 0,
//                     maximum: 200,
//                     pointers: <GaugePointer>[
//                       NeedlePointer(value: myValue),
//                     ],
//                   ),
//                 ],
//               ),
//               ..._ports,
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _debugMessages.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_debugMessages[index]),
//                     );
//                   },
//                 ),
//               ),
//               Card(
//                 child: Text(
//                   'https://diyusthad.com',
//                   style: TextStyle(color: Colors.yellow.shade700),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UsbPort? _port;
  String _status = "Idle";
  List<Widget> _ports = [];
  List<String> _debugMessages = [];
  List<String> _receivedMessages = [];  // List for received messages

  StreamSubscription<Uint8List>? _subscription;
  Transaction<Uint8List>? _transaction;
  UsbDevice? _device;

  int currentState = 0;
  double speedValue = 0.0;
  double speedFactor = 1.0;

  static const int MCU_RESPONSE_MSG = 1;


  // New method to process received messages
  void _processReceivedMessage(Uint8List data) {
    if (data.length >= 5) {
      int motorTemperature = data[0];
      int electricalCurrent = data[1];
      int actualRopeSpeed = data[2];
      int currentState = data[3];
      int checksum = data[4];  // Assuming the 5th byte is the checksum

      // You can add more processing logic here if required.

      _receivedMessages.add('Motor Temp: $motorTemperature');
      _receivedMessages.add('Electrical Current: $electricalCurrent');
      _receivedMessages.add('Actual Rope Speed: $actualRopeSpeed');
      _receivedMessages.add('Current State: $currentState');
    }
  }




  Future<bool> _connectTo(device) async {
    _debugMessages.clear();

    setState(() {
      _debugMessages.add("Connecting to device: $device");
    });

    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction!.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port!.close();
      _port = null;
    }

    if (device == null) {
      _device = null;
      setState(() {
        _status = "Disconnected";
      });
      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }

    _device = device;
    setState(() {
      _debugMessages.add("Device: $_device");
    });

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    if (_port != null && _port!.inputStream != null) {
      setState(() {
        _debugMessages.add("Input Stream: ${_port!.inputStream}");
      });
      setState(() {
        _debugMessages.add("Input Stream is not null");
      });
      setState(() {
        _debugMessages.add("Listening...");
      });
      _transaction = Transaction.terminated(
          _port!.inputStream!, Uint8List.fromList([0xFF, 0xFF, 0xFF, 0xFF]));
      setState(() {
        _debugMessages.add("Transaction: $_transaction");
      });
    }

    _subscription = _transaction!.stream.listen(
            (Uint8List data) {
          setState(() {
            _debugMessages.add("Message: $data");
            _processReceivedMessage(data);  // Process the received data
          });
        },
        onError: (error) {
          setState(() {
            _debugMessages.add("Error receiving message: $error");
          });
        },

    );
    setState(() {
      _debugMessages.add("Subscription: $_subscription");
    });
    setState(() {
      _status = "Connected";
    });
    requestActiveStateAndInitialSpeed(); // Request for active state and initial speed after connection is established
    return true;
  }

  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    print("Devices: $devices");

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: Icon(Icons.usb),
          title: Text(device.productName ?? 'Unknown product name'),
          subtitle: Text(device.manufacturerName ?? 'Unknown manufacturer name'),
          trailing: ElevatedButton(
            child: Text(_device == device ? "Disconnect" : "Connect"),
            onPressed: () {
              _connectTo(device).then((res) {
                _getPorts();
              });
            },
          )));
    });

    setState(() {
      print("Ports: $_ports");
    });
  }

  void requestActiveStateAndInitialSpeed() {
    double speed = 1.2;
    List<int> message = [0x4D, 0x10, (speed * 10).toInt()];
    setState(() {
      _debugMessages.add("Device: $message");
    });
    _port?.write(Uint8List.fromList(message));
  }

  // Modified _sendMessageToMachine method
  void _sendMessageToMachine(int msgType, int state, double speed) {
    try {
      int motorTemperature = 50;  // Replace with actual value
      int electricalCurrent = 200;  // Replace with actual value
      int actualRopeSpeed = 100;  // Replace with actual value
      int checksum = msgType ^ state ^ motorTemperature ^ electricalCurrent ^ actualRopeSpeed; // Assuming XOR for checksum calculation

      _port?.write(Uint8List.fromList([msgType, state, motorTemperature, electricalCurrent, actualRopeSpeed, checksum]));
    } catch (e) {
      _debugMessages.add("Error: $e");
    }
    _saveSpeedValue();
  }



  @override
  void initState() {
    super.initState();
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _getPorts();
    });
    _getPorts();
    _loadSpeedValue();
  }

  @override
  void dispose() {
    super.dispose();
    _connectTo(null);
  }

  Future<void> _saveSpeedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('speedValue', speedValue);
  }

  Future<void> _loadSpeedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? value = prefs.getDouble('speedValue');
    if (value != null) {
      setState(() {
        speedValue = value;
      });
    }
  }

  // void _sendMessageToMachine(int msgType, int state, double speed) {
  //   try {
  //     // Sending the values for motorTemperature, electricalCurrent, actualRopeSpeed, currentState as part of the message
  //     _port?.write(Uint8List.fromList([msgType, state, 50, 200, 100, 1])); // replace 50, 200, 100, 1 with the actual values
  //   } catch (e) {
  //     _debugMessages.add("Error: $e");
  //   }
  //   _saveSpeedValue();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rope Climber Machine'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 200,
                    pointers: <GaugePointer>[
                      NeedlePointer(value: speedValue),
                    ],
                  ),
                ],
              ),
              Container(
                color: Colors.green,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: ListView.builder(
                    itemCount: _receivedMessages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_receivedMessages[index]),
                      );
                    },
                  ),
                ),
              ),
              Text(
                "Current Speed: ${speedValue.toStringAsFixed(2)}", // Display the current speed
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                child: Text("Start"),
                onPressed: () {
                  _sendMessageToMachine(MCU_RESPONSE_MSG, 1, speedValue);
                  Future.delayed(Duration(milliseconds: 500), () {
                    requestActiveStateAndInitialSpeed();
                  });
                },
              ),

              ElevatedButton(
                child: Text("Stop"),
                onPressed: () {
                  _sendMessageToMachine(MCU_RESPONSE_MSG, 2, 0); // 2 for STOP state, speed zero
                },
              ),
              ElevatedButton(
                child: Text("Increase Speed"),
                onPressed: () {
                  speedFactor += 0.1;
                  speedValue *= speedFactor;  // Adjust speedValue
                  _sendMessageToMachine(MCU_RESPONSE_MSG, 1, speedValue); // increase speed by 10%
                },
              ),
              ElevatedButton(
                child: Text("Decrease Speed"),
                onPressed: () {
                  speedFactor -= 0.1;
                  if (speedFactor < 0) speedFactor = 0; // prevent it from becoming negative
                  speedValue *= speedFactor;  // Adjust speedValue
                  _sendMessageToMachine(MCU_RESPONSE_MSG, 1, speedValue); // decrease speed by 10%
                },
              ),
              ..._ports,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  itemCount: _debugMessages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_debugMessages[index]),
                    );
                  },
                ),
              ),
              // ListView for received messages
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  itemCount: _receivedMessages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_receivedMessages[index]),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// _subscription = _transaction!.stream.listen((Uint8List data) {
//   if (data != null && data.length > 0) {
//     var byteData = ByteData.sublistView(data);
//     int startByte = byteData.getUint8(0);
//
//     setState(() {
//       _debugMessages.add("Message: $data");
//     });
//
//     if (startByte == 77) {
//       String message = "Received Active State and Speed Data from Arduino";
//       setState(() {
//         _receivedMessages.add(message);
//       });
//
//     } else if (startByte == 77) { // Corresponds to 'M' - The START_WORD
//       int msgType = byteData.getUint8(1);
//       if (msgType == MCU_RESPONSE_MSG) {
//         int activeState = byteData.getUint8(2);
//         int healthState1 = byteData.getUint8(3);
//         int healthState2 = byteData.getUint8(4);
//         int healthState3 = byteData.getUint8(5);
//         int healthState4 = byteData.getUint8(6);
//         int motorTemperature = byteData.getUint8(7);
//         int electricalCurrent = byteData.getUint16(8);
//         int requestedRopeSpeed = byteData.getUint8(10);
//         int actualRopeSpeed = byteData.getUint8(11);
//         int weightOnRope = byteData.getUint8(12);
//         int strokesSpeed = byteData.getUint8(13);
//         int activeStrokeNow = byteData.getUint8(14);
//         int currentSetDistance = byteData.getUint16(15);
//         int setID = byteData.getUint32(17);
//         int requestForSetReceived = byteData.getUint32(21);
//         int currentState = byteData.getUint8(25);
//         int checkSum = byteData.getUint32(26);
//
//         String message = "Motor Temperature: $motorTemperature, Electrical Current: $electricalCurrent, Actual Rope Speed: $actualRopeSpeed, Current State: $currentState";
//
//         setState(() {
//           _receivedMessages.add(message);
//         });
//
//         // Display a toast with the message
//         Fluttertoast.showToast(
//             msg: message,
//             toastLength: Toast.LENGTH_LONG,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.grey,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//       }
//     }
//   }
// });