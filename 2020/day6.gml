function day6_part1(){
	var _file = file_text_open_read("6.txt"),
		_answers = [""],
		_group = 0,
		_line = "",
		_q,
		_yeses = 0;
	
	while( !file_text_eof(_file) ) {
		_line = string_replace( file_text_readln(_file), "\n", "" );
		if( _line != "" ) {
			for( var i = 1; i <= string_length(_line); i++ ) {
				_q = string_byte_at(_line,i);
				if( in_range( ord("a"), ord("z"), _q ) && string_pos( chr(_q), _answers[_group] ) == 0 ) {
					_answers[_group] += chr(_q);
				}
			}
		}else{			
			_group++;
			_answers[_group] = "";
		}
	}
	
	for( var i = 0; i < array_length(_answers); i++ ) {
		_yeses += string_length(_answers[i]);
	}
	
	return string(_answers)+"\n"+string(_yeses);
}

function day6_part2(){
	var _file = file_text_open_read("6.txt"),
		_answers,
		_group = 0,
		_line = "",
		_q,
		_yeses = 0;
	
	_answers[0] = [0,""];
	while( !file_text_eof(_file) ) {
		_line = string_replace( file_text_readln(_file), "\n", "" );
		if( _line != "" ) {
			_answers[_group][0]++;
			for( var i = 1; i <= string_length(_line); i++ ) {
				_q = string_byte_at(_line,i);
				if( in_range( ord("a"), ord("z"), _q ) ) {
					_answers[_group][1] += chr(_q);
				}
			}
		}else{			
			_group++;
			_answers[_group] = [0,""];
		}
	}
	
	var _p, _a;
	for( var i = 0; i < array_length(_answers); i++ ) {
		_p = _answers[i][1];
		while( string_length(_p) > 0 ) {
			_a = string_char_at( _p, 1 );
			if( string_count( _a, _p ) == _answers[i][0] ) {
				_yeses++;
			}
			
			_p = string_replace_all( _p, _a, "" );
		}
	}
	
	return string(_answers)+"\n"+string(_yeses);
}