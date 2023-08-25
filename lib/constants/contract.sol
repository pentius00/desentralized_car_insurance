// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarInsurance {
    struct Policy {
        uint256 policyId;
        address owner;
        uint256 premiumAmount;
        uint256 coverageAmount;
        uint256 policyExpiration;
        bool isActive;
        bool isRideshareCoverage; // New field for ride-share coverage
    }

    struct Claim {
        uint256 claimId;
        uint256 policyId;
        uint256 claimAmount;
        bool isApproved;
        bool isProcessed;
    }

    mapping(uint256 => Policy) public policies;
    mapping(uint256 => Claim) public claims;

    uint256 public policyCounter;
    uint256 public claimCounter;

    event PolicyCreated(uint256 indexed policyId, address indexed owner);
    event ClaimSubmitted(uint256 indexed claimId, uint256 indexed policyId);

    function createPolicy(
        uint256 premiumAmount,
        uint256 coverageAmount,
        uint256 policyDuration,
        bool isRideshareCoverage // New parameter
    ) external {
        policyCounter++;
        policies[policyCounter] = Policy(
            policyCounter,
            msg.sender,
            premiumAmount,
            coverageAmount,
            block.timestamp + policyDuration,
            true,
            isRideshareCoverage // Set the new field
        );
        emit PolicyCreated(policyCounter, msg.sender);
    }

    function submitClaim(uint256 policyId, uint256 claimAmount) external {
        require(policies[policyId].isActive, "Policy not active");
        claimCounter++;
        claims[claimCounter] = Claim(claimCounter, policyId, claimAmount, false, false);
        emit ClaimSubmitted(claimCounter, policyId);
    }

    function processClaim(uint256 claimId) external {
        Claim storage claim = claims[claimId];
        require(claim.policyId != 0, "Claim not found");
        require(!claim.isProcessed, "Claim already processed");
        require(policies[claim.policyId].owner == msg.sender, "Unauthorized");

        claim.isProcessed = true;
        if (claim.claimAmount <= policies[claim.policyId].coverageAmount) {
            claim.isApproved = true;

            if (policies[claim.policyId].isRideshareCoverage) {
                // If the policy has ride-share coverage, process the payout accordingly
                // You can integrate external data to calculate the appropriate payout amount
                // For example, determine the driver's ride-sharing activity and calculate compensation
                // Then, transfer the calculated payout amount to the policy owner's address
                payable(policies[claim.policyId].owner).transfer(claim.claimAmount);
            } else {
                // For non-ride-share policies, transfer the claim amount directly to the policy owner
                payable(policies[claim.policyId].owner).transfer(claim.claimAmount);
            }
        }
    }
}
