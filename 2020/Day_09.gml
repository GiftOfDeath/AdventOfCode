// VM:
//   P1 solve avg. time: 102.69ms
//   P2 solve avg. time: 0.61ms
// YYC
//   P1 solve avg. time: 18.65ms
//   P2 solve avg. time: 0.09ms

// input = input_array(file, type_real);
function day9_part1(input){
	var _val, 
		_l = array_length(input),
		_range = 25,
		_valid = false;
	
	for( var i = 25; i < _l; i++ ) {
		_val = input[i];
		_valid = false;
		
		for( var j = i-1; j >= i-_range; j-- ) {
			for( var k = j-1; k >= i-_range; k-- ) {
				if( input[k] == input[j] ) continue;
				
				if( input[k]+input[j] == _val ) {
					_valid = true;
					break;
				}
			}
			
			if( _valid ) break;
		}
		
		if( !_valid ) return _val;
	}
}

// tSum = part 1 answer
function day9_part2(input,tSum) {
	var _l = array_length(input),
		_first = 0,
		_last = 0,
		_sum = 0,
		_min = infinity,
		_max = 0;
	
	for( var i = 0; i < _l; i++ ) {
		_sum += input[i];
		if( _sum > tSum ) {
			for( var j = _first; j < i; j++ ) {
				_sum -= input[j];
				if( _sum <= tSum ) {
					_first = j+1;
					break;
				}
			}
		}
		
		if( _sum == tSum ) { 
			_last = i;
			break;
		}
	}
	
	for( var i = _first; i <= _last; i++ ) {
		_min = min(_min, input[i]);
		_max = max(_max, input[i]);
	}
	
	return _min+_max;
}