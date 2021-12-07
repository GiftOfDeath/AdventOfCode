// VM:
//  P1 solve avg. time: 0.67ms
//  P2 solve avg. time: 2.23ms

// YYC: TBD, can't get working

function day_07_input(){
	var _arr = [],
	_f = file_text_open_read( "07.txt" );
	
	_arr = string_split( file_text_readln( _f ), ",", type_real );
	file_text_close( _f );
	
	return _arr;
}

function day_07_part1(crabs) {
	array_sort( crabs, true );
	
	var _l = array_length(crabs),
		_median = array_median(crabs),
		_fuelTotal = 0;
	
	for( var i = 0; i < _l; i++ ) {
		_fuelTotal += abs(crabs[i]-_median);
	}
	
	return "Ideal position: "+string(_median)+"; Total fuel cost: "+string(_fuelTotal);
}

function day_07_part2(crabs) {	
	var _l = array_length(crabs),
		_mean = array_mean( crabs, false ),
		_means = [floor(_mean),ceil(_mean)],
		_fuelTotal = [0,0],
		_travel;
	
	for( var i = 0; i < _l; i++ ) {	
		_travel = abs(crabs[i]-_means[0]);
		_fuelTotal[0] += triangular_number( _travel );
		
		_travel = abs(crabs[i]-_means[1]);
		_fuelTotal[1] += triangular_number( _travel );
	}
	
	var _answer = (_fuelTotal[0] < _fuelTotal[1]) ? 0 : 1;
	return "Ideal position: "+string(_means[_answer])+"; Total fuel cost: "+string(_fuelTotal[_answer]);
}