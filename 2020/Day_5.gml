// VM:
//   P1 solve avg. time: 22.08ms
//   P2 solve avg. time: 21.89ms
// YYC:
//   P1 solve avg. time: 12.64ms
//   P2 solve avg. time: 13.16ms

function day5_part1(){
	var _file = file_text_open_read("5.txt"),
		_highest_pass = 0,
		_pass;
	
	while( !file_text_eof(_file) ) {
		_pass = boarding_pass( string_replace( file_text_readln(_file), "\n", "" ) );
		if( _pass[2] > _highest_pass ) {
			_highest_pass = _pass[2];
		}
	}
	
	return _highest_pass;
}

function day5_part2(){
	var _file = file_text_open_read("5.txt"),
		_list = ds_list_create(),
		_pass;
	
	while( !file_text_eof(_file) ) {
		_pass = boarding_pass( string_replace( file_text_readln(_file), "\n", "" ) );
		ds_list_add( _list, _pass[2] );
	}
	
	ds_list_sort( _list, true );
	
	var _my_pass = _list[| 0];
	for( var i = 1; i < ds_list_size(_list); i++ ) {
		if( _list[| i] - _my_pass > 1 ) {
			_my_pass++;
			break;
		}
		
		_my_pass = _list[| i];
	}
	
	return _my_pass;
}

function boarding_pass( str ) {
	var _row = 0,
		_range1 = 128,
		_column = 0,
		_range2 = 8,
		_chr;
		
	for( var i = 1; i <= string_length(str); i++ ) {
		_chr = string_char_at(str,i);
		
		if( i < 8 ) {
			_range1 = _range1 div 2;
			
			if( _chr == "B" ) {
				_row += _range1;
			}
			
		}else{
			_range2 = _range2 div 2;
			
			if( _chr == "R" ) {
				_column += _range2;
			}
		}
		
	}
		
	return [_row,_column,_row*8+_column];
}