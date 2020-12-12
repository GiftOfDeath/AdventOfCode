// VM:
//   P1 solve avg. time: 4.19ms
//   P2 solve avg. time: 3.52m
// YYC:
//   P1 solve avg. time: 0.90ms
//   P2 solve avg. time: 0.57ms

// To clarify some potential confusion: 0,0 coordinate in GM is top-left,
// and positive x is towards right and positive y towards bottom of the screen.
// Code is built adhering to the same rule:
// ( +x = east, -x = west, -y = north, +y = south )

function day12_part1(input) {
	var _position = [0,0],
		_direction = 0,
		_compass = ["E","N","W","S"],
		_move;
	
	for( var i = 0; i < array_length(input); i++ ) {
		switch( input[i][0] ) {
			case "L": _direction = wrap( 0, 3, _direction+(input[i][1] div 90) ); break;
			case "R": _direction = wrap( 0, 3, _direction-(input[i][1] div 90) ); break;
			default: 
					_move = day12_move( ( ( input[i][0] == "F" ) ? _compass[_direction] : input[i][0] ), input[i][1] );
					_position[0] += _move[0];
					_position[1] += _move[1];
				break;
		}
	}
	
	return string(abs(_position[0])+abs(_position[1]))+" ["+string(_position[0])+","+string(_position[1])+"]";
}

// question starting point [10,-1] (10 east 1 north)
function day12_part2(input, start) {
	var _position = [0,0],
		_move,
		waypoint = start,
		_tmpWaypoint = [];
	
	for( var i = 0; i < array_length(input); i++ ) {
		switch( input[i][0] ) {
			case "L": 
					repeat( input[i][1] div 90 ) {
						array_copy(_tmpWaypoint,0,waypoint,0,2);
						waypoint[0] = _tmpWaypoint[1];
						waypoint[1] = _tmpWaypoint[0]*-1;
					}
				break;
				
			case "R": 
					repeat( input[i][1] div 90 ) {
						array_copy(_tmpWaypoint,0,waypoint,0,2);
						waypoint[0] = _tmpWaypoint[1]*-1;
						waypoint[1] = _tmpWaypoint[0];
					}
				break;
				
			case "F": 
					_position[0] += waypoint[0]*input[i][1];
					_position[1] += waypoint[1]*input[i][1];
				break;
				
			default: 
					_move = day12_move( input[i][0], input[i][1] );
					waypoint[0] += _move[0];
					waypoint[1] += _move[1];
				break;
		}
	}
	
	return string(abs(_position[0])+abs(_position[1]))+" ["+string(_position[0])+","+string(_position[1])+"]";
}

function day12_move( dir, spd ) {
	var _movement = [0,0];
	switch( dir ) {
		case "N": _movement[1] -= spd; break;
		case "S": _movement[1] += spd; break;
		case "E": _movement[0] += spd; break;
		case "W": _movement[0] -= spd; break;
	}
	
	return _movement;
}

function day12_input(file) {
	var _arr = input_array(file,type_string),
		_line;
	
	for( var i = 0; i < array_length(_arr); i++ ) {
		_line = _arr[i];
		_arr[i][0] = string_char_at(_line,1);
		_arr[i][1] = real(string_delete(_line,1,1));
	}
	
	return _arr;
}