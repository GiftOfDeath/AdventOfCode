// VM:
//  P1 solve avg. time: 8.78ms; median: 8.42ms
//  P2 solve avg. time: 0.87ms; median: 0.78ms

// YYC: 
//  P1 solve avg. time: 1.77ms; median: 1.71ms
//  P2 solve avg. time: 0.26ms; median: 0.25ms

function day_10_input(){
	var _arr = [],
	_f = file_text_open_read( "10.txt" );
	
	while( !file_text_eof(_f) ) {
		_arr[array_length(_arr)] = string_strip( file_text_readln( _f ), ["\n","\r"] );
	}
	
	file_text_close( _f );
	return _arr;
}

function day_10_part1(input) {
	var _opening,
		_eoln,
		_chr,
		_score = 0,
		_corruptLines = ds_stack_create(),
		_openingsList = [];
		
	var _l = array_length(input);
	for( var i = 0; i < _l; i++ ) {
		_opening = ds_stack_create();
		_eoln = string_length( input[i] );
				
		for( var j = 1; j <= _eoln; j++ ) {
			// Using decimal values in favour of speed, string comparison is slow
			// 91 = [   40 = (   123 = {   60 = <
			// 93 = ]   41 = )   125 = }   62 = >
			_chr = string_byte_at( input[i], j );
			if( _chr == 123 || _chr == 91 || _chr == 60 || _chr == 40 ) {
				ds_stack_push( _opening, _chr );
			}else{				
				// If the current chr is a closing bracket, remove the last entry
				// in opening brackets. If there's no match the line is corrupt
				// and gets scored appropriately
				
				var _top = ds_stack_top(_opening);
				if( ( _top == 123 && _chr == 125 ) ||
					( _top == 91  && _chr == 93  ) ||
					( _top == 60  && _chr == 62  ) || 
					( _top == 40  && _chr == 41  ) ) {
					ds_stack_pop(_opening);
				} else {
					switch( _chr ) {
						case 41:  _score += 3; break;
						case 93:  _score += 57; break;
						case 125: _score += 1197; break;
						case 62:  _score += 25137; break;
					}
					
					ds_stack_push(_corruptLines, i);
					break;
				}
			}
		}
		
		_openingsList[i] = _opening;
	}
	
	// Let's pass the opening bracket stacks to part 2
	// so we don't need to parse them a 2nd time for no reason
	return [_score, _openingsList, _corruptLines];
}

function day_10_part2(input, corruptLines) {
	// Dispose of the corrupt lines
	var _line;
	while( !ds_stack_empty(corruptLines) ) {
		_line = ds_stack_pop(corruptLines);
		ds_stack_destroy( input[ _line ] );
		array_delete( input, _line, 1 );
	}
	
	ds_stack_destroy(corruptLines);
	
	var _score = [];
	
	var _l = array_length(input);
	for( var i = 0; i < _l; i++ ) {		
		// Using decimal values in favour of speed, string comparison is slow
		// 91 = [   40 = (   123 = {   60 = <
			
		// Don't actually need to generate the closing brackets, just travel
		// the last opening brackets in order and score based on those
		_score[i] = 0;
		while( !ds_stack_empty(input[i]) ) {
			_score[i] *= 5;
			switch( ds_stack_pop(input[i]) ) {
				case 40:  _score[i] += 1; break;
				case 91:  _score[i] += 2; break;
				case 123: _score[i] += 3; break;
				case 60:  _score[i] += 4; break;
			}
		}
		
		ds_stack_destroy( input[i] );
	}
	
	return array_median(_score);
}