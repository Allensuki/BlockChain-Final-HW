pragma solidity ^0.4.2;

contract  Platform{  

	address public organizer;					
	mapping (address => uint) public buyers;			
	uint public t_asset;						
	uint public t_credit;  					
	uint public account;						
	uint public value;	
                uint public credit;	 					
	

                  function createTable() private {
        TableFactory tf = TableFactory(0x1001); 
        tf.createTable("t_asset2", "account", "asset_value");
        tf.createTable("t_credit2", "account", "credit");
    }

	function Match() public{		//构造函数
		organizer = msg.sender;		
		value = 0;
		credit = 0;
	}

	
	function buy (uint amount) public payable{
		
		if (soldout == true || count + amount > capacity 
		    || stopsell == true || msg.value < (price * amount)) {
		    msg.sender.transfer(msg.value);
		    return; 
		}

		if(msg.value >= (price * amount)) {
			buyers[msg.sender] += amount;		
			count += amount;			
			if(count == capacity) {			
			    soldout = true;
			}
			Deposit(msg.sender, price * amount);

			
			uint refundFee = msg.value - price * amount;
			if(refundFee > 0) {
				msg.sender.transfer(refundFee);
			}
		}


	}

               function register(string account, uint256 asset_value, uint256 credit) public returns(int256){
        int256 ret_code = 0;
        int256 ret= 0;
        uint256 temp_asset_value = 0;
        uint256 temp_credit = 0;
        (ret, temp_asset_value, temp_credit) = select(account);
        if(ret != 0) {
            Table table = openTable();
            
            Entry entry = table.newEntry();
            entry.set("account", account);
            entry.set("asset_value", int256(asset_value));
            int count = table.insert(account, entry);

            table = openTable1();
            entry = table.newEntry();
            entry.set("account",account);
            entry.set("credit", int256(credit));
            count = table.insert(account, entry);
            if (count == 1) {
                ret_code = 0;
            } else {
                ret_code = -2;
            }
        } else{
            ret_code = -1;
        }

        emit RegisterEvent(ret_code, account, asset_value);

        return ret_code;
    }

	function increaseCapacity(uint add) public {	
		if (msg.sender != organizer) { return; }
		if(add > 0) {
			capacity += add;
			soldout = false;	
		}
	}
	
	function refund(uint amount) public{	
	    if(stopsell == true) { return; }			
	    uint temp = buyers[msg.sender];			
		if (temp >= amount) { 				
			Refund(msg.sender, price * amount);	
			buyers[msg.sender] -= amount;		
			count -= amount;			
			soldout = false;			
			msg.sender.transfer(price * amount);	
		}
		return;
	}


	function stopSell() public{
		if (msg.sender == organizer && stopsell == false) {				
			stopsell = true;
			organizer.transfer(price * count);		
		}
	}
}
