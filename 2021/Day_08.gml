// VM:
//  P1 solve avg. time: 0.71ms; median: 0.67ms
//  P2 solve avg. time: 16.42ms; median: 15.62ms

// YYC: TBD, can't get working

function day_08_input(){
	var _arr = [],
	_line = [],
	_f = file_text_open_read( "08.txt" );
	
	while ( !file_text_eof(_f) ) {
		_line = string_split( string_strip( file_text_readln( _f ), ["\n","\r"] ), " | ", type_string );
		
		_arr[array_length(_arr)] = [ string_split(_line[0], " ", type_string), string_split(_line[1], " ", type_string) ];
	}
	
	file_text_close( _f );
	return _arr;
}


function day_08_part1( input ) {
	var _l = array_length( input ),
		_disL = array_length( input[0][1] );
	
	var _count = 0;
	
	for( var i = 0; i < _l; i++ ) {
		for( var j = 0; j < _disL; j++ ) {
			switch( string_length( input[i][1][j] ) ) {
				case 2: case 3: case 4: case 7: 
						_count++; 
					break;
			}
		}
	}
	
	return _count;
}

function day_08_part2( input ) {
	var _l = array_length(input),
		_count = 0;
	for( var i = 0; i < _l; i++ ) {
		_count += day_08_solve_line( input[i] );
	}
	
	return _count;
}

function day_08_solve_line( input ) {
	var _line = input;
	var _knownDigits = [],
		_bin,
		_dLen,
		_count,
		_l = array_length(_line[0]);
		
	// Get binary values of the numbers in the first part of the input line
	// Only relevant numbers are 1, 4, 7, and 8, because they have unique
	// number of segments turned on
	// 97...103 = a...g, optimisation against string comparisons
	for ( var i = 0; i < _l; i++ ) {
		_bin = 0;
		_count = 0;
		_dLen = string_length(_line[0][i]);
		
		if( _dLen == 2 || _dLen == 3 || _dLen == 4 || _dLen == 7 ) {
			for( var j = 1; j <= _dLen; j++ ) {
				switch( string_byte_at(_line[0][i], j) ) {
					case 97: _bin |= 1;  break;
					case 98: _bin |= 2;  break;
					case 99: _bin |= 4;  break;
					case 100: _bin |= 8;  break;
					case 101: _bin |= 16; break;
					case 102: _bin |= 32; break;
					case 103: _bin |= 64; break;
				}
			}
		
			switch( _dLen ) {
				case 2: _knownDigits[0] = _bin; break; // 1
				case 4: _knownDigits[1] = _bin; break; // 4
				case 3: _knownDigits[2] = _bin; break; // 7
				case 7: _knownDigits[3] = _bin; break; // 8
			}
			
			_count++;
			if( _count == 4 ) break;
		}
	}
	
	// Get binary values of the numbers on the display
	// 97...103 = a...g, optimisation against string comparisons
	var _number = "";
	_l = array_length(_line[1]);
	for( var i = 0; i < _l; i++ ) {
		_bin = 0;
		_dLen = string_length(_line[1][i]);
		
		for( var j = 1; j <= _dLen; j++ ) {
			switch( string_byte_at(_line[1][i], j) ) {
				case 97: _bin |= 1;  break;
				case 98: _bin |= 2;  break;
				case 99: _bin |= 4;  break;
				case 100: _bin |= 8;  break;
				case 101: _bin |= 16; break;
				case 102: _bin |= 32; break;
				case 103: _bin |= 64; break;
			}
		}
		
			
		if( _bin == _knownDigits[0] ) {
			_number += "1";
		} else 
		if( _bin == _knownDigits[1] ) {
			_number += "4";
		} else 
		if( _bin == _knownDigits[2] ) {
			_number += "7";
		} else 
		if( _bin == _knownDigits[3] ) {
			_number += "8";
		} else 
		if( matching_bits( _bin, _knownDigits[3], 7 ) == 6 ) {
			if( matching_bits( _bin, _knownDigits[1], 7 ) == 4 ) {
				_number += "9";
			} else 
			if( matching_bits( _bin, _knownDigits[2], 7 ) == 3 ) {
				_number += "0";
			} else {
				_number += "6";
			}
		} else {
			if( matching_bits( _bin, _knownDigits[0], 7 ) == 2 ) {
				_number += "3";
			} else 
			if( matching_bits( _bin, _knownDigits[1], 7 ) == 3 ) {
				_number += "5"; 
			} else {
				_number += "2";
			}
		} 
	}
	
	return real(_number);
}

function matching_bits( val1, val2, length ) {
	var _c = 0;
	for( var i = 0; i < length; i++ ) {
		if( ( ( ( val1 >> i ) & 1 ) == 1 ) && ( ( ( val2 >> i ) & 1 ) == 1 ) ) {
			_c++;
		}
	}
	
	return _c;
}