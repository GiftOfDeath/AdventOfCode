// VM:
//   P1 solve avg. time: 86.47ms
//   P2 solve avg. time: 2s 223ms
// YYC:
//   P1 solve avg. time: 12.76ms
//   P2 solve avg. time: 349.02ms


function day07_part1(input){
	var _length = array_length( input ),
		_answer = 0;
	
	function try_operators( target, current_result, n_array, pos ) {
		
		// If reached the end of the array, check if any of the potential 3 operators would
		// yield an acceptable result
		if( pos == array_length(n_array)-1 ) {
			if( (current_result * n_array[pos]) == target || (current_result + n_array[pos] == target ) ) {
				return true;
			}
			
			return false;
		}
		
		// Use _viable to avoid redundant checks if any one path returns a passing result
		var _viable = false,
			_new_result;
		
		_new_result = (current_result + n_array[pos]);
		if( _new_result <= target ) {
			_viable = ( try_operators( target, _new_result, n_array, pos+1 ) );
		}
		
		if( !_viable ) {
			_new_result = (current_result * n_array[pos]);
			if( _new_result <= target ) {
				_viable = try_operators( target, _new_result, n_array, pos+1 );
			}
		}
		
		return _viable;
	}
	
	for( var i = 0; i < _length; i++ ) {
		// Get rid of the : separator and split at spaces
		var _numbers = string_split_numbers( string_replace( input[i], ":", "" ), " " );
		
		if( try_operators( _numbers[0], _numbers[1], _numbers, 2 ) ) {
			_answer += _numbers[0];
		}
	}
	
	return _answer;
}

function day07_part2(input){
	var _length = array_length( input ),
	_answer = 0;
	
	function try_operators( target, current_result, n_array, pos ) {
		
		// If reached the end of the array, check if any of the potential 3 operators would
		// yield an acceptable result
		if( pos == array_length(n_array)-1 ) {
			if( (current_result * n_array[pos]) == target || (current_result + n_array[pos] == target ) || ( ( ( current_result * power( 10, digit_count(n_array[pos]) ) ) + n_array[pos] ) == target ) ) {
				return true;
			}
			
			return false;
		}
		
		// Use _viable to avoid redundant checks if any one path returns a passing result
		var _viable = false,
			_new_result;
		
		_new_result = (current_result + n_array[pos]);
		if( _new_result <= target ) {
			_viable = ( try_operators( target, _new_result, n_array, pos+1 ) );
		}
		
		if( !_viable ) {
			_new_result = (current_result * n_array[pos]);
			if( _new_result <= target ) {
				_viable = try_operators( target, _new_result, n_array, pos+1 );
			}
		}
		
		if( !_viable ) {
			_new_result = ( ( current_result * power( 10, digit_count(n_array[pos]) ) ) + n_array[pos] );
			if( _new_result <= target ) {
				_viable = ( try_operators( target, _new_result, n_array, pos+1 ) );
			}
		}
		
		return _viable;
	}
	
	for( var i = 0; i < _length; i++ ) {
		// Get rid of the : separator and split at spaces
		var _numbers = string_split_numbers( string_replace( input[i], ":", "" ), " " );
		
		// _numbers[0] = the desired end value
		if( try_operators( _numbers[0], _numbers[1], _numbers, 2 ) ) {
			_answer += _numbers[0];
		}
	}
	
	return _answer;
}