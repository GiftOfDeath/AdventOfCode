// VM:
//   P1 solve avg. time: 6.18ms
//   P2 solve avg. time: 10.51ms
// YYC:
//   P1 solve avg. time: 2.00ms
//   P2 solve avg. time: 2.73ms


function day02_part1(input){
	var _safe = 0;
	
	function is_safe( levels ) {
		var _line_dir,
			_length = array_length( levels );
			
		for( var i = 0; i < _length-1; i++ ) {	
			// If there's no change in level, or the change is too big, call unsafe
			if( levels[i] == levels[i+1] || abs( levels[i] - levels[i+1] ) > 3 ) {
				break;
			}
			
			var _dir = sign( levels[i] - levels[i+1] );
			
			// Define if the trend in level changes is ascending or decending
			if( i == 0 ) {
				_line_dir = _dir;
				continue;
			}
			
			// If the change is in wrong direction, call unsafe
			if( _dir != _line_dir ) break;
			
			// If no problems found by the last check add to count
			if( i+1 == _length-1 ) return true;
		}
		
		return false;
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
			_length = array_length( levels );
			
		for( var i = 0; i < _length-1; i++ ) {	
			// If there's no change in level, or the change is too big, call unsafe
			if( levels[i] == levels[i+1] || abs( levels[i] - levels[i+1] ) > 3 ) {
				break;
			}
			
			var _dir = sign( levels[i] - levels[i+1] );
			
			// Define if the trend in level changes is ascending or decending
			if( i == 0 ) {
				_line_dir = _dir;
				continue;
			}
			
			// If the change is in wrong direction, call unsafe
			if( _dir != _line_dir ) break;
			
			// If no problems found by the last check add to count
			if( i+1 == _length-1 ) return true;
		}
		
		return false;
	}
	
	for( var i = 0; i < _l; i++ ) {
		var _line = string_split_numbers( input[i], " " );
			
		if( is_safe( _line ) ) {
			_safe++;
		} else {
			// If the levels were not safe, check if removing any single level in the
			// readings would make it acceptable
			
			var _length = array_length( _line ),
				_mod_line = [];
			 
			for( var j = 0; j < _length; j++ ) {
				array_copy( _mod_line, 0, _line, 0, _length );
				array_delete( _mod_line, j, 1 );
				
				if( is_safe( _mod_line ) ) {
					_safe++;
					break;
				}
			}
		}
	}
	
	return _safe;
}