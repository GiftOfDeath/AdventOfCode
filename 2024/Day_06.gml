// VM:
//   P1 solve avg. time: 10.98ms
//   P2 solve avg. time: 11s 63ms
// YYC:
//   P1 solve avg. time: 0ms
//   P2 solve avg. time: 0ms


function day06_part1(input){
	var _obstacles = [],
		_guard  = [],
		_height = array_length( input ),
		_width  = array_length( input[0] ),
		_answer = 1;
	
	for( var i = 0; i < _height; i++ ) {
		_obstacles[i] = [];
		
		for( var j = 0; j < _width; j++ ) {
			var _chr = ord( input[j][i] );
			
			switch( _chr ) {    // "." = 46, "#" = 35, "^" = 94
				case 46: array_push( _obstacles[i], 0 ); break; // 0 = not-visited, movable
				case 35: array_push( _obstacles[i], 1 ); break; // 1 = obstacle
				case 94: array_push( _obstacles[i], 2 );		// 2 = visited, movable
						 _guard = [i,j];  break;
			}
		}
	}
	
	// 0 north, 1 east, 2 south, 3 west
	var _move = 0,
		_moves_lut = [ [0,-1], [1,0], [0,1], [-1,0] ];
	
	while( true ) {
		var _new_x = _guard[0] + _moves_lut[_move][0],
			_new_y = _guard[1] + _moves_lut[_move][1];
		
		// if the guard would leave the room, break
		if( !point_in_rectangle( _new_x, _new_y, 0, 0, _width-1, _height-1 ) ) break;
		
		if( _obstacles[ _new_x ][ _new_y ] != 1 ) {
			_guard[0] = _new_x;
			_guard[1] = _new_y;
			
			if( _obstacles[ _new_x ][ _new_y ] == 0 ) {
				_obstacles[ _new_x ][ _new_y ] = 2;
				_answer++;
			}
		} else {
			_move = wrap( 0, 3, _move+1 ); 
		}
	}
	
	return _answer;
}

function day06_part2(input){
	var _obstacles = [],
		_guard  = [],
		_height = array_length( input ),
		_width  = array_length( input[0] ),
		_answer = 0;
	
	for( var i = 0; i < _height; i++ ) {
		_obstacles[i] = [];
		
		for( var j = 0; j < _width; j++ ) {
			var _chr = ord( input[j][i] );
			
			switch( _chr ) {    // "." = 46, "#" = 35, "^" = 94
				case 46: array_push( _obstacles[i], 0 ); break; // 0 = not-visited, movable
				case 35: array_push( _obstacles[i], 1 ); break; // 1 = obstacle
				case 94: array_push( _obstacles[i], 2 );		// array = visited, movable
						 _guard = [i,j];  break;
			}
		}
	}
	
	// 0 north, 1 east, 2 south, 3 west
	var _move = 0,
		_moves_lut = [ [0,-1], [1,0], [0,1], [-1,0] ];
	
	// Construct the original guard path where she leaves the room [x,y,move direction]
	var _path = [];
	
	// push in the initial position and use it as reference for illegal obstacle pos
	array_push( _path, [_guard[0],_guard[1],_move] ); 
	
	while( true ) {
		var _new_x = _guard[0] + _moves_lut[_move][0],
			_new_y = _guard[1] + _moves_lut[_move][1];
		
		// if the guard would leave the room, break
		if( !point_in_rectangle( _new_x, _new_y, 0, 0, _width-1, _height-1 ) ) break;
		
		if( _obstacles[ _new_x ][ _new_y ] != 1 ) {
			_guard[0] = _new_x;
			_guard[1] = _new_y;
			array_push( _path, [_new_x,_new_y,_move] );
			_obstacles[_new_x][_new_y] = max( 2, _obstacles[_new_x][_new_y]+1 );
		} else {
			_move = wrap( 0, 3, _move+1 ); 
		}
	}
	
	var _new_obstacles = ds_map_create();
	
	var _path_len = array_length(_path);
	var _new_path = ds_map_create();
	
	for( var i = 0; i < _path_len; i++ ) {
		var _x   = _path[i][0],
			_y   = _path[i][1],
			_dir = _path[i][2];
		
		
		var _new_obstacle = [ _x, _y ],
			_newo_string = string_ext( "{0},{1}", [_x, _y] );
		
		if( _new_obstacles[? _newo_string] != undefined ) continue;
		_new_obstacles[? _newo_string] = 1;
		
		// If the new obstacle would be placed outside the room or on the guard, skip
		if( !point_in_rectangle( _new_obstacle[0], _new_obstacle[1], 0, 0, _width-1, _height-1 ) ||
			( _new_obstacle[0] == _path[0][0] && _new_obstacle[1] == _path[0][1] ) ) 
			continue;
		
		_guard[0] = _path[i-1][0];
		_guard[1] = _path[i-1][1];
		_move = _path[i-1][2];
		
		var _new_pos = [];
		ds_map_clear( _new_path )
		
		while( true ) {
			var _new_x = _guard[0] + _moves_lut[_move][0],
				_new_y = _guard[1] + _moves_lut[_move][1];
		
			// if the guard would leave the room, break
			if( !point_in_rectangle( _new_x, _new_y, 0, 0, _width-1, _height-1 ) ) break;
		
			if( _obstacles[ _new_x ][ _new_y ] != 1 && !( _new_obstacle[0] == _new_x && _new_obstacle[1] == _new_y ) ) {
				_guard[0] = _new_x;
				_guard[1] = _new_y;
				
				_new_pos = string_ext( "{0},{1},{2}", [ _new_x, _new_y, _move ] );
				
				// check if looping
				if( _new_path[? _new_pos] == 1 ) {
					_answer++;
					break;
				}
				
				_new_path[? _new_pos] = 1;
			} else {
				_move = wrap( 0, 3, _move+1 ); 
			}
		}
	}
		
	return _answer;
}