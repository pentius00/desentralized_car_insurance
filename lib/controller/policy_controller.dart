import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart'; // Import for asset loading

class PolicyController {
  final EthereumAddress contractAddress;
  final Web3Client web3Client;

  DeployedContract? _deployedContract;
  ContractFunction? _createPolicyFunction;
  ContractFunction? _submitClaimFunction;
  ContractFunction? _processClaimFunction;

  PolicyController(this.contractAddress, this.web3Client) {
    _initContractFunctions();
  }

  Future<void> _initContractFunctions() async {
    final contractAbi = ContractAbi.fromJson(jsonDecode(await loadAbiJson()), 'CarInsurance'); // Replace 'CarInsurance' with your contract's name

    final contract = DeployedContract(
      contractAbi,
      contractAddress,
    );

    _deployedContract = contract;
    _createPolicyFunction = contract.function('createPolicy');
    _submitClaimFunction = contract.function('submitClaim');
    _processClaimFunction = contract.function('processClaim');
  }

  Future<void> createPolicy({
    required double premiumAmount,
    required double coverageAmount,
    required int policyDuration,
    required bool isRideshareCoverage,
  }) async {
    final ethAmount = EtherAmount.fromUnitAndValue(EtherUnit.ether, 0.1); // Example: 0.1 Ether
    final credentials = await web3Client.credentialsFromPrivateKey('YOUR_PRIVATE_KEY');
    final transaction = Transaction.callContract(
      contract: _deployedContract!,
      function: _createPolicyFunction!,
      parameters: [
        premiumAmount,
        coverageAmount,
        policyDuration,
        isRideshareCoverage,
      ],
      maxGas: 1000000,
      gasPrice: EtherAmount.inWei(BigInt.from(20000000000)), // Example gas price
    );

    final transactionHash = await web3Client.sendTransaction(credentials, transaction, fetchChainIdFromNetworkId: true);

    // Wait for the transaction to be mined
  }

// ... submitClaim and processClaim methods ...
}

// Load ABI JSON from assets
Future<String> loadAbiJson() async {
  return await rootBundle.loadString('constants/abi.json');
}
