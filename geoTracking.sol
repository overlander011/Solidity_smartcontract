pragma solidity ^0.5.0;

contract GeoTracking {
    //record each user location with timestamp
    struct LocationStamp{
        uint256 lat;
        uint256 lng;
        uint256 datetime;
    }
    //user history
    mapping (address => LocationStamp[]) public userLocation;
    
    //user fullname and lastname
    mapping (address =>string) users;
    
    // Register username
    function register(string memory usersName) public{
        users[msg.sender] = usersName;
    }
    
    //get name by address
    function getPublicName(address userAddress) public view returns(string memory){
        return users[userAddress];
    }
    
    function track(uint256 lat,uint256 lng) public{
        LocationStamp memory currentLocation;
        currentLocation.lat = lat;
        currentLocation.lng = lng;
        currentLocation.datetime = now; // or block.timestamp;
        userLocation[msg.sender].push(currentLocation);
    }
    
    function getLatestLocation (address userAddress) 
        public view returns(uint256 lat,uint256 lng,uint datetime){
            
        LocationStamp[] storage locations = userLocation[userAddress];
        LocationStamp storage latestLocation = locations[locations.length - 1];
        // return (
        //     latestLocation.lat,
        //     latestLocation.lng,
        //     latestLocation.datetime
        //     );
        
        lat = latestLocation.lat;
        lng = latestLocation.lng;
        datetime = latestLocation.datetime;
    }
}