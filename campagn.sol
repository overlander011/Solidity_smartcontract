pragma solidity ^0.5.0; 
pragma experimental ABIEncoderV2;


contract CampaignFactory { 
    struct CampaignDetail{
        string nametopic;
    }
    address[] public deployedCampaigns; 
    mapping(address => CampaignDetail) public campaign ;
    
    //ทำการเชื่อม
    function createCampaign(string memory topic,string[] memory candidate ,uint arrayLenght) public { 
        address newCampaign = address(new Ballot(topic,candidate,arrayLenght,msg.sender));
        deployedCampaigns.push(newCampaign); 
        campaign[newCampaign].nametopic = topic;
    }
    function getDeployedCampaigns() public view returns (address[] memory) { 
        return deployedCampaigns; 
    } 
    function getTopic(address adr) public view returns(string memory){
        return campaign[adr].nametopic;
    }
} 

contract Ballot {
    uint[] choiceIndex;
    string[] public allcandidate;

    uint public finalResult ;
    uint public totalVote ;
    uint public lengthCandidate;
    address public creatorAddress;      
    string public nameTopic;
    
    mapping(address => bool) public voters;

    enum State { Start, Voting, Ended }
	State public state;
	
	constructor( string memory topic,string[] memory candidate ,uint arrayLenght,address sender) public {
        creatorAddress = sender;
        nameTopic = topic;
        allcandidate = candidate;
        lengthCandidate = arrayLenght;
        choiceIndex = new uint[](arrayLenght);
        finalResult = 0;
        totalVote = 0 ;
    }
    
    
	modifier condition(bool _condition) {
		require(_condition);
		_;
	}

	modifier onlyCreator() {
		require(msg.sender == creatorAddress);
		_;
	}

	modifier inState(State _state) {
		require(state == _state);
		_;
	}
    
    function startVote()public inState(State.Start) onlyCreator{
        state = State.Voting;     
    }
    
    function doVote(uint index) public inState(State.Voting){
        require(!voters[msg.sender]);
        voters[msg.sender] = true;
        totalVote++;
        choiceIndex[index]++;
    }

    function score() public view returns(uint[] memory){
        uint256 largest = 0; 
        uint256 i;
        uint256 lent;
            
        for(i = 0; i < choiceIndex.length; i++){
            if(choiceIndex[i] > largest) {
                largest = choiceIndex[i];
                lent = i;
            }
        }
        return choiceIndex;
        
    }
    
    function endVote() public inState(State.Voting) onlyCreator 
    {
        state = State.Ended;
        uint256 max = 0; 
        uint256 i;
            
        for(i = 0; i < choiceIndex.length; i++){
            if(choiceIndex[i] >= max) {
                max = choiceIndex[i];
            }
        } 
        finalResult = max; 
    }
}
