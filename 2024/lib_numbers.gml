function hexdec( hexstr ){
	hexstr = string_upper(hexstr);
	var _l = string_length(hexstr);

	var _p = 0, _chr, _dec = 0;
	for( var i = 1; i <= _l; i++ ) {
		_chr = string_byte_at(hexstr,i);
	
		if( _chr < 58 )
			_chr -= 48;
		else
			_chr -= 55;
	
		_dec += _chr*power(16,_p);
		_p++;
	}

	return _dec;
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

function wrap( wmin, wmax, n ) {
	var _range = wmax-wmin;
	if( wmin > n ) return n+_range+1;
	if( wmax < n ) return n-_range-1;
	
	return n;
}

function digit_count( number ) {	
	var _n = 1;
	
	while( number div 10 != 0 ) {
		_n++;
		number = number div 10;
	}
	
	return _n;
}