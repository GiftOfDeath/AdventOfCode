function in_range( rmin, rmax, n ){
	return( ( n >= rmin && n <= rmax ) );
}

function array_product( array ) {
	var _p = array[0];
	
	var _l = array_length(array);
	for( var i = 1; i < _l; i++ ) {
		_p *= array[i];
	}
	
	return _p;
}

function array_sum( array ) {
	var _s = array[0];
	
	var _l = array_length(array);
	for( var i = 1; i < _l; i++ ) {
		_s += array[i];
	}
	
	return _s;
}

function array_median( array ) {
	array_sort(array, false);
	return array[ array_length(array) div 2 ];
}

function array_mean( array, Div ) {
	var _sum = 0,
		_l = array_length(array);
	for( var i = 0; i < _l; i++ ) {
		_sum += array[i];
	}
	
	return ( Div ) ? _sum div _l : _sum / _l;
}

function triangular_number( n ) {
	return ( ( n*(n+1) ) / 2 );
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

function ms_to_mmss( time ) {
	var _ms = time/1000,
		_m = _ms div 60000,
		_s = (_ms / 1000) % 60;
	
	return string_replace_all(string_format(_m, 3, 0), " ", "0" )+"m "+string_replace_all(string_format(_s, 2, 3), " ", "0" )+"s";
}