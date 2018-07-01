pragma solidity ^0.4.18;

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

contract CreditRating is Owned {
    
    struct Organization {
        string orgId;
        string orgName;
    }
    
    mapping(address => Organization) organizations;
    //address[] public orgAccts;
    
    function addOrganization(address orgAddress, string _orgName, string _orgId) onlyOwner {
        var org = organizations[orgAddress];
        org.orgName = _orgName;
        org.orgId = _orgId;
        
        //orgAccts.push(orgAddress);
    }
    
    function getOrganization(address _orgAddress) view public returns (string, string) {
        return (organizations[_orgAddress].orgName, organizations[_orgAddress].orgId);
    }
    
    
}
