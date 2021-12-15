// VM:
//  P1 solve avg. time: 4.737ms; median: 4.412ms
//  P2 solve avg. time: 19.843ms; median: 19.156ms
//  Input parse time: 1.686ms; median: 1.500ms

// YYC: 
//  P1 solve avg. time: 2.766ms; median: 2.694ms
//  P2 solve avg. time: 11.474ms; median: 11.291ms
//  Input parse time: 1.086ms; median: 1.012ms


function day_14_input( file ){
	var _f = file_text_open_read( file ),
		_template,
		_rules = ds_map_create(),
		_pairs = ds_map_create(),
		_elements = ds_map_create(),
		_line;
	
	_template = string_strip( file_text_readln( _f ), ["\n","\r"] );
	file_text_readln(_f);
	
	while( !file_text_eof(_f) ) {
		_line = string_strip( file_text_readln( _f ), ["\n","\r"] );
		_rules[? string_copy(_line, 1, 2 )] = string_char_at( _line, 7 );
		_pairs[? string_copy(_line, 1, 2 )] = array_create( 41, 0 );
		
		if( is_undefined(_elements[? string_char_at( _line, 7 )]) ) {
			_elements[? string_char_at( _line, 7 )] = 0;
		}
	}
	
	for( var i = 1; i <= string_length( _template ); i++ ) {
		_elements[? string_char_at( _template, i )]++;
		
		if( i < string_length( _template ) ) {
			_pairs[? string_copy( _template, i, 2 )][0] += 1;
		}
	}
	
	file_text_close(_f);
	return [_rules, _pairs, _elements];
}

function day_14_insertion( input, passes ) {
	var _rules = input[0],
		_pairs = input[1],
		_elements = input[2];
	
	var _lut = [];
	for( var i = ds_map_find_first(_pairs); !is_undefined(i); i = ds_map_find_next(_pairs, i) ) {
		array_push(_lut, i);
	}
	
	var _n = 0,
		_e,
		_p,
		_m,
		_l = array_length(_lut);
	repeat( passes ) {
		for( var i = 0; i < _l; i++ ) {
			_p = _lut[i];
			_e = _rules[? _p];
			_m = _pairs[? _p][_n];
			if( _m > 0 ) {
				_pairs[? string_char_at(_p,1)+_e ][_n+1] += _m;
				_pairs[? _e+string_char_at(_p,2) ][_n+1] += _m;
				_elements[? _e] += _m;
			}
		}
		
		_n++;
	}
	
	
	var _min = 0,
		_max = 0;
	for( var i = ds_map_find_first(_elements); !is_undefined(i); i = ds_map_find_next(_elements, i) ) {
		if( _min == 0 ) {
			_min = _elements[? i];
		} else {
			_min = min( _min, _elements[? i] );
		}
		
		_max = max( _max, _elements[? i] );
	}
	
	ds_map_destroy( _rules );
	ds_map_destroy( _pairs );
	ds_map_destroy( _elements );
	return string(_max)+"-"+string(_min)+"="+string(_max-_min);
}
