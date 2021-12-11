// VM:
//  P1 solve avg. time: 16.17ms; median: 15.78ms
//  P2 solve avg. time: 12.85ms; median: 12.63ms

// YYC:
//  P1 solve avg. time: 9.16ms; median: 9.11ms
//  P2 solve avg. time: 8.90ms; median: 8.76ms

function day_03_input(){
	var _arr = [],
		_f = file_text_open_read( "03.txt" );
	while( !file_text_eof( _f ) ) {
		_arr[ array_length(_arr) ] = string( file_text_readln( _f ) );
	}
	
	file_text_close(_f);
	return _arr;
}

function day_03_part1(input) {
	var _l = array_length(input),
		_numberLength = string_length(input[0])-2,
		_bits = array_create(_numberLength,0);

	for( var i = 0; i < _l; i++ ) {
		for( var j = 0; j < _numberLength; j++ ) {
			if( string_char_at(input[i],j+1) == "1" ) {
				_bits[j]++;
			}
		}
	}

	var _gammaBin = "",
		_gammaDec = 0,
		_epsilonBin = "",
		_epsilonDec = 0;
		
	for( var i = 0; i < _numberLength; i++ ) {
		if( _bits[i] > _l/2 ) {
			_gammaBin += "1";
			_epsilonBin += "0";
		}else{
			_gammaBin += "0";
			_epsilonBin += "1";
		}
	}

	_gammaDec = bindec( _gammaBin );
	_epsilonDec = bindec( _epsilonBin );
	return ( _gammaBin + " (" + string(_gammaDec) + ") * " + _epsilonBin + " (" + string( _epsilonDec) + ") = " + string(_gammaDec*_epsilonDec) );
}

function day_03_part2(input) {
	var _l = array_length(input),
		_numberLength = string_length(input[0])-2,
		_oxygen = "",
		_co2 = "",
		_tmpArr =  [],
		_ones,
		_delete;

	array_copy( _tmpArr, 0, input, 0, _l );

	for( var i = 0; i < _numberLength; i++ ) {
		// find most common bit
		_ones = 0;
		for( var j = 0; j < array_length(_tmpArr); j++ ) {
			if( string_char_at(_tmpArr[j], i+1) == "1" ) {
				_ones++;
			}
		}
	
		if( _ones >= array_length(_tmpArr) div 2 ) {
			_delete = "0";
		}else{
			_delete = "1";
		}
	
		for( var j = array_length(_tmpArr)-1; j >= 0; j-- ) {
			if( string_char_at(_tmpArr[j], i+1) == _delete ) {
				array_delete( _tmpArr, j, 1 );
			}
		}
	
		if( array_length(_tmpArr) == 1 ) break;
	}

	_oxygen = string_copy( _tmpArr[0], 1, _numberLength );

	array_copy( _tmpArr, 0, input, 0, _l );
	for( var i = 0; i < _numberLength; i++ ) {
		// find least common bit
		_ones = 0;
		for( var j = 0; j < array_length(_tmpArr); j++ ) {
			if( string_char_at(_tmpArr[j], i+1) == "1" ) {
				_ones++;
			}
		}
	
		if( _ones < array_length(_tmpArr) / 2 ) {
			_delete = "0";
		}else{
			_delete = "1";
		}
	
		for( var j = array_length(_tmpArr)-1; j >= 0; j-- ) {
			if( string_char_at(_tmpArr[j], i+1) == _delete ) {
				array_delete( _tmpArr, j, 1 );
			}
		}
	
		if( array_length(_tmpArr) == 1 ) break;
	}

	_co2 = string_copy( _tmpArr[0], 1, _numberLength );

	return ( _oxygen + " (" + string(bindec(_oxygen)) + ") * " + _co2 + " (" + string(bindec(_co2)) + ") = " + string( bindec(_oxygen)*bindec(_co2) ) );
}
