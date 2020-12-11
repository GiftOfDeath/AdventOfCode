// VM:
//   P1 solve avg. time: 23.44ms
//   P2 solve avg. time: 25.74ms
// YYC:
//   P1 solve avg. time: 10.87ms
//   P2 solve avg. time: 10.50ms
function day2_part1(){
	var _f = file_text_open_read("2.txt"),
		_valid = 0,
		_data,
		_range = [0,0];
		
	while( !file_text_eof(_f) ) {
		_data = string_split( file_text_readln(_f), " ", type_string );
		
		_range = string_split( _data[0], "-", type_real );
		_valid += in_range( _range[0], _range[1], string_count( string_copy( _data[1], 1, 1 ), _data[2] ) );
	}
	
	return _valid;
}

function day2_part2(){
	var _f = file_text_open_read("2.txt"),
		_valid = 0,
		_data,
		_positions = [0,0],
		_chr = "";
		
	while( !file_text_eof(_f) ) {
		_data = string_split( file_text_readln(_f), " ", type_string );
		
		_positions = string_split( _data[0], "-", type_real );
		_chr = string_copy( _data[1], 1, 1 );
		if( ( string_char_at_is( _data[2],_positions[0], _chr ) + 
			  string_char_at_is( _data[2],_positions[1], _chr ) ) == 1 ) {
			_valid++;
		}
	}
	
	return _valid;
}