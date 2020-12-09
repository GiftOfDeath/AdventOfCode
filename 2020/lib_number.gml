function in_range( rmin, rmax, n ){
	return( ( n >= rmin && n <= rmax ) );
}

function array_product( array ) {
	var _p = array[0];
	
	for( var i = 1; i < array_length(array); i++ ) {
		_p *= array[i];
	}
	
	return _p;
}

function wrap( wmin, wmax, n ) {
	var _range = wmax-wmin;
	if( wmin > n ) return n+_range+1;
	if( wmax < n ) return n-_range-1;
	
	return n;
}

function is_hexadecimal( str ) {
	for( var i = 0; i < string_length(str); i++ ) {
		if( in_range(48, 57, string_byte_at( str, i ) ) || in_range( 97, 102, string_byte_at( str, i ) ) ) {
			continue;
		}else{
			return false;
		}
	}
	
	return true;
}

function bindec(binstr) {
	var _dec = 0,
		_len = string_length(binstr);
		
	for( var i = 0; i < _len; i++ ) {
		if( string_char_at(binstr, i+1) == "1" ) {
			_dec += 1 << (_len-1-i);
		}
	}
	
	return _dec;
}





