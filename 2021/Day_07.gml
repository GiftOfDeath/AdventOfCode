// VM:
//  P1 solve avg. time: 0.67ms
//  P2 solve avg. time: 1.50ms

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
	array_sort( crabs, true );
	
	var _l = array_length(crabs),
		_average = array_average( crabs, true ),
		_fuelTotal = 0,
		_travel;
	
	for( var i = 0; i < _l; i++ ) {
		_travel = abs(crabs[i]-_average);
		_fuelTotal += triangular_number( _travel );
	}
	
	return "Ideal position: "+string(_average)+"; Total fuel cost: "+string(_fuelTotal);
}