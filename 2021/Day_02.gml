// VM:
//  P1 solve avg. time: 2.51ms; median: 2.37ms
//  P2 solve avg. time: 2.97ms; median: 2.80ms

// YYC: 
//  P1 solve avg. time: 1.83ms; median: 1.73ms
//  P2 solve avg. time: 2.19ms; median: 2.05ms

function day_02_input(){
	var _arr = [],
		_f = file_text_open_read( "02.txt" );
	while( !file_text_eof( _f ) ) {
		_arr[ array_length(_arr) ] = string( file_text_readln( _f ) );
	}
	
	file_text_close(_f);
	return _arr;
}

function day_02_part1(input) {
	var _x = 0,
		_y = 0;
	
	for( var i = 0; i < array_length(input); i++ ) {
		if( string_pos( "forward", input[i] ) > 0 ) {
			_x += string_digits(input[i]);
		}else if( string_pos( "up", input[i] ) > 0 ) {
			_y -= string_digits(input[i]);
		}else if( string_pos( "down", input[i] ) > 0 ) {
			_y += string_digits(input[i]);
		}
	}

	return ( "Pos: "+string(_x) +"; Depth: "+string(_y)+"; Answer: "+string(_x*_y) );	
}

function day_02_part2(input) {
	var _x = 0,
		_y = 0,
		_aim = 0;
	
	for( var i = 0; i < array_length(input); i++ ) {
		if( string_pos( "forward", input[i] ) > 0 ) {
			_x += string_digits(input[i]);
			_y += _aim*real(string_digits(input[i]));
		}else if( string_pos( "up", input[i] ) > 0 ) {
			_aim -= string_digits(input[i]);
		}else if( string_pos( "down", input[i] ) > 0 ) {
			_aim += string_digits(input[i]);
		}
	}

	return ( "Pos: "+string(_x) +"; Depth: "+string(_y)+"; Answer: "+string(_x*_y) );
}