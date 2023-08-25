import 'package:flutter/material.dart';
import 'package:desentralized_car_insurance/controller/policy_controller.dart';

class InsuranceScreen extends StatefulWidget {
  final PolicyController policyController;

  InsuranceScreen({required this.policyController});

  @override
  _InsuranceScreenState createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  late PolicyController _policyController;

  @override
  void initState() {
    super.initState();
    _policyController = widget.policyController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decentralized Car Insurance'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Welcome to Decentralized Car Insurance!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'A New Era in Car Insurance',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Benefits Over Conventional Insurance:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '- Lower Premiums\n- Transparent Claims Process\n- Peer-to-Peer Coverage',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Display policy creation form
                },
                child: Text('Create Policy'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Display claims submission form
                },
                child: Text('Submit Claim'),
              ),
              SizedBox(height: 30),



              // Display policy list, claims history, etc.
            ],
          ),
        ),
      ),
    );
  }
}
