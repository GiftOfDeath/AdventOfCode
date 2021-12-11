// VM:
//  P1 solve avg. time: 47.20ms; median: 47.88ms
//  P2 solve avg. time: 56.18ms; median: 58.73ms

// YYC: 
//  P1 solve avg. time: 11.97ms; median: 10.51ms
//  P2 solve avg. time: 30.05ms; median: 25.92ms

function day_09_input(){
	var _grid = [],
		_f = file_text_open_read("09.txt"),
		_line,
		_h;
	
	while( !file_text_eof(_f) ) {
		_line = string_strip( file_text_readln(_f), ["\n","\r"] );
		_h = array_length(_grid);
		for( var i = 0; i < string_length(_line); i++ )
			_grid[_h][i] = real( string_char_at( _line, i+1 ) );
	}
	
	file_text_close( _f );
	return _grid;
}

function day_09_part1(input) {
	var _height = array_length(input),
		_width = array_length(input[0]),
		_sum = 0,
		_surrounding,
		_l,
		_lowPoints = []; // pass this over to part 2 to save some calculation time
	
	for( var i = 0; i < _height; i++ ) {
		for( var j = 0; j < _width; j++ ) {
			if( input[i][j] == 9 ) continue;
			
			_surrounding = [];
			
			if( i > 0 )         _surrounding[ array_length(_surrounding) ] = input[i-1][j];
			if( i < _height-1 ) _surrounding[ array_length(_surrounding) ] = input[i+1][j];
			if( j > 0 )         _surrounding[ array_length(_surrounding) ] = input[i][j-1];
			if( j < _width-1 )  _surrounding[ array_length(_surrounding) ] = input[i][j+1];
			
			_l = array_length(_surrounding);
			for( var k = 0; k < _l; k++ ) {
				if( input[i][j] >= _surrounding[k] ) break;
				
				if( k == _l-1 ) {
					_sum += input[i][j]+1;
					_lowPoints[ array_length(_lowPoints) ] = [i,j];
				}
			}
		}
	}
	
	return [_sum,_lowPoints];
}

function day_09_part2( input, lowPoints ) {
	var _seaFloor = json_parse(json_stringify(input)),
		_basinSizes = [];
	
	function flood_fill ( xx, yy, grid ) {
		var _sum = 1;
		
		grid[@ xx][@ yy] = 10;
		
			
		if( xx > 0 && grid[xx-1,yy] < 9 )
			_sum += flood_fill( xx-1, yy, grid );
			
		if( xx < array_length(grid)-1 && grid[xx+1,yy] < 9 ) 
			_sum += flood_fill( xx+1, yy, grid );
			
		if( yy > 0 && grid[xx,yy-1] < 9 ) 
			_sum += flood_fill( xx, yy-1, grid );
			
		if( yy < array_length(grid[xx])-1 && grid[xx,yy+1] < 9 ) 
			_sum += flood_fill( xx, yy+1, grid );
		
		return _sum;
	}
	
	var _l = array_length(lowPoints);
	for( var i = 0; i < _l; i++ ) {
		_basinSizes[i] = flood_fill( lowPoints[i][0], lowPoints[i][1], _seaFloor );
	}
		
	array_sort( _basinSizes, false );
	var _product = _basinSizes[0]*_basinSizes[1]*_basinSizes[2];
	
	return _product;
}