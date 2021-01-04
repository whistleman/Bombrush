_building = _this select 0;
_cbpos = 0;

for "_x" from 1 to 100 do {

    //_bpos = _building buildingPos _x;

    if (format ["%1",(_building buildingPos _x)] != "[0,0,0]") then {
        _cbpos = _cbpos + 1;
    };

};
_bpos = round (random _cbpos);
_bpos