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
    address[] public electiveAuction;

    mapping (uint256 => mapping (uint256 => address[])) public addressbyyearandsemester;
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
        addressbyyearandsemester[year][semester].push(newElective);

    }
    
    function getAddressBySemester (uint256 year,uint256 semester) public view returns(address[] memory){
        return addressbyyearandsemester[year][semester];
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
        
       
    }
}

contract Class {
    
    address creatorAddress;
    uint256 subjectid;
    uint256 studentnumber;
    uint256 semester;
    uint256 year;
    uint256 enddate;
    mapping (uint256 => address[])  studentregisted;
    
    enum State { Start, Voting, Ended }
	State public state;

	constructor(uint256 subjectid,uint256 studentnumber ,uint256 semester,uint256 year,address owner,uint256 date) public {
        creatorAddress = owner;
        subjectid = subjectid;
        studentnumber = studentnumber;
        semester = semester;
        year = year;
        enddate = date;

    }
    
    function registerClass(uint256 _subjectid) public {
        studentregisted[_subjectid].push(msg.sender);
    }
    
    function getStudentBySubjectId(uint256 __subjectid) public view returns(address[] memory){
        return studentregisted[subjectid];
    }
    
    
}
