pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint) private balances;

    // Event to log deposit and withdrawal actions
    event Deposit(address indexed account, uint amount);
    event Withdrawal(address indexed account, uint amount);

    // Function to deposit Ether into the bank
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the bank
    function withdraw(uint _amount) public {
        require(_amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Check if the contract has enough balance to fulfill the withdrawal
        assert(address(this).balance >= _amount);

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    // Function to get the balance of the caller
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    // Function to demonstrate the use of revert()
    function forceRevert() public pure {
        revert("This function always reverts");
    }
}
