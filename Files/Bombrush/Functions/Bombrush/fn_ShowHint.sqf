_hinttype = _this select 0;

switch (_hinttype) do {
	case 0: {
		cutText ["Why would you pay the money when there is no bomb?","PLAIN",2];
	};
	case 1: {
		cutText ["You have paid the terrorists the ransom money.","PLAIN",2];
	};
	case 2: {
		cutText ["Not enough money to make the payment.","PLAIN",2];
	};
	case 3: {
		cutText ["You defused the bomb and received a payment of $ 30.000 from the gouvernment.","PLAIN",2];
	};
	case 4: {
		cutText ["It was a fake bomb!","PLAIN",2];
	};
	case 5: {
		cutText ["A Mysterious voice says: We have planted a bomb","PLAIN",2];
	};
};
