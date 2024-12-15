// VM:
//   Input parsing time: 16.60ms
//   P1 solve avg. time: 11.84ms
//   P2 solve avg. time: 16.74ms
// YYC:
//   Input parsing time: 6.64ms
//   P1 solve avg. time: 1.49ms
//   P2 solve avg. time: 2.29ms

// . = 0
// # = 1
// O = 2
// [ = 2
// ] = 3

function day15_input(file) {
	var _input = input_array( file ),
		_line,
		_robot_p1,
		_robot_p2,
		_instructions = buffer_create( 20000, buffer_fast, 1 );
	
	buffer_seek( _instructions, buffer_seek_start, 0 );
	
	var _grid_p1 = [],
		_grid_p2 = [];
	
	var _section = 0;
	for( var i = 0; i < array_length(_input); i++ ) {
		_line = _input[i];
		
		if( _line == "" ) _section++;
		
		if( _section == 0 ) {
			for( var j = 1; j <= string_length(_line); j++ ) {
				var _chr = string_char_at( _line, j );
				if( _chr == "@" ) {
					_robot_p1 = [j-1,i];
					_grid_p1[j-1][i] = 0;
					
					_robot_p2 = [(j-1)*2,i];
					_grid_p2[(j-1)*2][i] = 0;
					_grid_p2[((j-1)*2)+1][i] = 0;
					continue;
				}
								
				switch( _chr ) {
					case ".": _grid_p1[j-1][i] = 0;
							  _grid_p2[(j-1)*2][i] = 0; 
							  _grid_p2[((j-1)*2)+1][i] = 0; 
						break;
					case "#": _grid_p1[j-1][i] = 1;
							  _grid_p2[(j-1)*2][i] = 1; 
							  _grid_p2[((j-1)*2)+1][i] = 1; 
						break;
					case "O": _grid_p1[j-1][i] = 2;
							  _grid_p2[(j-1)*2][i] = 2; 
							  _grid_p2[((j-1)*2)+1][i] = 3; 
						break;
				}
			}
		} else {
			var _l = string_length( _input[i] );
			for( var j = 1; j <= _l; j++ ) {
				var _move = string_byte_at( _input[i], j );
				switch( _move ) {
					case 62:  _move = 0; break;
					case 118: _move = 1; break;
					case 60:  _move = 2; break;
					case 94:  _move = 3; break;
				}
		
				buffer_write( _instructions, buffer_u8, _move );
			}
		}
	}
	
	return [_instructions, _robot_p1, _robot_p2, _grid_p1, _grid_p2];
}

function day15_part1(input){
	var _robot = input[1],
		_warehouse = input[3],
		_instructions = input[0];
	
	var _move, _move_lut,
		_rx, _ry,
		_dx, _dy,
		_ddx, _ddy;
	
	_move_lut[0] = [1,0];
	_move_lut[1] = [0,1];
	_move_lut[2] = [-1,0];
	_move_lut[3] = [0,-1];
	
	buffer_seek( _instructions, buffer_seek_start, 0 );
	repeat( buffer_get_size(_instructions) ) {
		_move = buffer_read( _instructions, buffer_u8 );
		
		_rx = _robot[0];
		_ry = _robot[1];
		
		_dx = _rx + _move_lut[_move][0];
		_dy = _ry + _move_lut[_move][1];
		
		// If empty space, move in
		if( _warehouse[ _dx ][ _dy ] == 0 ) {
			_robot[0] = _dx;
			_robot[1] = _dy;
		
		// If there's a box, see if the robot can push it
		} else if( _warehouse[ _dx ][ _dy ] == 2 ) {
			var _moves = 0;
				
			_ddx = _dx;
			_ddy = _dy;
			
			// See if there are more boxes behind the first one
			while( _warehouse[ _ddx ][ _ddy ] == 2 ) {
				_ddx += _move_lut[_move][0];
				_ddy += _move_lut[_move][1];
				_moves++;
			}
			
			// If there is empty space behind the box(es), push
			if( _warehouse[ _ddx ][ _ddy ] == 0 ) {
				_robot[0] = _dx;
				_robot[1] = _dy;
				
				_warehouse[ _dx ][ _dy ] = 0;
				_warehouse[ _ddx ][ _ddy ] = 2;
			}
		}
		
		
	}
	
	var _answer = 0;
	for( var yy = 0; yy < array_length(_warehouse[0]); yy++ ) {
		for( var xx = 0; xx < array_length(_warehouse); xx++ ) {
			if( _warehouse[xx][yy] == 2 ) {
				_answer += xx + ( 100 * yy );
			}
		}
	}
	
	return _answer;
}

function day15_part2(input){
	var _robot = input[2],
		_warehouse = input[4],
		_instructions = input[0];
	
	
	var _move, _move_lut,
		_rx, _ry,
		_dx, _dy,
		_ddx, _ddy,
		_c;
	
	_move_lut[0] = [1,0];
	_move_lut[1] = [0,1];
	_move_lut[2] = [-1,0];
	_move_lut[3] = [0,-1];
	
	function boxes_can_move( grid, xx, yy, dir ) {
		var _left = grid[xx][yy+dir],
			_right = grid[xx+1][yy+dir];
		
		// If there's wall behind either half of the box, return false
		if( _left == 1 || _right == 1 ) {
			return false;
		}
		
		// If the box behind current one is aligned on x-axis
		if( _left == 2 ) {
			return boxes_can_move( grid, xx, yy+dir, dir );
		}
		
		// Handle boxes offset by 1
		if( _left == 3 ) { // if offset to left
			if( !boxes_can_move( grid, xx-1, yy+dir, dir ) ) return false;
		}
		
		if( _right == 2 ) { // if offset to right
			if( !boxes_can_move( grid, xx+1, yy+dir, dir ) ) return false;
		}
		
		return true;
	}
	
	function push_box( grid, xx, yy, dir ) {
		var _left = grid[xx][yy],
			_right = grid[xx+1][yy];
		
		// If aligned on x-axis
		if( _left == 2 ) {
			push_box( grid, xx, yy+dir, dir );
			
			grid[xx][yy] = 0;
			grid[xx+1][yy] = 0;
		
			grid[xx][yy+dir] = 2;
			grid[xx+1][yy+dir] = 3;
		}
		
		// Offset to left
		if( _left == 3 ) {
			push_box( grid, xx-1, yy+dir, dir );
			
			grid[xx-1][yy] = 0;
			grid[xx][yy] = 0;
		
			grid[xx-1][yy+dir] = 2;
			grid[xx][yy+dir] = 3;
		}
		
		// Offset to right
		if( _right == 2 ) {
			push_box( grid, xx+1, yy+dir, dir );
			
			grid[xx+1][yy] = 0;
			grid[xx+2][yy] = 0;
		
			grid[xx+1][yy+dir] = 2;
			grid[xx+2][yy+dir] = 3;
		}
		
	}
	
	buffer_seek( _instructions, buffer_seek_start, 0 );
	repeat( buffer_get_size(_instructions) ) {
		_move = buffer_read( _instructions, buffer_u8 );
		
		_rx = _robot[0];
		_ry = _robot[1];
		
		// Find next wanted position and what's in the corresponding cell
		_dx = _rx + _move_lut[_move][0];
		_dy = _ry + _move_lut[_move][1];
		_c = _warehouse[ _dx ][ _dy ];
		
		// If space is free, move in
		if( _c == 0 ) {
			_robot[0] = _dx;
			_robot[1] = _dy;
		
		// Otherwise attempt to move boxes
		} else if( _c == 2 || _c == 3 ) {
			var _moves = 0;
			
			// Move sideways, ez pez
			if( _move == 0 || _move == 2 ) {
				_ddx = _dx;
				_ddy = _dy;
				
				// Look for either a free space or a wall
				while( _warehouse[ _ddx ][ _ddy ] == 2 || _warehouse[ _ddx ][ _ddy ] == 3 ) {
					_ddx += _move_lut[_move][0]*2;
					_moves += 2;
				}
			
				if( _warehouse[ _ddx ][ _ddy ] == 0 ) {
					_robot[0] = _dx;
					_robot[1] = _dy;
					
					var _dir = _move_lut[_move][0] * -1;
					
					for( var j = 0; j < _moves; j++ ) {
						_warehouse[ _ddx + ( j * _dir ) ][_dy] = _warehouse[ _ddx + ( (j + 1) * _dir ) ][_dy];
					}
					
					_warehouse[ _dx ][ _dy ] = 0;
				}
			} else {
				// Move vertical *sweatsweat*
				if( boxes_can_move( _warehouse, (_c == 2 ? _dx : _dx-1), _dy, _move_lut[_move][1] ) ) {
					push_box( _warehouse, (_c == 2 ? _dx : _dx-1), _dy, _move_lut[_move][1] );
					
					_robot[0] = _dx;
					_robot[1] = _dy;
				}
			}
		}
	}
	
	var _answer = 0;
	for( var yy = 0; yy < array_length(_warehouse[0]); yy++ ) {
		for( var xx = 0; xx < array_length(_warehouse); xx++ ) {
			if( _warehouse[xx][yy] == 2 ) {
				_answer += xx + ( 100 * yy );
			}
		}
	}
	
	buffer_delete( _instructions );
	
	return _answer;
}