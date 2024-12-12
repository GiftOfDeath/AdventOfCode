// VM:
//   Input parsing time: 11.77ms
//   P1 solve avg. time: 45.47ms
//   P2 solve avg. time: 98.70ms
// YYC:
//   Input parsing time: 4.46ms
//   P1 solve avg. time: 11.91ms
//   P2 solve avg. time: 15.15ms

function day12_input(file) {
	var _input = string_split( string_strip( input_string( file ), "\r" ), "\n", type_string ),
		_str;
		
	var _map_grid   = [],
		_n;
		
	// Construct a 2d array of the map [x][y] for ease
	for( var i = 0; i < array_length( _input ); i++ ) {
		_str = _input[i];
		for( var j = 1; j <= string_length( _str ); j++ ) {
			_n = string_byte_at(_str, j)-65; // A = 0 ... Z = 25
			_map_grid[j-1][i] = _n;
		}
	}
	
	return _map_grid;
}

function day12_part1(input){
	var _fields_map = input;
	
	// Recursively find both the area and perimeter of the field
	function get_fencing_price( map, plant, xx, yy, width, height ) {
		var _area = 1,
			_border = 0,
			_arr = [];
			
		map[xx,yy] += 32;
		
		if( xx+1 < width && map[xx+1][yy] == plant ) {
			_arr = get_fencing_price( map, plant, xx+1, yy, width, height );
			_area += _arr[0];
			_border += _arr[1];
		} else if( xx+1 >= width || map[xx+1][yy] & 31 != plant ) {
			_border++;
		}
		
		if( xx > 0 && map[xx-1][yy] == plant ) {
			_arr = get_fencing_price( map, plant, xx-1, yy, width, height );
			_area += _arr[0];
			_border += _arr[1];
		} else if( xx == 0 || map[xx-1][yy] & 31 != plant ) {
			_border++;
		}
		
		if( yy+1 < width && map[xx][yy+1] == plant ) {
			_arr = get_fencing_price( map, plant, xx, yy+1, width, height );
			_area += _arr[0];
			_border += _arr[1];
		} else if( yy+1 >= width || map[xx][yy+1] & 31 != plant ) {
			_border++;
		}
		
		if( yy > 0 && map[xx][yy-1] == plant ) {
			_arr = get_fencing_price( map, plant, xx, yy-1, width, height );
			_area += _arr[0];
			_border += _arr[1];
		} else if( yy == 0 || map[xx][yy-1] & 31 != plant ) {
			_border++;
		}
		
		_arr = [_area,_border];
		return _arr;
	}
	
	var _w = array_length(_fields_map),
		_h = array_length(_fields_map[0]),
		_arr,
		_answer = 0;
	
	for( var yy = 0; yy < _h; yy++ ) {
		for( var xx = 0; xx < _w; xx++ ) {
			if( _fields_map[xx][yy] & 32 == 0 ) {
				_arr = get_fencing_price( _fields_map, _fields_map[xx][yy], xx, yy, _w, _h );
				_answer += _arr[0]*_arr[1];
			}
		}
	}
	
	return _answer;
}

function day12_part2(input){
	var _fields_map = input;
	
	// Recursively find the area and the number of sides (actually corners because
	// a polygon with n-sides also has n-corners )
	function get_fencing_price( map, plant, xx, yy, width, height ) {
		var _area = 1,
			_corners = 0,
			_arr = [];
			
		map[xx,yy] += 64;
		
		var _in_tb = yy > 0,		// in top bound
			_in_bb = yy+1 < height, // in bottom bound
			_in_rb = xx+1 < width,  // in right bound
			_in_lb = xx > 0;		// in left bound
		
		if( _in_rb && map[xx+1][yy] == plant ) {
			_arr = get_fencing_price( map, plant, xx+1, yy, width, height );
			_area += _arr[0];
			_corners += _arr[1];
		} 
		
		if( _in_lb && map[xx-1][yy] == plant ) {
			_arr = get_fencing_price( map, plant, xx-1, yy, width, height );
			_area += _arr[0];
			_corners += _arr[1];
		} 
		
		if( _in_bb && map[xx][yy+1] == plant ) {
			_arr = get_fencing_price( map, plant, xx, yy+1, width, height );
			_area += _arr[0];
			_corners += _arr[1];
		}
		
		if( _in_tb && map[xx][yy-1] == plant ) {
			_arr = get_fencing_price( map, plant, xx, yy-1, width, height );
			_area += _arr[0];
			_corners += _arr[1];
		}
		
		var _neighbours = 0;
		
		plant = plant & 31;
		
		// Use binary masks to find the corners
		_neighbours += ( _in_rb && map[xx+1][yy] & 31 == plant ) ? 1 : 0;				// right		1
		_neighbours += ( _in_rb && _in_bb && map[xx+1][yy+1] & 31 == plant ) ? 2 : 0;	// bottom-right	2
		_neighbours += ( _in_bb && map[xx][yy+1] & 31 == plant ) ? 4 : 0;				// bottom		4
		_neighbours += ( _in_lb && _in_bb && map[xx-1][yy+1] & 31 == plant ) ? 8 : 0;	// bottom-left	8
		_neighbours += ( _in_lb && map[xx-1][yy] & 31 == plant ) ? 16 : 0;				// left			16
		_neighbours += ( _in_lb && _in_tb && map[xx-1][yy-1] & 31 == plant ) ? 32 : 0;	// top-left		32
		_neighbours += ( _in_tb && map[xx][yy-1] & 31 == plant ) ? 64 : 0;				// top			64
		_neighbours += ( _in_rb && _in_tb && map[xx+1][yy-1] & 31 == plant ) ? 128 : 0;	// top-right	128
		
		
		if( _neighbours == 0 ) {			// No neighbours = 4 corners
			_corners += 4;
		} else if ( _neighbours < 255 ) {	// completely surrounded = 0 corners
			
			// If not completely surrounded check for corners
			
			// Check for outer corners
			if( _neighbours & 65 == 0 )		// top-right
				_corners++;
			
			if( _neighbours & 5 == 0 )		// bottom-right
				_corners++;
			
			if( _neighbours & 20 == 0 )		// bottom-left
				_corners++;
				
			if( _neighbours & 80 == 0 )		// top-left
				_corners++;
			
			// Check for inner corners
			if( _neighbours & 65 == 65 && _neighbours & 128 == 0 )	// top-right
				_corners++;
				
			if( _neighbours & 5 == 5 && _neighbours & 2 == 0 )		// bottom-right
				_corners++;
				
			if( _neighbours & 20 == 20 && _neighbours & 8 == 0 )	// bottom-left
				_corners++;
				
			if( _neighbours & 80 == 80 && _neighbours & 32 == 0 )	// top-left
				_corners++;
		}
		
		_arr = [_area,_corners];
		return _arr;
	}
	
	var _w = array_length(_fields_map),
		_h = array_length(_fields_map[0]),
		_arr,
		_answer = 0;
	
	for( var yy = 0; yy < _h; yy++ ) {
		for( var xx = 0; xx < _w; xx++ ) {
			if( _fields_map[xx][yy] & 64 == 0 ) {
				_arr = get_fencing_price( _fields_map, _fields_map[xx][yy], xx, yy, _w, _h );
				_answer += _arr[0]*_arr[1];
			}
		}
	}
	
	return _answer;
}