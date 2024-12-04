// VM:
//   P1 solve avg. time: 19.04ms
//   P2 solve avg. time: 12.24ms
// YYC:
//   P1 solve avg. time: 3.56ms
//   P2 solve avg. time: 2.95ms


function day04_part1(input){
	var _length = array_length(input),
		_row_l = string_length(input[0]),
		_answer = 0,
		_chr,
		_lut_f = [ord("X"),ord("M"),ord("A"),ord("S")],
		_lut_b = [ord("S"),ord("A"),ord("M"),ord("X")],
		_check_against;
	
	for( var i = 0; i < _length; i++ ) {
		// check current line for any XMAS
		_answer += string_count( "XMAS", input[i] );
		_answer += string_count( "SAMX", input[i] );
		
		// check verticals and diagonals if at row number < _length-4
		if( i < _length-3 ) {
			for( var j = 1; j <= _row_l; j++ ) {
				_chr = string_byte_at( input[i], j );
				
				if( _chr != _lut_f[0] && _chr != _lut_b[0] ) continue;
				
				_check_against = ( _chr == _lut_f[0] ) ? _lut_f : _lut_b;
				
				// vertical check
				for( var k = 1; k <= 3; k++ ) {
					if( string_byte_at( input[i+k], j ) != _check_against[k] ) break;
					if( k == 3 ) { 
						_answer++;
						//log( string_ext( ( _chr == _lut_f[0] ? "XMAS" : "SAMX" ) + " found at {0},{1}", [i, j-1] ) );
					}
				}
				
				// check right diagonal if j <= length-3
				if( j <= _row_l-3 ) {
					for( var k = 1; k <= 3; k++ ) {
						if( string_byte_at( input[i+k], j+k ) != _check_against[k] ) break;
						if( k == 3 ) { 
							_answer++;
							//log( string_ext( ( _chr == _lut_f[0] ? "XMAS" : "SAMX" ) + " found at {0},{1}", [i, j-1] ) );
						}
					}
				}
				
				// check left diagonal if j >= 4
				if( j >= 4 ) {
					for( var k = 1; k <= 3; k++ ) {
						if( string_byte_at( input[i+k], j-k ) != _check_against[k] ) break;
						if( k == 3 ) { 
							_answer++;
							//log( string_ext( ( _chr == _lut_f[0] ? "XMAS" : "SAMX" ) + " found at {0},{1}", [i, j-1] ) );
						}
					}
				}
			}
		}
	}
	
	return _answer;
}

function day04_part2(input){
	var _length = array_length(input)-2,    // -2 because no point going through the last 2 rows
		_row_l = string_length(input[0])-2, // -2 because ^
		_answer = 0,
		_chr1, _chr2,
		_lut_f = [ord("M"),ord("A"),ord("S")],
		_lut_b = [ord("S"),ord("A"),ord("M")],
		_check_against1,
		_check_against2;
	
	for( var i = 0; i < _length; i++ ) {
		for( var j = 1; j <= _row_l; j++ ) {
			_chr1 = string_byte_at( input[i], j );
			if( _chr1 != _lut_f[0] && _chr1 != _lut_b[0] ) continue;
			
			_chr2 = string_byte_at( input[i+2], j );
			if( _chr2 != _lut_f[0] && _chr2 != _lut_b[0] ) continue;
			
			_check_against1 = ( _chr1 == _lut_f[0] ) ? _lut_f : _lut_b;
			_check_against2 = ( _chr2 == _lut_f[0] ) ? _lut_f : _lut_b;
				
			for( var k = 1; k <= 2; k++ ) {
				if( string_byte_at( input[i+k], j+k ) != _check_against1[k] ) break;
				if( string_byte_at( input[i+2-k], j+k ) != _check_against2[k] ) break;
				
				if( k == 2 ) { 
					_answer++;
					//log( string_ext( "X-MAS found at {0},{1}", [i, j-1] ) );
				}
			}
		}
	}
	
	return _answer;
}