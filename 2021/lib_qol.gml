function log(){
	var _str = string(argument[0]);
	if( argument_count > 1 ) {
		for( var i = 1; i < argument_count; i++ ) {
			_str += ", "+string(argument[i]);
		}
	}
	
	show_debug_message( _str );
}

function log_array( array ) {
	for( var i = 0; i < array_length( array ); i++ ) {
		show_debug_message( array[i] );
	}
}