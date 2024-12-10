// VM:
//   Input parsing time: 3.65ms
//   P1 solve avg. time: 5.79ms
//   P2 solve avg. time: 2.35ms
// YYC:
//   Input parsing time: 475µs
//   P1 solve avg. time: 797µs
//   P2 solve avg. time: 432µs

function day10_input(file) {
	var _input = string_split( string_strip( input_string( file ), "\r" ), "\n", type_string ),
		_str;
		
	var _map_grid   = [],
		_trailheads = [],
		_n;
		
	// Construct a 2d array of the map [x][y] for ease
	for( var i = 0; i < array_length( _input ); i++ ) {
		_str = _input[i];
		for( var j = 1; j <= string_length( _str ); j++ ) {
			_n = string_byte_at(_str, j)-48;
			_map_grid[j-1][i] = _n;
			
			// Store the trailheads separately so we don't have to find them again
			if( _n == 0 ) {
				array_push( _trailheads, [j-1, i] );
			}
		}
	}
	
	return [ _trailheads, _map_grid ];
}

function day10_part1(input){
	var _trailheads = input[0],
		_map        = input[1];
	
	function find_unique_goals( x_start, y_start, target, grid, width, height, visited ) {
		var _goals           = 0,
			_cur_pos         = grid[x_start][y_start],
			_next_wanted_pos = _cur_pos+1;
		
		if( _cur_pos == target ) {
			// Store the visited goal's x,y in a single value and push it into the array tracking them
			var _goal = ( x_start * 1000) + y_start;
			if( !array_contains( visited, _goal ) ) {
				array_push( visited, _goal );
				return 1;
			}
		}
		
		// Attempt to move to neighbouring cells
		if( x_start+1 < width && grid[x_start+1][y_start] == _next_wanted_pos ) {
			_goals += find_unique_goals( x_start+1, y_start, target, grid, width, height, visited );
		}
		
		if( y_start+1 < height && grid[x_start][y_start+1] == _next_wanted_pos ) {
			_goals += find_unique_goals( x_start, y_start+1, target, grid, width, height, visited );
		}
		
		if( x_start > 0 && grid[x_start-1][y_start] == _next_wanted_pos ) {
			_goals += find_unique_goals( x_start-1, y_start, target, grid, width, height, visited );
		}
		
		if( y_start > 0 && grid[x_start][y_start-1] == _next_wanted_pos ) {
			_goals += find_unique_goals( x_start, y_start-1, target, grid, width, height, visited );
		}
		
		return _goals;
	}
	
	var _width  = array_length(_map),
		_height = array_length(_map[0]),
		_answer = 0,
		_visited;
	
	var _length = array_length( _trailheads );
	for( var i = 0; i < _length; i++ ) {
		_visited = [];
		_answer += find_unique_goals( _trailheads[i][0], _trailheads[i][1], 9, _map, _width, _height, _visited );
	}
	
	return _answer;
}

function day10_part2(input){
	var _trailheads = input[0],
		_map        = input[1];
		
	function find_all_paths( x_start, y_start, target, grid, width, height ) {
		var _goals			 = 0,
			_cur_pos		 = grid[x_start][y_start],
			_next_wanted_pos = _cur_pos+1;
		
		if( _cur_pos == target ) {
			return 1;
		}
		
		// Return however many paths the current position leads to if any
		if( grid[x_start][y_start] & ~15 > 0 ) {
			return grid[x_start][y_start] >> 4;
		}
		
		// Attempt to move to neighbouring cells
		// grid[x][y] checks the 4 rightmost bits against the next wanted height value
		if( x_start+1 < width && grid[x_start+1][y_start] & 15 == _next_wanted_pos ) {
			_goals += find_all_paths( x_start+1, y_start, target, grid, width, height );
		}
		
		if( y_start+1 < height && grid[x_start][y_start+1] & 15 == _next_wanted_pos ) {
			_goals += find_all_paths( x_start, y_start+1, target, grid, width, height );
		}
		
		if( x_start > 0 && grid[x_start-1][y_start] & 15 == _next_wanted_pos ) {
			_goals += find_all_paths( x_start-1, y_start, target, grid, width, height );
		}
		
		if( y_start > 0 && grid[x_start][y_start-1] & 15 == _next_wanted_pos ) {
			_goals += find_all_paths( x_start, y_start-1, target, grid, width, height );
		}
		
		if( _goals > 0 ) {
			// Because the height of any point is at most 9, it only takes 4 bits to store, and so we can
			// shift the number of paths from the cell 4 bits left
			grid[x_start][y_start] = ( _goals << 4 ) + _cur_pos;
		}
		
		return _goals;
	}
	
	var _width  = array_length(_map),
		_height = array_length(_map[0]),
		_answer = 0,;
	
	var _length = array_length( _trailheads );
	for( var i = 0; i < _length; i++ ) {
		_answer += find_all_paths( _trailheads[i][0], _trailheads[i][1], 9, _map, _width, _height );
	}
	
	return _answer;
}