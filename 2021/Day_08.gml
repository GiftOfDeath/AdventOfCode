// VM:
//  P1 solve avg. time: 0.73ms
//  P2 solve avg. time: 2.23ms

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
	var _knownDigits = array_create( array_length(_line), 0 ),
		_mysteryDigits = [],
		_display = [],
		_bin,
		_dLen,
		_l = array_length(_line[0]);
		
	// Get binary values of the numbers in the first part of the input line
	for ( var i = 0; i < _l; i++ ) {
		_bin = 0;
		_dLen = string_length(_line[0][i]);
		for( var j = 1; j <= _dLen; j++ ) {
			switch( string_char_at(_line[0][i], j) ) {
				case "a": _bin |= 1;  break;
				case "b": _bin |= 2;  break;
				case "c": _bin |= 4;  break;
				case "d": _bin |= 8;  break;
				case "e": _bin |= 16; break;
				case "f": _bin |= 32; break;
				case "g": _bin |= 64; break;
			}
		}
		
		switch( _dLen ) {
			case 2: _knownDigits[1] = _bin; break;
			case 3: _knownDigits[7] = _bin; break;
			case 4: _knownDigits[4] = _bin; break;
			case 7: _knownDigits[8] = _bin; break;
			
			default: _mysteryDigits[array_length(_mysteryDigits)] = _bin; break;
		}
	}
	
	// Get binary values of the numbers on the display
	_l = array_length(_line[1]);
	for( var i = 0; i < _l; i++ ) {
		_bin = 0;
		_dLen = string_length(_line[1][i]);
		
		for( var j = 1; j <= _dLen; j++ ) {
			
			switch( string_char_at(_line[1][i], j) ) {
				case "a": _bin |= 1;  break;
				case "b": _bin |= 2;  break;
				case "c": _bin |= 4;  break;
				case "d": _bin |= 8;  break;
				case "e": _bin |= 16; break;
				case "f": _bin |= 32; break;
				case "g": _bin |= 64; break;
			}
		}
		
		_display[i] = _bin;
	}
	
	_l = array_length( _mysteryDigits );
	var i = 0,
		_pL;
	
	// Figure out which value corresponds which number on the display
	while( i < _l ) {
		_pL = _l
		
		if( _l == 6 &&
			matching_bits( _mysteryDigits[i], _knownDigits[4], 7 ) == 3 && 
			matching_bits( _mysteryDigits[i], _knownDigits[7], 7 ) == 3 && 
			matching_bits( _mysteryDigits[i], _knownDigits[8], 7 ) == 6 ) {
			_knownDigits[0] = _mysteryDigits[i];
			array_delete( _mysteryDigits, i, 1 );
		} else
		if( _l == 5 &&
			matching_bits( _mysteryDigits[i], _knownDigits[4], 7 ) == 2 && 
			matching_bits( _mysteryDigits[i], _knownDigits[7], 7 ) == 2 ) {
			_knownDigits[2] = _mysteryDigits[i];
			array_delete( _mysteryDigits, i, 1 );
		} else
		if( _l == 4 &&
			matching_bits( _mysteryDigits[i], _knownDigits[4], 7 ) == 3 && 
			matching_bits( _mysteryDigits[i], _knownDigits[7], 7 ) == 2 && 
			matching_bits( _mysteryDigits[i], _knownDigits[8], 7 ) == 6 ) {
			_knownDigits[6] = _mysteryDigits[i];
			array_delete( _mysteryDigits, i, 1 );
		} else
		if( _l == 3 &&
			matching_bits( _mysteryDigits[i], _knownDigits[7], 7 ) == 3 && 
			matching_bits( _mysteryDigits[i], _knownDigits[4], 7 ) == 4 ) {
			_knownDigits[9] = _mysteryDigits[i];
			array_delete( _mysteryDigits, i, 1 );
		} else
		if( _l == 2 &&
			matching_bits( _mysteryDigits[i], _knownDigits[1], 7 ) == 1 && 
			matching_bits( _mysteryDigits[i], _knownDigits[2], 7 ) == 3) {
			_knownDigits[5] = _mysteryDigits[i];
			array_delete( _mysteryDigits, i, 1 );
		} else
		if( _l == 1 ) {
			_knownDigits[3] = _mysteryDigits[i];
			array_delete( _mysteryDigits, i, 1 );
			break;
		}
		
		_l = array_length( _mysteryDigits );
		
		if( _pL == _l ) i++;
		if( i >= _l ) i = 0;
	}
	
	var _number = "";
	
	_l = array_length(_display);
	for( var i = 0; i < _l; i++ ) {
		for( var j = 0; j < 10; j++ ) {
			if( _display[i] == _knownDigits[j] ) {
				_number += string(j);
				break;;
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