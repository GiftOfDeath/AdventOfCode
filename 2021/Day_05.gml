// VM:
//  P1 solve avg. time: 233.53ms
//  P2 solve avg. time: 395.60ms

// YYC: TBD, can't get working

function day_05_input(){
	var _arr = [], _tmp,
		_f = file_text_open_read( "05.txt" );
	
	var _highestX = 0,
		_highestY = 0;
	while( !file_text_eof( _f ) ) {
		 _tmp = string_split( string_replace( file_text_readln( _f ), " -> ", "," ), ",", type_real );
		 _arr[ array_length(_arr) ] = _tmp;
	 
		 _highestX = max( _highestX, _tmp[0], _tmp[2] );
		 _highestY = max( _highestY, _tmp[1], _tmp[3] );
	}
	
	file_text_close(_f);
	return [_arr,ds_grid_create(_highestX+1,_highestY+1)];
}

function day_05_part1( input ) {
	var _lines = input[0],
		_grid = input[1];
		
	ds_grid_clear( _grid, 0 );
	
	var _l = array_length(_lines),
		_count = 0;
		
	for( var i = 0; i < _l; i++ ) {
		// Check if the line is horizontal or vertical, if not skip it
		if !( _lines[i][0] == _lines[i][2] || _lines[i][1] == _lines[i][3] ) continue;
		
		// Find how long the line is and which direction it points
		var _lineL = max( abs( _lines[i][0]-_lines[i][2] ), abs( _lines[i][1]-_lines[i][3] ) )+1, 
			_xDir = sign( _lines[i][2]-_lines[i][0] ),
			_yDir = sign( _lines[i][3]-_lines[i][1] );
		
		// Add the line to the grid while also adding to the count so we don't need 
		// to go through the entire grid later on
		for( var j = 0; j < _lineL; j++ ) {
			_grid[# _lines[i][0]+(j*_xDir), _lines[i][1]+(j*_yDir)]++;
			if( _grid[# _lines[i][0]+(j*_xDir), _lines[i][1]+(j*_yDir)] == 2 ) {
				_count++;
			}
		}
	}
	
	return _count;
}


function day_05_part2( input ) {
	var _lines = input[0],
		_grid = input[1];
		
	ds_grid_clear( _grid, 0 );
	
	var _l = array_length(_lines),
		_count = 0;
		
	for( var i = 0; i < _l; i++ ) {
		// Find how long the line is and which direction it points
		var _lineL = max( abs( _lines[i][0]-_lines[i][2] ), abs( _lines[i][1]-_lines[i][3] ) )+1, 
			_xDir = sign( _lines[i][2]-_lines[i][0] ),
			_yDir = sign( _lines[i][3]-_lines[i][1] );
		
		// Add the line to the grid while also adding to the count so we don't need 
		// to go through the entire grid later on
		for( var j = 0; j < _lineL; j++ ) {
			_grid[# _lines[i][0]+(j*_xDir), _lines[i][1]+(j*_yDir)]++;
			if( _grid[# _lines[i][0]+(j*_xDir), _lines[i][1]+(j*_yDir)] == 2 ) {
				_count++;
			}
		}
	}
	
	return _count;
}
