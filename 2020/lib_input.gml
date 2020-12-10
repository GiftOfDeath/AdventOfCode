// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function input_array(file,data_type) {
	var _file = file_text_open_read(file),
		_arr = [],
		_n = 0;
	
	while( !file_text_eof(_file) ) {
		_arr[_n++] = ( data_type == type_real ? real(string_strip( file_text_readln(_file), ["\r","\n"] )) : string_strip( file_text_readln(_file), ["\r","\n"] ) );
	}
	
	return _arr;
}

function input_list(file,data_type) {
	var _file = file_text_open_read(file),
		_list = ds_list_create();
	
	while( !file_text_eof(_file) ) {
		ds_list_add( _list, data_type == type_real ? real(string_strip( file_text_readln(_file), ["\r","\n"] )) : string_strip( file_text_readln(_file), ["\r","\n"] ) );
	}
	
	return _list;
}