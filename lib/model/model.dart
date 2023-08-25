
class Policy {
  final int policyId;
  final String owner;
  final double premiumAmount;
  final double coverageAmount;
  final DateTime policyExpiration;
  final bool isActive;
  final bool isRideshareCoverage;

  Policy({
    required this.policyId,
    required this.owner,
    required this.premiumAmount,
    required this.coverageAmount,
    required this.policyExpiration,
    required this.isActive,
    required this.isRideshareCoverage,
  });
}
