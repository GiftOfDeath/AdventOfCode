function string_char_at_is(str,index,char){
	return string_char_at(str,index) == char;
}

function string_char_at_is_digit(str,index){
	var _byte = string_byte_at(str,index);
	return _byte >= 48 && _byte <= 57;
}

function string_strip(str,substr) {
	if( !is_array(substr) ) {
		return string_replace_all(str, substr, "");
	}else{
		for( var i = 0; i < array_length(substr); i++ ) {
			str = string_replace_all(str, substr[i], "");
		}
		
		return str;
	}
}

#macro type_string 0
#macro type_real   1

function string_split_numbers( str, delimiter, remove_empty = true, max_splits = 32000 ){
	var _arr = string_split( str, delimiter, remove_empty, max_splits ),
		_arr_length = array_length( _arr );
	
	for( var i = 0; i < _arr_length; i++ ) {
		_arr[i] = real( _arr[i] );
	}
	
	return _arr;
}


#macro contains_any      1
#macro contains_one      2
#macro contains_all      3
#macro contains_at_least 4
#macro contains_exactly  5
#macro contains_at_most  6

/// @function string_contains( str, substr, contains, n )
/// @param str
/// @param substr
/// @param contains
/// @param n
function string_contains() {
	var contains = ( argument_count < 3 ) ? contains_any : argument[2];
	var _n       = ( argument_count < 4 ) ? 0 : argument[2];
		
	var str = argument[0],
		substr = argument[1];
	
	if( !is_array(substr) ) {
		substr = [substr];
	}
	
	var _count = 0;
	for( var i = 0; i < array_length(substr); i++ ) {
		if( string_pos( substr[i], str ) > 0 ) {
			_count++;
			
			if( contains == contains_any ) return true;
			if( contains == contains_at_least && _count == _n ) return true;
			
			if( contains == contains_one      && _count > 1 ) return false;
			if( contains == contains_at_most  && _count > _n ) return false;
		}
	}
	
	if( contains == contains_all && array_length(substr) == _count ) return true;
	
	return false;
}