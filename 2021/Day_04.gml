// VM:
//  P1 solve avg. time: 31.78ms;  median: 32.03ms
//  P2 solve avg. time: 151.98ms; median: 152.87ms

// YYC: 
//  P1 solve avg. time: 5.71ms;  median: 5.61ms
//  P2 solve avg. time: 26.82ms; median: 26.62ms

function day_04_input(){
	var _f = file_text_open_read( "04.txt" );
	
	var _draws = string_split( string_strip( file_text_readln( _f ), ["\n","\r"] ), ",", type_real ),
		_boards = [];

	var _line, 
		_i = -1,
		_j;
	
	while( !file_text_eof( _f ) ) {
		_line = string_strip( file_text_readln( _f ), ["\n","\r"] );
	
		if( _line == "" ) {
			_i++;
			_j = 0;
		}else{
			_boards[_i][_j] = string_split( string_strip( _line, ["\n","\r"] ), " ", type_real ); 
			_j++;
		}
	}
	
	file_text_close(_f);
	return [_draws,_boards];
}

function day_04_part1( input ) {
	var _draws = input[0],
		_boards = input[1];
	
	for( var _i = 0; _i < array_length(_draws); _i++ ) {
		for( var _j = 0; _j < array_length(_boards); _j++ ) {
			if( hasNumber( _boards[_j], _draws[_i] ) ) {
				if( isBingo( _boards[_j] ) ) {
					return "Winning board: " + string(_j) + "; Score: " + string( boardScore( _boards[_j], _draws[_i] ) );
				}
			}
		}
	}
}

function day_04_part2( input ) {
	var _draws = input[0],
		_boards = input[1],
		_skips = ds_list_create();
	
	var _answer = "";
	for( var _i = 0; _i < array_length(_draws); _i++ ) {
		for( var _j = 0; _j < array_length(_boards); _j++ ) {
			if( ds_list_find_index(_skips,_j) > -1 ) continue;
			
			if( hasNumber( _boards[_j], _draws[_i] ) ) {
				if( isBingo( _boards[_j] ) ) {
					_answer = "Winning board: " + string(_j) + "; Score: " + string( boardScore( _boards[_j], _draws[_i] ) )
					ds_list_add(_skips,_j);
				}
			}
		}
	}
	
	ds_list_destroy(_skips);
	
	return _answer;
}

function hasNumber( board, number ) {
	for( var _i = 0; _i < array_length( board ); _i++ ) {
		
		for( var _j = 0; _j < array_length( board[_i] ); _j++ ) {
			if( board[_i][_j] == number ) {
				board[@_i][@_j] = -1;
				return true;
			}
		}
	}
	
	return false;
}

function isBingo( board ) {
	var _verticalTracking = [0,0,0,0,0],
		_horizontalTracking = 0;
	for( var _i = 0; _i < array_length( board ); _i++ ) {
		_horizontalTracking = 0;
		
		for( var _j = 0; _j < array_length( board[_i] ); _j++ ) {
			if( board[_i][_j] == -1 ) {
				_horizontalTracking++;
				_verticalTracking[ _j ]++;
				
				if( _verticalTracking[_j] == 5 ) return true;
				if( _horizontalTracking == 5 ) return true;
			}
		}
	}
	
	return false;
}

function boardScore( board, multiplier ) {
	var _sum = 0;
	for( var _i = 0; _i < array_length( board ); _i++ ) {
		for( var _j = 0; _j < array_length( board[_i] ); _j++ ) {
			if( board[_i][_j] != -1 ) { _sum += board[_i][_j]; }
		}
	}
	
	return _sum*multiplier;
}