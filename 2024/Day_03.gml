// VM:
//   P1 solve avg. time: 61.74ms
//   P2 solve avg. time: 33.05ms
// YYC:
//   P1 solve avg. time: 67.18ms
//   P2 solve avg. time: 35.06ms


function day03_part1(input){
	var _l = string_length(input),
		_i = string_pos( "mul(", input )+3,	// Find the first multiply function
		_chr,
		_delimiter = false,					// determines whether to add digits to _x or _y
		_x = "",
		_y = "",
		_answer = 0;
	
	while( _i < _l ) {
		_i++;
		
		// Add to _x or _y if a number
		if( string_char_at_is_digit( input, _i ) ) {
			if( !_delimiter ) {
				_x += string_char_at( input, _i )
			} else {
				_y += string_char_at( input, _i );
			}
			
			continue;
		}
		
		_chr = string_char_at( input, _i );
		
		// Check for the delimiter and closing bracket to add the multiplication to the answer, if x,y is viable
		if( _chr == "," && !_delimiter ) {
			_delimiter = true;
			continue;
		} else if( _chr == ")" ) {
			if( _delimiter && string_length(_x) > 0 && string_length(_y) > 0 ) {
				_answer += real(_x) * real(_y);
			}
		}
		
		// Find the next mul function
		_i = string_pos_ext( "mul(", input, _i );
		
		if( _i == 0 ) {
			break;
		} else {
			// Jump to the assumed location of the next number
			_i += 3;
			_delimiter = false;
			_x = "";
			_y = "";
		}
	}
	
	return _answer;
}

function day03_part2(input){
	var _l = string_length(input),
		_i = string_pos( "mul(", input )+3,
		_chr,
		_delimiter = false,
		_x = "",
		_y = "",
		_answer = 0,
		_dontdo;
	
	while( _i < _l ) {
		_i++;
		
		// Add to _x or _y if a number
		if( string_char_at_is_digit( input, _i ) ) {
			if( !_delimiter ) {
				_x += string_char_at( input, _i )
			} else {
				_y += string_char_at( input, _i );
			}
			
			continue;
		}
		
		_chr = string_char_at( input, _i );
		
		// Check for the delimiter and closing bracket to add the multiplication to the answer, if x,y is viable
		if( _chr == "," && !_delimiter ) {
			_delimiter = true;
			continue;
		} else if( _chr == ")" ) {
			if( _delimiter && string_length(_x) > 0 && string_length(_y) > 0 ) {
				_answer += real(_x) * real(_y);
			}
		}
		
		// Find the next don't and mul functions
		_dontdo = string_pos_ext( "don't()", input, _i );
		_i = string_pos_ext( "mul(", input, _i );
		
		// If don't() function before mul(x,y), skip to the next do() if any to continue mul()
		if( _dontdo < _i ) {
			_i = string_pos_ext( "do()", input, _i );
			
			if( _i > 0 ) {
				_i = string_pos_ext( "mul(", input, _i );
			}
		}
		
		if( _i == 0 ) {
			break;
		} else {
			_i += 3;
			_delimiter = false;
			_x = "";
			_y = "";
		}
	}
	
	return _answer;
}