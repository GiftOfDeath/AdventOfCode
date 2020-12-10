function day7_part1( bags ) {
	var _key = ds_map_find_first(bags),
		_last = ds_map_find_last(bags),
		_currentLayer = ["shiny gold"],
		_nextLayer = [],
		_validBags = ds_list_create(),
		_answer;
	
	while(1) {
		if( bags[? _key] != -1 && map_contains_key( bags[? _key], _currentLayer, contains_any ) ) {
			_nextLayer[array_length(_nextLayer)] = _key;
		}
		
		if( _key == _last ) { 
			if( array_length(_nextLayer) == 0 ) {
				break; 
			}
			
			for( var i = 0; i < array_length( _nextLayer ); i++ ) {
				if( ds_list_find_index( _validBags, _nextLayer[i] ) == -1 ) {
					ds_list_add( _validBags, _nextLayer[i] );
				}
			}
			
			_currentLayer = _nextLayer;
			_nextLayer = [];
			_key = ds_map_find_first(bags);
		}else{
			_key = ds_map_find_next(bags,_key);
		}
	}
	
	_answer = ds_list_size(_validBags);
	ds_list_destroy(_validBags);
	return _answer;
}

function day7_part2( bags, bag ) {
	if( bags[? bag] == -1 ) return 0;
	
	var _key = ds_map_find_first( bags[? bag] ),
		_last = ds_map_find_last( bags[? bag] ),
		_sum = 0;
	
	while(1) {
		_sum += bags[? bag][? _key] + (bags[? bag][? _key] * day7_part2( bags, _key ));
		
		if( _key == _last ) break;
		_key = ds_map_find_next( bags[? bag], _key );
	}
	
	return _sum;
}

function day7_input(){
	var _file = file_text_open_read("7.txt"),
		_bags = ds_map_create(),
		_contents = [],
		_line,
		_bag,
		_innerBag;
	
	while( !file_text_eof(_file) ) {
		_line = string_replace( file_text_readln(_file), "\n", "" );
		_line = string_replace_all( _line, " bags", "" );
		_line = string_replace_all( _line, " bag", "" );
		_bag = string_copy(_line, 1, string_pos("contain", _line)-2);
		_line = string_delete(_line,1,string_length(_bag));
		_line = string_replace( _line, " contain", "" );
		_bags[? _bag] = ds_map_create();
		
		_contents = string_split( string_replace(_line, ".", ""), ",", type_string );
		
		for( var i = 0; i < array_length(_contents); i++ ) {
			if( string_pos( "no other",  _contents[i] ) <= 0 ) {
				_innerBag = string_replace( _contents[i], " ", "" );
				_innerBag = string_delete( _innerBag, 1, string_pos( " ", _innerBag ) ); 
				_bags[? _bag][? _innerBag] = real(string_digits(_contents[i]));
			}else{
				ds_map_destroy(_bags[? _bag]);
				_bags[? _bag] = -1;
			}
		}
	}
	
	return _bags;
}