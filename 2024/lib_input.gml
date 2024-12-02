function input_string(file){
	var _b = buffer_load(file);
	var _str = buffer_read(_b,buffer_string);
	buffer_delete(_b);
	return _str;
}

function input_array( file, type = type_string ) {
	return string_split( string_strip( input_string( file ), "\r" ), "\n", type );
}