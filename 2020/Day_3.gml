function day3_part1(){
	var _file = file_text_open_read( "3.txt" ),
		_line = "",
		_trees = 0,
		_x = 1;
	while( !file_text_eof( _file ) ) {
		_line = string_replace(file_text_readln( _file ),"\n","");
		_trees += string_char_at_is( _line, _x, "#" );
		_x = wrap( 1, string_length( _line ), _x+3 );
	}
	
	return _trees;
}

function day3_part2(){
	var _file = file_text_open_read( "3.txt" ),
		_line = "",
		_line_length = 0,
		_trees = [0,0,0,0,0],
		_x = [1,1,1,1,1],
		_y = 1;
	while( !file_text_eof( _file ) ) {
		_line = string_replace(file_text_readln( _file ),"\n","");
		_line_length = string_length( _line );
		
		for( var i = 0; i < 4; i++ ) {
			_trees[i] += string_char_at_is( _line, _x[i], "#" );
			_x[i] = wrap( 1, _line_length, _x[i]+1+i*2 );
		}
		
		if( _y mod 2 == 1 ) {
			_trees[4] += string_char_at_is( _line, _x[4], "#" );
			_x[4] = wrap( 1, _line_length, _x[4]+1 );
		}
		
		_y++;
	}
	
	show_debug_message( _trees );
	return array_product( _trees );
}