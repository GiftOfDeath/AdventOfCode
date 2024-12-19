// VM:
//   Input parsing time: 609µs
//   P1 solve avg. time: 139.30ms
//   P2 solve avg. time: 220.01ms
// YYC:
//   Input parsing time: 570µs
//   P1 solve avg. time: 69.22ms
//   P2 solve avg. time: 82.71ms

function day19_input(file) {
	var _input = input_array(file),
		_designs,
		_display = [];
		
	_designs = string_split( _input[0], ", " );
	
	for( var i = 2; i < array_length( _input ); i++ ) {
		array_push( _display, _input[i] );
	}
	
	return [_designs, _display];
}

function day19_part1(input){
	var _towels = input[0],
		_patterns = input[1],
		_answer = 0;
		
	function match_pattern( match, towels, pattern, map ) {
		ds_map_clear( map );
		
		for( var i = 0; i < array_length(towels); i++ ) {
			var _pos = string_pos( towels[i], pattern ),
				_len = string_length( towels[i] );
				
			while( _pos != 0 ) {
				if( map[? _pos] == undefined ) {
					map[? _pos] = [];
				}
				
				array_push( map[? _pos], _pos+_len );
				_pos = string_pos_ext( towels[i], pattern, _pos+1 );
			}
		}
		
		function validate( map, key, last ) {
			if( map[? key] == undefined ) return 0;
			
			if( key == last ) return 1;
			
			var _arr = map[? key],
				_is_valid = 0;
			for( var i = 0; i < array_length(_arr); i++ ) {
				if( _arr[i]-1 == last ) return 1;
				
				if( map[? _arr[i]] != undefined ) {
					_is_valid = validate( map, _arr[i], last );
					if( _is_valid == 1 ) return 1;
					
					_arr[i] = -1;
				}
			}
			
			return 0;
		}
		
		return validate( map, 1, string_length(pattern) );
	}
	
	var _map = ds_map_create();
	for( var i = 0; i < array_length( _patterns ); i++ ) { 
		_answer += match_pattern( "", _towels, _patterns[i], _map );
	}
	ds_map_destroy(_map);
	
	return _answer;
}

function day19_part2(input){
	var _towels = input[0],
		_patterns = input[1],
		_answer = 0;
		
	function match_pattern( match, towels, pattern, map ) {
		ds_map_clear( map );
		
		for( var i = 0; i < array_length(towels); i++ ) {
			var _pos = string_pos( towels[i], pattern ),
				_len = string_length( towels[i] );
				
			while( _pos != 0 ) {
				if( map[? _pos] == undefined ) {
					map[? _pos] = [];
				}
				
				array_push( map[? _pos], _pos+_len );
				
				_pos = string_pos_ext( towels[i], pattern, _pos+1 );
			}
		}
		
		function validate( map, key, last ) {		
			var _answer = 0;
			
			if( key == last ) return 1;
			
			var _arr = map[? key],
				_is_valid;
			
			if( is_array( _arr ) ) {
				for( var i = 0; i < array_length(_arr); i++ ) {
					if( _arr[i]-1 == last ) _answer++;
				
					if( map[? _arr[i]] != undefined ) {
						_is_valid = validate( map, _arr[i], last );
					
						if( _is_valid > 0 ) {
							_answer += _is_valid;
						}
					}
				}
				
				if( _answer > 0 ) {
					map[? key] = _answer;
				} else {
					map[? key] = -1;
				}
			} else {
				return _arr;
			}
			
			return _answer;
		}
		
		if( map[? 1] == undefined ) return 0;
		
		return validate( map, 1, string_length(pattern) );
	}
	
	var _map = ds_map_create(),
		_total;
	for( var i = 0; i < array_length( _patterns ); i++ ) {
		_total = match_pattern( "", _towels, _patterns[i], _map );
		_answer += _total;
	}
	
	ds_map_destroy(_map);
	
	return _answer;
}