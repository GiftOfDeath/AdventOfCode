// VM:
//   P1 solve avg. time: 15.21ms
//   P2 solve avg. time: 25.52ms
// YYC:
//   P1 solve avg. time: 3.31ms
//   P2 solve avg. time: 5.98ms


function day07_part1(input){
	var _length = array_length( input ),
		_answer = 0;
	
	function try_operators( current_result, n_array, pos ) {
		
		// If reached the end of the array, check if any of the potential 3 operators would
		// yield an acceptable result
		if( pos == 2 ) {
			if( (current_result / n_array[pos]) == n_array[1] || (current_result - n_array[pos] == n_array[1] ) ) {
				return true;
			}
			
			return false;
		}
		
		// Use _viable to avoid redundant checks if any one path returns a passing result
		var _viable = false,
			_new_result;
		
		_new_result = (current_result - n_array[pos]);
		if( _new_result > 0 ) {
			_viable = ( try_operators( _new_result, n_array, pos-1 ) );
		}
		
		if( !_viable ) {
			if( current_result % n_array[pos] == 0 ) {
				_new_result = (current_result div n_array[pos]);
				_viable = try_operators( _new_result, n_array, pos-1 );
			}
		}
		
		return _viable;
	}
	
	for( var i = 0; i < _length; i++ ) {
		// Get rid of the : separator and split at spaces
		var _numbers = string_split_numbers( string_replace( input[i], ":", "" ), " " );
		
		if( try_operators( _numbers[0], _numbers, array_length( _numbers )-1 ) ) {
			_answer += _numbers[0];
		}
	}
	
	return _answer;
}

function day07_part2(input){
	var _length = array_length( input ),
	_answer = 0;
	
	function try_operators( current_result, n_array, pos ) {
		
		// If reached the end of the array, check if any of the potential 3 operators would
		// yield an acceptable result
		if( pos == 2 ) {
			if( (current_result / n_array[pos]) == n_array[1] || 
				(current_result - n_array[pos] == n_array[1] ) || 
				( ( current_result - n_array[pos] ) / power( 10, digit_count(n_array[pos]) ) == n_array[1] ) ) {
				
				return true;
			}
			
			return false;
		}
		
		// Use _viable to avoid redundant checks if any one path returns a passing result
		var _viable = false,
			_new_result;
		
		_new_result = (current_result - n_array[pos]);
		if( _new_result > 0 ) {
			_viable = ( try_operators( _new_result, n_array, pos-1 ) );
		}
		
		if( !_viable ) {
			if( current_result % n_array[pos] == 0 ) {
				_new_result = (current_result div n_array[pos]);
				_viable = try_operators( _new_result, n_array, pos-1 );
			}
		}
		
		if( !_viable ) {
			if( ( current_result - n_array[pos] ) % power( 10, digit_count(n_array[pos]) ) == 0 ) {
				_new_result = ( current_result - n_array[pos] ) / power( 10, digit_count(n_array[pos]) );
				if( _new_result > 0 ) {
					_viable = ( try_operators( _new_result, n_array, pos-1 ) );
				}
			}
		}
		
		return _viable;
	}
	
	for( var i = 0; i < _length; i++ ) {
		// Get rid of the : separator and split at spaces
		var _numbers = string_split_numbers( string_replace( input[i], ":", "" ), " " );
		
		// _numbers[0] = the desired end value
		if( try_operators( _numbers[0], _numbers, array_length(_numbers)-1 ) ) {
			_answer += _numbers[0];
		}
	}
	
	return _answer;
}