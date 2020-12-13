// VM:
//   P1 solve avg. time: 0.13ms
//   P2 solve avg. time: 0.90ms
// YYC:


function day13_part1(input) {
	var _target = input[0],
		_busses = input[1],
		_earliest = infinity,
		_id,
		_departs;
	
	for( var i = 0; i < array_length(_busses); i++ ) {
		if( _busses[i] == "x" ) continue;
		
		_departs = ( (_target div _busses[i])+1 )*_busses[i];
		
		if( _departs < _earliest ) {
			_earliest = _departs;
			_id = _busses[i];
		}
	}
		
	return _id*(_earliest-_target);
}


function day13_part2(input,timestamp) {
	var _busses = [];
	
	var _n, _interval;
	
	for( var i = 0; i < array_length(input[1]); i++ ) {
		if( input[1][i] == "x" ) continue;
		array_push(_busses, [input[1][i], i]);
	}
	
	var _t = (timestamp div _busses[0][0]) * _busses[0][0];
	
	_interval = _busses[0][0];
	_n = 1;
	while( _n < array_length(_busses) ) {
		_t += _interval;
		if( (_t + _busses[_n][1] ) mod _busses[_n][0] == 0 ) {
			_interval *= _busses[_n][0];
			_n++;
		}
	}
	
	return _t;
}

// Technically works, but it may take days to find the correct timestamp :)
// timestamp = starting point
function day13_part2_garbo(input,timestamp) {
	var _busses = input[1],
		_t,
		_highest,
		_interval;
	
	_highest[0] = 0;
	for( var i = 0; i < array_length(_busses); i++ ) {
		if( _busses[i] == "x" || _highest[0] > _busses[i] ) continue;
		_highest = [_busses[i],i];
	}
	
	_t = (timestamp div _highest[0])*_highest[0]-_highest[1];
	_interval = _busses[0]*(_highest[0]-_highest[1]);
	
	for( var i = 0; i < array_length(_busses); i++ ) {
		if( _busses[i] == "x" ) continue;
		
		if( ( (_t div _busses[i])+1 )*_busses[i]  != _t+i ) {
			i = 0;
			_t += _interval;
		}
	}
	
	return _t;
}

function day13_input(file) {
	var input_raw = input_array( file, type_string );
	
	var input = [];
	input[0] = real( input_raw[0] );
	
	input[1] = string_split( input_raw[1], ",", type_string );
	
	for( var i = 0; i < array_length(input[1]); i++ ) {
		if( string_digits(input[1][i]) != "" )
			input[1][i] = real(input[1][i]);
	}
	
	return input;
}