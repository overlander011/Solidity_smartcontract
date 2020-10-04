pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Voting {
    string[]  candidateList;
    
    mapping(address => bool) public useVote;
    
    mapping(string => uint256) private votesReceived;
    constructor(string[] memory candateNames) public{
        candidateList = candateNames;
    }
    
    function vote(string memory candidate) public{
        if(useVote[msg.sender]== false){
            votesReceived[candidate] +=1;
        }

        useVote[msg.sender] = true;
    }
    
    function result(string memory candidate) public view returns(uint256){
        return votesReceived[candidate];
     
    }
    
    function candidateCount() public view returns(uint256){
        return candidateList.length;
    }
}