pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract ElectiveAuction {
    
    struct ClassDetail{
        uint256 subjectid;
        uint256 studentlimit;
        uint256 semester;
        uint256 year;
        address creater;
        uint256 enddate;
    }
    
    address[] public deployedElective;
    
    string[]  stdlist;
    
    mapping (address => ClassDetail) public elective;
    mapping (address => ClassDetail[]) public createrhistory;

    
    function createElective(uint256 subjectid,uint256 studentnumber,uint256 semester,uint256 year,uint256 enddate) public {
        address newElective = address(new Class(subjectid,studentnumber,semester, year,msg.sender,now));
        deployedElective.push(newElective);

        ClassDetail memory currentElective;
        currentElective.subjectid = subjectid;
        currentElective.studentlimit = studentnumber;
        currentElective.enddate = enddate;
        currentElective.semester = semester;
        currentElective.year = year;
        currentElective.creater = msg.sender;
        
        createrhistory[msg.sender].push(currentElective);
        elective[newElective] = currentElective;

    }
    
    function getDeployedElectiveByYearAndSemester (uint256 semester,uint256 year) public view returns(address[] memory){
        for(uint256 i=0;i<deployedElective.length;i++){
            if
        }
        
        return deployedElective;
    }
    
    function getDeployedElective () public view returns(address[] memory){
        return deployedElective;
    }
    
    function getClassDetailByAddr(address addr)
        public view returns(uint256 id,uint256 stdlimit,uint256 date,address creater,uint256 semester,uint256 year){
            
        id = elective[addr].subjectid;
        stdlimit = elective[addr].studentlimit;
        semester = elective[addr].semester;
        year = elective[addr].year;
        date = elective[addr].enddate;
        creater = elective[addr].creater;
        
        //stdlist = elective[addr].studentlist;
    }
}

contract Class {
    
    //string memory name;
   // uint256 studentnumbert;
    
    constructor(uint256 subjectid,uint256 studentnumber,uint256 semester,uint256 year,address creater, uint256 timestamp) public {
        
    }
}