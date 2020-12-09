#macro contains_one 0
#macro contains_any 1
#macro contains_all 2

function map_contains_key( map, values, contains ){
	var _n = 0,
		_total;
	if( is_array(values) ) {
		_total = array_length(values);
		for( var i = 0; i < _total; i++ ) {
			if( !is_undefined(map[? values[i]]) ) {
				_n++;
				
				if( contains == contains_any ) return true;
			}
		}
	}else{
		_total = ds_list_size(values);
		for( var i = 0; i < _total; i++ ) {
			if( !is_undefined(map[? values[| i]]) ) {
				_n++;
				
				if( contains == contains_any ) return true;
			}
		}
	}
	
	switch( contains ) {
		case contains_one: if( _n == 1 ) return true;
		case contains_all: if( _n == _total ) return true;
	}
	
	return false;
}