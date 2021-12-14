// VM:
//  P1 solve avg. time: 5.285ms; median: 4.637ms
//  P2 solve avg. time: 21.695ms; median: 20.116ms
//  Input parse time: 19.810ms; median: 19.407ms

// YYC: 
//  P1 solve avg. time: 3.860ms; median: 3.512ms
//  P2 solve avg. time: 8.562ms; median: 7.994ms
//  Input parse time: 12.187ms; median: 11.500ms

// This is a really wild one because I figured I'd try to do it without
// using a 2d array or grid xD
// The dots are stored in a map (key:value pairs)

#macro X 0
#macro Y 1

function day_13_input( file ){
	var _dots = [],
		_folds = [],
		_f = file_text_open_read( file );
	
	var _line,
		_i = 0;
	while( true ) {
		_line = string_strip( file_text_readln( _f ), ["\n","\r"] );
		
		if( _line == "" ) break;
		
		_i++;
		array_push( _dots, string_split( _line, ",", type_real ) );
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
		_folds = input[1],
		_newDot,
		_finalDots = ds_map_create();
	
	var _l = array_length( _dots );
	for( var i = 0; i < _l; i++ ) {
		_newDot = fold_dot( _dots[i], _folds[0] );
		
		_finalDots[? string(_newDot[0])+","+string(_newDot[1])] = _newDot;
	}
	
	var _answer = ds_map_size( _finalDots );
	
	ds_map_destroy( _finalDots );
	
	return _answer;
}

function day_13_part2(input) {
	var _dots = input[0],
		_folds = input[1],
		_newDot,
		_finalDots = ds_map_create();
	
	var _l = array_length( _dots ),
		_totalFolds = array_length( _folds );
	for( var i = 0; i < _l; i++ ) {
		_newDot = _dots[i];
		for( var j = 0; j < _totalFolds; j++ ) {
			_newDot = fold_dot( _newDot, _folds[j] );
		}
		
		_finalDots[? string(_newDot[0])+","+string(_newDot[1])] = _newDot;
	}
	
	var _display = [],
		_dot;
		
	for( var key = ds_map_find_first( _finalDots ); key != undefined; key = ds_map_find_next( _finalDots, key ) ) {
		_dot = _finalDots[? key];
		
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
	
	ds_map_destroy( _finalDots );
	return _answer;
}

function fold_dot( dot, fold ) {
	gml_pragma("forceinline");
	if( fold[0] == X ) {
		if( dot[0] > fold[1] )
			return [ fold[1]-(dot[0]-fold[1]) ,dot[1] ];
		else
			return dot;
	}
	
	if( dot[1] > fold[1] )
		return [ dot[0], fold[1]-(dot[1]-fold[1]) ];
	else
		return dot;
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