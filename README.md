# creditSmart
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
    
    struct Customer {
        string custName;
        int creditScore;
        int defaultCount;
        int onTimeCount;
    }
    
    mapping(address => Organization) organizations;
    //address[] public orgAccts;
    
    mapping(address => Customer) customers;
    
    function addOrganization(address orgAddress, string _orgName, string _orgId) onlyOwner {
        var org = organizations[orgAddress];
        org.orgName = _orgName;
        org.orgId = _orgId;
        
        //orgAccts.push(orgAddress);
    }
    
    function getOrganization(address _orgAddress) view public returns (string, string) {
        return (organizations[_orgAddress].orgName, organizations[_orgAddress].orgId);
    }
    
    function addCustomerDetails(address _custAddress, string _custName, int scrImpact) {
        var cust = customers[_custAddress];
        cust.custName = _custName;
        if(scrImpact == 2) {
            cust.defaultCount = cust.defaultCount + 1;
        }
        else if(scrImpact == 1) {
            cust.onTimeCount = cust.onTimeCount + 1;
        }
    }
    
    
    function getCustomerDetails(address _custAddress) view public returns (int, int) {
        return (customers[_custAddress].defaultCount, customers[_custAddress].onTimeCount);
    }
    
    function getCustomerRating(address _custAddress) view public returns (int) {
        int dc = customers[_custAddress].defaultCount;
        int ot = customers[_custAddress].onTimeCount;
        
        if(ot > dc) {
            customers[_custAddress].creditScore = ((dc*1000) / (dc + ot));
        }
        else {
            customers[_custAddress].creditScore = ((ot*1000) / (dc + ot));
            
        }
        
        return customers[_custAddress].creditScore;
    }
    
    
}
