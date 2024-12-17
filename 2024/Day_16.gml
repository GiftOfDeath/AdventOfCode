// VM:
//   Input parsing time: 0ms
//   P1 solve avg. time: 0ms
//   P2 solve avg. time: 0ms
// YYC:
//   Input parsing time: 0ms
//   P1 solve avg. time: 0ms
//   P2 solve avg. time: 0ms

function day16_input(file) {
	var _input = input_array(file),
		_line,
		_maze = [],
		_start,
		_goal;
	
	for( var i = 0; i < array_length(_input); i++ ) {
		_line = _input[i];
		
		for( var j = 0; j < string_length(_line); j++ ) {
			var _chr = string_byte_at( _line, j+1 );
			
			switch( _chr ) {    // "#" = 35  "S" = 83  "E" = 69 (nice)
				case 35: _maze[j][i] = 1; break;
				
				case 83: _start = [j,i]; 
						 _maze[j][i] = 0;
					break;
					
				case 69: _goal = [j,i];
						 _maze[j][i] = 0;
					break;
				
				default: _maze[j][i] = 0;
			}
		}
	}
	
	
	/*for( var yy = 0; yy < array_length(_maze[0]); yy++ ) {
		var _line = "";
		
		for( var xx = 0; xx < array_length(_maze); xx++ ) {
			_line += ( _maze[xx][yy] == 0 ) ? " " : "#";
		}
		
		log( _line );
	}*/
	
	var _cost_grid = [];
	
	for( var i = 0; i < array_length( _maze ); i++ ) {
		_cost_grid[i] = array_create( array_length(_maze[0]), infinity );
	}
	
	return [_maze, _cost_grid,_start,_goal];
}

function day16_part1(input){
	var _maze = input[0],
		_cost_grid = input[1],
		_start = input[2],
		_goal = input[3];
	
	
	function find_best_path( start, goal, maze, weights, dir, points ) {
		// If at goal return the score of the path
		if( array_equals( start, goal ) ) {
			weights[start[0]][start[1]] = points;
			return points;
		}
		
					  // right  down   left    up		
		var _dir_lut = [ [1,0], [0,1], [-1,0], [0,-1] ],
			_xx = start[0],
			_yy = start[1],
			_nx, _ny;
		
		if( points <= weights[_xx][_yy] ) {
			weights[_xx][_yy] = points;
		}/**/
		
		var _tmp_score,
			_finds_goal = false;
		for( var i = 0; i < 4; i++ ) {
			_nx = _xx+_dir_lut[i][0];
			_ny = _yy+_dir_lut[i][1];
			
			
			
			if( maze[_nx][_ny] != 1 && weights[_nx][_ny] != -1 && weights[_nx][_ny] > points ) {
				_tmp_score = find_best_path( [_nx, _ny], goal, maze, weights, i, points + ( ( dir == i ) ? 1 : 1001 ) );
				
				if( !_finds_goal && _tmp_score > -1 ) {
					weights[_xx][_yy] = points+1000;
					_finds_goal = true;
				} 
			} else if( goal[0] == _xx && goal[1] == _yy && points + ( ( dir == i ) ? 1 : 1001 ) == weights[_nx][_ny] ) {
				_finds_goal = true;
			}
		}
		
		if( _finds_goal ) {
			//maze[_xx][_yy] = ( points <= weights[goal[0]][goal[1]] ) ? weights[goal[0]][goal[1]] : 0;
			return points;
		} 
		
		return -1;
	}
	
	find_best_path( _start, _goal, _maze, _cost_grid, 0, 0 );
	var _answer = _cost_grid[ _goal[0] ][ _goal[1] ];
	
	/*for( var yy = 0; yy < array_length(_maze[0]); yy++ ) {
		var _line = "";
		
		for( var xx = 0; xx < array_length(_maze); xx++ ) {
			_line += ( _maze[xx][yy] == 0 ) ? "      " : string_format(_maze[xx][yy], 5, 0 )+" ";
		}
		
		log( _line );
	}
	
	for( var yy = 0; yy < array_length(_cost_grid[0]); yy++ ) {
		var _line = "";
		
		for( var xx = 0; xx < array_length(_cost_grid); xx++ ) {
			_line += ( _cost_grid[xx][yy] == infinity ) ? "      " : string_format(_cost_grid[xx][yy], 5, 0 )+" ";
		}
		
		log( _line );
	}*/
	
	return _answer;
}

function day16_part2(input){
	var _maze = input[0],
		_cost_grid = input[1],
		_start = input[2],
		_goal = input[3],
		_paths = ds_map_create();
	
	function find_all_best_paths( start, goal, maze, weights, paths, dir, points ) {
		
					  // right  down   left    up		
		var _dir_lut = [ [1,0], [0,1], [-1,0], [0,-1] ],
			_xx = start[0],
			_yy = start[1],
			_nx, _ny;
			
		if( points > weights[_xx][_yy] ) return 0;
		
		// If at goal return the score of the path
		if( array_equals( start, goal ) ) {
			return 1;
		}
		
		var _finds_goal = false;
		for( var i = 0; i < 4; i++ ) {
			_nx = _xx+_dir_lut[i][0];
			_ny = _yy+_dir_lut[i][1];
			
			if( maze[_nx][_ny] != 1 ) {
				if( find_all_best_paths( [_nx, _ny], goal, maze, weights, paths, i, points + ( ( dir == i ) ? 1 : 1001 ) ) ) {
					paths[? string_ext( "{0},{1}", [_nx,_ny] )] = true;
					_finds_goal = true;
				}
			}
		}
		
		return _finds_goal;
	}
	
	find_all_best_paths( _start, _goal, _maze, _cost_grid, _paths, 0, 0 );
	var _answer = ds_map_size( _paths )+1;
	/*
	for( var yy = 0; yy < array_length(_cost_grid[0]); yy++ ) {
		var _line = "";
		
		for( var xx = 0; xx < array_length(_cost_grid); xx++ ) {
			if( _paths[? string_ext( "{0},{1}", [xx,yy] )] == true ) {
				_line += " Best ";
			} else {
				_line += ( _cost_grid[xx][yy] == infinity ) ? "      " : string_format(_cost_grid[xx][yy], 5, 0 )+" ";
			}
		}
		
		log( _line );
	}*/
	
	/*for( var yy = 1; yy < array_length(_maze[0]); yy++ ) {		
		for( var xx = 1; xx < array_length(_maze); xx++ ) {
			if( _paths[? string_ext( "{0},{1}", [xx,yy] )] == true ) {
				_maze[xx][yy] = 2;
			}
		}
	}*/
	
	ds_map_destroy( _paths );
	
	return _answer;
}