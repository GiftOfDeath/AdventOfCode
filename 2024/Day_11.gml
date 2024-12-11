// VM:
//   Input parsing time: 193µs
//   P1 solve avg. time: 16.00ms
//   P2 solve avg. time: 331.01ms
// YYC:
//   Input parsing time: 205µs
//   P1 solve avg. time: 4.31ms
//   P2 solve avg. time: 90.14ms

function day11_input(file) {
	var _input = string_split_numbers( input_string( file ), " " );
	
	var _cache = ds_map_create();
	for( var i = 0; i < array_length( _input ); i++ ) {
		var _stone = _input[i];
		_cache[? _input[i]] = 0;
		_input[i] = [ _stone, 1 ];
	}
	
	var _blinks_p1 = 25,
		_blinks_p2 = 75-_blinks_p1;
	return [_input, _blinks_p1, _blinks_p2, _cache];
}

function day11_part1(input){
	var _stones = input[0],
		_blinks = input[1],
		_cache  = input[3],
		_answer = 0;
	
	function blink( stones, cache ) {
		
		var _length = array_length(stones),
			_stone;
			
		for( var i = 0; i < _length; i++ ) {
			
			_stone = stones[i];
			
			if( _stone[1] == 0 ) continue;
			
			var _digits = digit_count( _stone[0] ),
				_mult;
			
			if( _digits % 2 == 0 ) {
				var _new_stone1, _new_stone2;
					
				_digits = _digits / 2;
				_mult = power( 10, _digits );
					
				_new_stone1 = _stone[0] div _mult;
				_new_stone2 = _stone[0] - ( _new_stone1 * _mult );
				
				if( cache[? _new_stone1] == undefined ) {
					cache[? _new_stone1] = _stone[1];
					array_push( stones, [_new_stone1,1] );
				} else {
					cache[? _new_stone1] += _stone[1];
				}
				
				if( cache[? _new_stone2] == undefined ) {
					cache[? _new_stone2] = _stone[1];
					array_push( stones, [_new_stone2,1] );
				} else {
					cache[? _new_stone2] += _stone[1];
				}
				
			} else {
				var _new_stone;
				if( _stone[0] == 0 ) {
					_new_stone = 1;
				} else {
					_new_stone = _stone[0] * 2024;
				}
				
				if( cache[? _new_stone] == undefined ) {
					cache[? _new_stone] = _stone[1];
					array_push( stones, [ _new_stone, 1 ] );
				} else {
					cache[? _new_stone] += _stone[1];
				}
			}
		}
		
		_length = array_length( stones );
		for( var i = 0; i < _length; i++ ) {
			stones[i][1] = cache[? stones[i][0]];
			cache[? stones[i][0]] = 0;
		}
	}
	
	for( var i = 0; i < _blinks; i++ ) {
		blink( _stones, _cache );
	}
	
	var _length = array_length( _stones );
	for( var i = 0; i < _length; i++ ) {
		_answer += _stones[i][1];
	}
	
	return _answer;
}

function day11_part2(input){
	
	var _stones = input[0],
		_blinks = input[2],
		_cache  = input[3],
		_answer = 0;
	
	
	function blink( stones, cache ) {		
		var _length = array_length(stones),
			_stone;
			
		for( var i = 0; i < _length; i++ ) {
			
			_stone = stones[i];
			
			if( _stone[1] == 0 ) continue;
			
			var _digits = digit_count( _stone[0] ),
				_mult;
			
			if( _digits % 2 == 0 ) {
				var _new_stone1, _new_stone2;
					
				_digits = _digits / 2;
				_mult = power( 10, _digits );
					
				_new_stone1 = _stone[0] div _mult;
				_new_stone2 = _stone[0] - ( _new_stone1 * _mult );
				
				if( cache[? _new_stone1] == undefined ) {
					cache[? _new_stone1] = _stone[1];
					array_push( stones, [_new_stone1,1] );
				} else {
					cache[? _new_stone1] += _stone[1];
				}
				
				if( cache[? _new_stone2] == undefined ) {
					cache[? _new_stone2] = _stone[1];
					array_push( stones, [_new_stone2,1] );
				} else {
					cache[? _new_stone2] += _stone[1];
				}
				
			} else {
				var _new_stone;
				if( _stone[0] == 0 ) {
					_new_stone = 1;
				} else {
					_new_stone = _stone[0] * 2024;
				}
				
				if( cache[? _new_stone] == undefined ) {
					cache[? _new_stone] = _stone[1];
					array_push( stones, [ _new_stone, 1 ] );
				} else {
					cache[? _new_stone] += _stone[1];
				}
			}
		}
		
		_length = array_length( stones );
		for( var i = 0; i < _length; i++ ) {
			stones[i][1] = cache[? stones[i][0]];
			cache[? stones[i][0]] = 0;
		}
	}
	
	
	for( var i = 0; i < _blinks; i++ ) {
		blink( _stones, _cache );
	}
	
	var _length = array_length( _stones );
	for( var i = 0; i < _length; i++ ) {
		_answer += _stones[i][1];
	}
	
	
	log( ds_map_size(_cache) );
	ds_map_destroy(_cache);
	
	return _answer;
	
}