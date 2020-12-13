// VM:
//   P1 solve avg. time: 6.95ms
//   P2 solve avg. time: 686.74ms
// YYC:
//   P1 solve avg. time: 1.49ms
//   P2 solve avg. time: 109.10ms

function day1_part1(){
	var _arr = [],
		_f = file_text_open_read( "1.txt" );
	while( !file_text_eof( _f ) ) {
		_arr[ array_length(_arr) ] = real( string_digits( file_text_readln( _f ) ) );
	}
	
	var _l = array_length(_arr),
		_sum;
	for( var i = 0; i < _l; i++ ) {
		for( var j = i+1; j < _l; j++ ) {
			_sum = _arr[i] + _arr[j];
			if( _sum == 2020 ) {
				return( _arr[i]*_arr[j] );
			}
		}
	}
}

function day1_part2(){
	var _arr = [],
		_f = file_text_open_read( "1.txt" );
	while( !file_text_eof( _f ) ) {
		_arr[ array_length( _arr ) ] = real( string_digits( file_text_readln( _f ) ) );
	}
	
	var _l = array_length(_arr),
		_sum;
	for( var i = 0; i < _l; i++ ) {
		for( var j = i+1; j < _l; j++ ) {
			for ( var k = j+1; k < _l; k++ ) {
				_sum = _arr[i] + _arr[j] + _arr[k];
				if( _sum == 2020 ) {
					return( _arr[i]*_arr[j]*_arr[k] );
				}
			}
		}
	}
}