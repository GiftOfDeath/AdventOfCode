// VM:
//  P1 solve avg. time: 2.72ms
//  P2 solve avg. time: 2.85ms

// YYC: TBD, can't get working

function day_01_input(){
	var _arr = [],
		_f = file_text_open_read( "01.txt" );
	while( !file_text_eof( _f ) ) {
		_arr[ array_length(_arr) ] = real( string_digits( file_text_readln( _f ) ) );
	}
	
	file_text_close(_f);
	return _arr;
}

function day_01_part1(input) {
	var _l = array_length(input),
		_c = 0;
		
	for( var i = 0; i < _l-1; i++ ) {
		_c += (input[i] < input[i+1]);
	}

	return _c;
}

function day_01_part2(input) {
	var _l = array_length(input),
		_c = 0;
		
	for( var i = 0; i < _l-3; i++ ) {
		_c += ( (input[i]+input[i+1]+input[i+2]) < (input[i+1]+input[i+2]+input[i+3]) );
	}

	return _c;
}