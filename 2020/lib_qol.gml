// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function log(){
	var _str = string(argument[0]);
	if( argument_count > 1 ) {
		for( var i = 1; i < argument_count; i++ ) {
			_str += ", "+string(argument[i]);
		}
	}
	
	show_debug_message( _str );
}