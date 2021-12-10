// VM:
//  P1 solve avg. time: 12.29ms; median: 11.97ms
//  P2 solve avg. time: 0.89ms; median: 0.82ms

// YYC: TBD, can't get working

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
		_last,
		_score = 0,
		_corruptLines = [],
		_openingsList = [];
	
	var _l = array_length(input);
	for( var i = 0; i < _l; i++ ) {
		_opening = [];
		_eoln = string_length( input[i] );
				
		for( var j = 1; j <= _eoln; j++ ) {
			// Using decimal values in favour of speed, string comparison is slow
			// 91 = [   40 = (   123 = {   60 = <
			// 93 = ]   41 = )   125 = }   62 = >
			_chr = string_byte_at( input[i], j );
			if( _chr == 123 || _chr == 91 || _chr == 60 || _chr == 40 ) {
				_opening[ array_length(_opening) ] = _chr;
			}else{
				_last = array_length(_opening)-1;
				
				// If the current chr is a closing bracket, remove the last entry
				// in opening brackets. If there's no match the line is corrupt
				// and gets scored appropriately
				if( _opening[_last] == 123 && _chr == 125 ) {
					array_delete(_opening,_last,1);
				} else
				if( _opening[_last] == 91 && _chr == 93 ) {
					array_delete(_opening,_last,1);
				} else
				if( _opening[_last] == 60 && _chr == 62 ) {
					array_delete(_opening,_last,1);
				} else
				if( _opening[_last] == 40 && _chr == 41 ) {
					array_delete(_opening,_last,1);
				}else{
					switch( _chr ) {
						case 41:  _score += 3; break;
						case 93:  _score += 57; break;
						case 125: _score += 1197; break;
						case 62:  _score += 25137; break;
					}
					
					_corruptLines[ array_length(_corruptLines) ] = i;
					
					break;
				}
			}
		}
		
		_openingsList[i] = _opening;
	}
	
	return [_score, _openingsList, _corruptLines];
}

function day_10_part2(input, corruptLines) {
	// Dispose of the corrupt lines
	for( var i = array_length(corruptLines)-1; i >= 0; i-- ) {
		array_delete( input, corruptLines[i], 1 );
	}
	
	var _score = [];
	
	var _l = array_length(input);
	for( var i = 0; i < _l; i++ ) {		
		// Using decimal values in favour of speed, string comparison is slow
		// 91 = [   40 = (   123 = {   60 = <
			
		// Don't actually need to generate the closing brackets, just travel
		// the last opening brackets in order and score based on those
		_score[i] = 0;
		for( var j = array_length(input[i])-1; j >= 0; j-- ) {
			_score[i] *= 5;
			switch(input[i][j] ) {
				case 40:  _score[i] += 1; break;
				case 91:  _score[i] += 2; break;
				case 123: _score[i] += 3; break;
				case 60:  _score[i] += 4; break;
			}
		}
	}
	
	return array_median(_score);
}