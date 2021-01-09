_sound = _this select 0;

switch (_sound) do {
	case "PlantedBomb": {
		playsound "Plantedbomb"; 
		sleep 3.5;
		cutText ["A mysterious voice says: We have planted a bomb","PLAIN",2];
	};
	case "Nikos": {
		playsound "Nikos"; 
		sleep 6;
		cutText ["Nikos here, I have placed a marker on your map","PLAIN",2];
	};
	case "Paymoney": {
		playsound "Paymoney"; 
		sleep 3;
		cutText ["You have paid the terrorists the ransom money.","PLAIN",2];
	};
	case "DefusedBomb": {
		playsound "DefusedBomb"; 
		sleep 3;
		cutText ["You defused the bomb and received a payment of $ 30.000 from the gouvernment.","PLAIN",2];
	};
	case "FakeBomb": {
		playsound "FakeBomb"; 
		sleep 3;
		cutText ["A mysterious voice says: HAHAHA it was fake!","PLAIN",2];
	};
};