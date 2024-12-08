// VM:
//   Input parsing time: 4.14ms
//   P1 solve avg. time: 1.13ms
//   P2 solve avg. time: 1.73ms
// YYC:
//   Input parsing time: 825µs
//   P1 solve avg. time: 138µs
//   P2 solve avg. time: 324µs

function day08_input(file){
	var _map = ds_map_create(),
		_input = input_array(file);
	
	for( var i = 0; i < array_length(_input); i++ ) {
		for( var j = 1; j <= string_length(_input[i]); j++ ) {
			if( !string_char_at_is( _input[i], j, "." ) ) {
				if( _map[? string_char_at(_input[i], j)] == undefined ) {
					_map[? string_char_at(_input[i], j)] = [];
				}
				
				array_push( _map[? string_char_at(_input[i], j)], [j-1,i] );
			}
		}
	}
	
	// Input format [ map of antenna arrays, max width, max height ]
	return [_map,  string_length(_input[0])-1, array_length(_input)-1];
}

function day08_part1(input){
	var _antinodes = [],
		_answer = 0;
	
	for( var i = input[2]; i >= 0; i-- ) {
		_antinodes[i] = array_create( input[1]+1, 0 );
	}
	
	for( var i = ds_map_find_first(input[0]); i != undefined; i = ds_map_find_next( input[0], i ) ) {
		
		var _antennas = input[0][? i];
		
		for( var j = 0; j < array_length( _antennas ); j++ ) {
			
			for( var k = 0; k < array_length( _antennas ); k++ ) {
				if( j == k ) continue;
				
				var _x_diff = _antennas[j][0] - _antennas[k][0],
					_y_diff = _antennas[j][1] - _antennas[k][1];
				
				if( point_in_rectangle( _antennas[j][0]+_x_diff, _antennas[j][1]+_y_diff, 0, 0, input[1], input[2] ) ) {
					if( _antinodes[_antennas[j][0]+_x_diff][_antennas[j][1]+_y_diff] == 0 ) {
						_antinodes[_antennas[j][0]+_x_diff][_antennas[j][1]+_y_diff] = 1;
						_answer++;
					}
				}
			}
		}
	}
	
	// push the pre-made array and p1 answer into the input to pass onto part 2
	array_push( input, _antinodes, _answer );
	
	return _answer;
}

function day08_part2(input){
	var _antinodes = input[3],
		_answer = input[4];
	
	
	for( var i = ds_map_find_first(input[0]); i != undefined; i = ds_map_find_next( input[0], i ) ) {
		
		var _antennas = input[0][? i];
		
		for( var j = 0; j < array_length( _antennas ); j++ ) {
		
			for( var k = 0; k < array_length( _antennas ); k++ ) {
				if( j == k ) continue;
				
				var _x_diff = _antennas[j][0] - _antennas[k][0],
					_y_diff = _antennas[j][1] - _antennas[k][1];
				
				var _n = 0;
				while( true ) {
					if( point_in_rectangle( _antennas[j][0]+(_x_diff*_n), _antennas[j][1]+(_y_diff*_n), 0, 0, input[1], input[2] ) ) {
						if( _antinodes[_antennas[j][0]+(_x_diff*_n)][_antennas[j][1]+(_y_diff*_n)] == 0 ) {
							_antinodes[_antennas[j][0]+(_x_diff*_n)][_antennas[j][1]+(_y_diff*_n)] = 1;
							_answer++;
						}
						_n++;
					} else {
						break;
					}
				}
			}
		}
	}
	
	
	return _answer;
}