// VM:
//  P1 solve avg. time: 16.772ms; median: 16.721ms
//  P2 solve avg. time: 66.418ms; median: 66.393ms
//  Input parse time: 14.374ms; median: 14.295ms

// YYC: 
//  P1 solve avg. time: 15.639ms; median: 15.233ms
//  P2 solve avg. time: 59.951ms; median: 59.212ms
//  Input parse time: 8.610ms; median: 8.429ms

// This is a really wild one because I figured I'd try to do it without
// using a 2d array or grid xD
// The dots are stored in a map (key:value pairs)

#macro X 0
#macro Y 1

function day_13_input( file ){
	var _dots = ds_map_create(),
		_folds = [],
		_f = file_text_open_read( file );
	
	var _line;
	while( true ) {
		_line = string_strip( file_text_readln( _f ), ["\n","\r"] );
		
		if( _line == "" ) break;
		
		_dots[? _line] = string_split( _line, ",", type_real );
	}
	
	var _axis,
		_value;
	while( !file_text_eof( _f ) ) {
		_line = string_strip( file_text_readln( _f ), ["\n","\r"] );
		
		// x = 120 in ASCII table
		_axis = ( string_byte_at( _line, 12 ) == 120 ) ? X : Y;
		_value = string_digits( _line );
		
		array_push( _folds, [ _axis, real(_value) ] );
	}
	
	file_text_close( _f );
	
	return [ _dots, _folds ];
}

function day_13_part1(input) {
	var _dots = input[0],
		_folds = input[1];
	
	ds_map_size( _dots );
	
	if( _folds[0][0] == X ) {
		fold_xaxis( _dots, _folds[0][1] );
	}else{
		fold_yaxis( _dots, _folds[0][1] );
	}
	
	var _answer = ds_map_size( _dots );
	ds_map_destroy( _dots );
	return _answer;
}

function day_13_part2(input) {
	var _dots = input[0],
		_folds = input[1];
	
	var _l = array_length(_folds);
	for( var i = 0; i < _l; i++ ) {
		if( _folds[i][0] == X ) {
			fold_xaxis( _dots, _folds[i][1] );
		}else{
			fold_yaxis( _dots, _folds[i][1] );
		}
	}
	
	var _display = [],
		_dot;
	for( var key = ds_map_find_first( _dots ); key != undefined; key = ds_map_find_next( _dots, key ) ) {
		_dot = _dots[? key];
		
		if( array_length(_display) <= _dot[1] ) {
			_display[_dot[1]] = "";
		}
		
		if( !is_string( _display[ _dot[1]] ) ) {
			_display[ _dot[1]] = "";
		}
		
		while( string_length( _display[_dot[1]] ) < _dot[0]+1 ) {
			_display[_dot[1]] += " ";
		}
		
		_display[_dot[1]] = string_delete( _display[_dot[1]], _dot[0]+1, 1 );
		_display[_dot[1]] = string_insert( "█", _display[_dot[1]], _dot[0]+1 );
	}
	
	var _answer = "";
	_l = array_length(_display);
	for( var i = 0; i < _l; i++ ) {
		_answer += "\n"+_display[i];
	}
	
	ds_map_destroy( _dots );
	return _answer;
}

function fold_xaxis( map, xx ) {
	var _newKey,
		_dotX,
		_newDots = [];
	for( var _key = ds_map_find_first(map); _key != undefined; _key = ds_map_find_next( map, _key ) ) {
		_dotX = map[? _key][0];
		if( _dotX > xx ) {
			_newKey = xx - ( _dotX - xx );
			array_push( _newDots, [_key, _newKey, map[? _key][1]] );
		}
	}
	
	var _l = array_length( _newDots );
	for( var i = 0; i < _l; i++ ) {
		map[? string(_newDots[i][1])+","+string(_newDots[i][2])] = [_newDots[i][1],_newDots[i][2]];
		ds_map_delete( map, _newDots[i][0] );
	}
}

function fold_yaxis( map, yy ) {
	var _newKey,
		_dotY,
		_newDots = [];
	for( var _key = ds_map_find_first(map); _key != undefined; _key = ds_map_find_next( map, _key ) ) {
		_dotY = map[? _key][1];
		if( _dotY > yy ) {
			_newKey = yy - ( _dotY - yy );
			array_push( _newDots, [_key, map[? _key][0], _newKey] );
		}
	}
	
	var _l = array_length( _newDots );
	for( var i = 0; i < _l; i++ ) {
		map[? string(_newDots[i][1])+","+string(_newDots[i][2])] = [_newDots[i][1],_newDots[i][2]];
		ds_map_delete( map, _newDots[i][0] );
	}
}