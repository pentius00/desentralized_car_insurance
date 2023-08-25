import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:desentralized_car_insurance/controller/policy_controller.dart';
import 'package:desentralized_car_insurance/screens/insurance_screen.dart';
import 'package:http/http.dart' as http;


void main() {
  final EthereumAddress contractAddress = EthereumAddress.fromHex('0x69Cdde904725142210d861578989a00d21F337e6');
  final Web3Client web3Client = Web3Client('https://sepolia.infura.io/v3/0bc2427aa61e4d1ab4b789bc6dbd4203', http.Client());
  final PolicyController policyController = PolicyController(contractAddress, web3Client);

  runApp(MyApp(policyController: policyController));
}

class MyApp extends StatelessWidget {
  final PolicyController policyController;

  MyApp({required this.policyController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decentralized Car Insurance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InsuranceScreen(policyController: policyController),
    );
  }
}
