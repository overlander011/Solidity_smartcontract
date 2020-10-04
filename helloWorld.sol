pragma solidity ^0.5.0;
//looklike class 
contract helloWorld {
    string public hello = "Hello Earth";
    
    uint256[] private numbers;
    
    mapping(string => uint256) public keyValueStore;
    mapping(string => bool) public hashValue;
    uint256 public keyValueLength;
    
    constructor(uint256[] memory initData) public{
        numbers = initData;
    }
    
    //array number
    function pushNumber (uint256 newNumber) public{
        numbers.push(newNumber);
    }
    
    function getNumber(uint256 index) public view returns(uint256){
        return numbers[index];
    }
    
    function getAllNumber() public view returns(uint256[] memory){
        return numbers;
    }
    
    function getLenge() public view returns(uint256){
        return numbers.length;
    }
    
    //mapping key value store
    function setKeyvalue(string memory key,uint256 value) public{
        keyValueStore[key] = value;
        
        //if never push value before
        if(hashValue[key] == false){
            keyValueLength += 1;
        //if have value before
        } else if(value == 0){
            keyValueLength -= 1;
        }
        
        hashValue[key] = true;
        
    }
    
 
    
    
    // function hashValue(string memory key) public view returns(bool){
    //     return keyValueStore[key] != 0;
    // }
}