#macro type_real 0
#macro type_string 1

function string_split( str, delimiter, data_type ){
	var _arr = [],
		_start = 1,
		_end = 0,
		_arr_length,
		_del_length = string_length(delimiter);
	
	while( _end < string_length(str) ) {
		_arr_length = array_length(_arr);
		_end = string_pos_ext( delimiter, str, _start );
		
		if( _end == 0 ) { 
			_end = string_length(str)+1; 
		}
		
		_arr[_arr_length] = string_copy( str, _start, _end-_start );
		_start = _end+_del_length;
		
		if( data_type == type_real ) {
			_arr[_arr_length] = real(_arr[_arr_length]);
		}
	}
	
	return _arr;
}

function string_strip( str, substr) {
	if( !is_array(substr) ) {
		substr = [substr];
	}
	
	for( var i = 0; i < array_length(substr); i++ ) {
		str = string_replace_all( str, substr[i], "" );
	}
	
	return str;
}

function string_char_at_is( str, index, char ) {
	return ( string_char_at( str, index ) == char );
}
