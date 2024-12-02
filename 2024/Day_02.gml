// VM:
//   P1 solve avg. time: 6.32ms
//   P2 solve avg. time: 9.32ms
// YYC:
//   P1 solve avg. time: 2.00ms
//   P2 solve avg. time: 2.47ms


function day02_part1(input){
	var _safe = 0;
	
	function is_safe( levels ) {
		var _line_dir,
			_dir,
			_length = array_length( levels );
			
		for( var i = 0; i < _length-1; i++ ) {	
			_dir = sign( levels[i] - levels[i+1] );
			
			// Define if the trend in level changes is ascending or decending
			if( i == 0 ) {
				_line_dir = _dir;
			}
			
			// If there's no change in level, or the change is too big, or the change is in wrong direction, the levels are unsafe
			if( levels[i] == levels[i+1] || abs( levels[i] - levels[i+1] ) > 3 || _dir != _line_dir ) {
				return false;
			}
		}
		
		return true;
	}
	
	for( var i = 0; i < array_length(input); i++ ) {
		var _line = string_split_numbers( input[i], " " );
		if( is_safe( _line ) ) _safe++;
	}
	
	return _safe;
}

function day02_part2(input){
	var _safe = 0,
		_l = array_length( input );
	
	function is_safe( levels ) {
		var _line_dir,
			_dir,
			_length = array_length( levels );
			
		for( var i = 0; i < _length-1; i++ ) {	
			_dir = sign( levels[i] - levels[i+1] );
			
			// Define if the trend in level changes is ascending or decending
			if( i == 0 ) {
				_line_dir = _dir;
			}
			
			// If there's no change in level, or the change is too big, or the change is in wrong direction, 
			// return the unsafe pair's position as a negative number to differentiate it from a safe result
			if( levels[i] == levels[i+1] || abs( levels[i] - levels[i+1] ) > 3 || _dir != _line_dir ) {
				return -i;
			}
		}
		
		return 1;
	}
	
	for( var i = 0; i < _l; i++ ) {
		var _line = string_split_numbers( input[i], " " );
		
		var _is_safe = is_safe( _line );
		
		if( _is_safe == 1 ) {
			_safe++;
		} else {
			// If the levels were not safe, check if removing any single level around the 
			// unsafe level reading would make it acceptable
			
			var _length = array_length( _line ),
				_mod_line;
			
			_is_safe = abs(_is_safe)
			 
			for( var j = max( 0, _is_safe-1 ); j <= _is_safe+1; j++ ) {
				_mod_line = [];
				array_copy( _mod_line, 0, _line, 0, _length );
				array_delete( _mod_line, j, 1 );
				
				if( is_safe( _mod_line ) == 1 ) {
					_safe++;
					break;
				}
			}
		}
	}
	
	return _safe;
}