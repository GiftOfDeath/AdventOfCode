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