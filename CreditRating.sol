
contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract CreditScore is Owned {
    
    struct Organization {
        string orgName;
        uint orgId;
        
    }
    
    mapping(address => Organization) Organizations;

    
    function addOrganization(address org, string name) public {
        if(msg.sender!= owner) return;
        uint id = 1;
        Organizations[org].orgName = name;
        Organizations[org].orgId = id;
    }
    
    function getOrganization(address orgAddress) public returns (string) {
        return Organizations[orgAddress].orgName;
    }

}