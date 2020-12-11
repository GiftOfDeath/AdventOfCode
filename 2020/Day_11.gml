// VM: 
//   P1 execution time: 8433.77ms
//   P2 execution time: 17923.43ms
// YYC:
//   P1 solve avg. time: 1334.11ms
//   P2 solve avg. time: 4073.74ms

// rules = day11_get_sum_p1 or day11_get_sum_p2
// neighbours = how many neighbours it takes to free a seat
function day11(input,rules,neighbours) {
	var _occupied = 0,
		_prevRound,
		_prevInput = [];
	
	do {
		_prevRound = _occupied;
		_occupied = 0;
		
		for( var i = 0; i < array_length(input); i++ ) {
			for( var j = 0; j < array_length(input[i]); j++ ) {
				_prevInput[i][j] = input[i][j];
			}
		}
		
		for( var i = 0; i < array_length( input ); i++ ) {
			for( var j = 0; j < array_length( input[i] ); j++ ) {
				if( input[i][j] > -1 )
					input[i][j] = rules( i, j, _prevInput, neighbours );
					
				if( input[i][j] ) _occupied++;
			}
		}
	} until ( _occupied == _prevRound );
	
	return _occupied;
}

function day11_get_sum_p1( xx, yy, array, neighboursMax ) {
	var _lb = 0, _rb = array_length(array[0])-1, // left and right bound of the grid
		_ub = 0, _bb = array_length(array)-1;    // top and bottom -||-
		
	var _neighbours = 0;
	for( var i = max( xx-1, _lb ); i <= min(xx+1,_bb); i++ ) {
		for( var j = max( yy-1, _ub ); j <= min( yy+1, _rb ); j++ ) {
			if( i == xx && j == yy ) { continue; }
			
			if( array[i][j] == 1 ) _neighbours++;
			
			switch( array[xx][yy] ) {
				case 0: 
						if( _neighbours > 0 ) return 0;	
					break;
				case 1: 
						if( _neighbours >= neighboursMax ) return 0; 
					break;
			}
		}
	}
	
	return 1; // seat becomes occupied
}

function day11_get_sum_p2( xx, yy, array, neighboursLimit ) {
	var _lb = 0, _rb = array_length(array[0])-1, // left and right bound of the grid
		_ub = 0, _bb = array_length(array)-1;    // top and bottom -||-
		
	var _neighbours = 0,
		i, j, _dir = 0,
		_xdir,
		_ydir;
	
	repeat( 8 ) {
		_xdir = round(lengthdir_x(1,_dir));
		_ydir = round(lengthdir_y(1,_dir));
		i = xx+_xdir;
		j = yy+_ydir;
		while( in_range( _ub, _bb, i ) && in_range( _lb, _rb, j ) ) {
			if( i == xx && j == yy ) { continue; }
			if( array[i][j] > -1 ) { 
				if( array[i][j] ) {
					_neighbours++;
				}
			
				switch( array[xx][yy] ) {
					case 0: 
							if( _neighbours > 0 ) return 0;	
						break;
					case 1: 
							if( _neighbours >= neighboursLimit ) return 0; 
						break;
				}
				
				break;
			}
			
			i += _xdir;
			j += _ydir;
		}
		
		_dir += 45;
	}
	
	return 1; // seat becomes occupied
}

function day11_draw(input) {
	var _line,
		_state = [".","L","#"];
	for( var i = 0; i < array_length(input); i++ ) {
		_line = "";
		for( var j = 0; j < array_length(input[i]); j++ ) {
			_line += _state[input[i][j]+1];
		}
		
		show_debug_message( _line );
	}
	
	show_debug_message("------------------");
}

function day11_input(file) {
	var _arr = input_array( file, type_string ),
		_row;
	
	for( var i = 0; i < array_length(_arr); i++ ) {
		_row = [];
		for( var j = 1; j <= string_length( _arr[i] ); j++ ) {
			switch( string_char_at( _arr[i], j ) ) {
				case "L": _row[j-1] = 0; break;
				case ".": _row[j-1] = -1; break;
			}
		}
		
		_arr[i] = _row;
	}
	
	return _arr;
}