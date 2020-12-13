// VM:
//   P1 solve avg. time: 2.86ms
//   P2 solve avg. time: 28.18ms
// YYC:
//   P1 solve avg. time: 1.65ms
//   P2 solve avg. time: 14.17ms

function day4_part1(input){
	var _ids = input;
	
	var _keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"],
		_valid_passports = 0,
		_missing_keys = 0;
	for( var i = 0; i < array_length(_ids); i++ ) {
		for( var j = 0; j < array_length(_keys)-1; j++ ) {
			if( string_pos( _keys[j], _ids[i] ) == 0 ) {
				_missing_keys++;
			}
		}
		
		if( _missing_keys == 0 ) {
			_valid_passports++;
		}
		
		_missing_keys = 0;
	}
	
	return _valid_passports;
}

function day4_part2(input) {
	var _ids = input;
	
	var _valid_passports = 0,
		_passport = [],
		_pair = [],
		_missing_info = 7,
		_ecl_values = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];
	for( var i = 0; i < array_length(_ids); i++ ) {
		_passport = string_split( _ids[i], " ", type_string );
		
		if( array_length(_passport) < 7 ) { continue; }
		
		for( var j = 0; j < array_length(_passport); j++ ) {
			_pair = string_split( _passport[j], ":", type_string );
			
			if( _pair[0] == "byr" ) {
				if( in_range( 1920, 2002, real(_pair[1]) ) ) {
					_missing_info--;
				}
			}
			
			if( _pair[0] == "iyr" ) {
				if( in_range( 2010, 2020, real(_pair[1]) ) ) {
					_missing_info--;
				}
			}
			
			if( _pair[0] == "eyr" ) {
				if( in_range( 2020, 2030, real(_pair[1]) ) ) {
					_missing_info--;
				}
			}
			
			if( _pair[0] == "hgt" ) {
				if( string_pos( "cm", _pair[1] ) != 0 ) {
					var _height = real( string_digits( _pair[1] ) );
					
					if( in_range( 150, 193, _height ) ) {
						_missing_info--;
					}
				} else if( string_pos( "in", _pair[1] ) != 0 ) {
					var _height = real( string_digits( _pair[1] ) );
						
					if( in_range( 59, 76, _height ) ) {
						_missing_info--;
					}
				}
			}
			
			if( _pair[0] == "hcl" ) {
				
				if( string_char_at_is( _pair[1], 1, "#" ) ) {
					var _hex = string_delete( _pair[1], 1, 1 );
					if( is_hexadecimal(_hex) ) {
						_missing_info--;
					}
				}
			}
			
			if( _pair[0] == "ecl" ) {
				var _ecl_matches = 0;
				for( var k = 0; k < array_length( _ecl_values ); k++ ) {
					if( _pair[1] == _ecl_values[k] ) {
						_ecl_matches++;
					}
				}
				
				if( _ecl_matches == 1 ) {
					_missing_info--;
				}
			}
			
			if( _pair[0] == "pid" ) {
				if( string_length( string_digits( _pair[1] ) ) == 9 ) {
					_missing_info--;
				}
			}
		}
		
		if( _missing_info == 0 ) {
			_valid_passports++;
		}
		
		_missing_info = 7;
	}
	
	return _valid_passports;
}

function day4_input() {
	var _file = file_text_open_read("4.txt"),
		_ids = [""],
		_id = 0,
		_line = "";
	
	while( !file_text_eof(_file) ) {
		_line = string_replace( file_text_readln(_file), "\n", " " );
		if( _line != " " ) {
			_ids[_id] += _line;
		}else{
			_id++;
			_ids[_id] = "";
		}
	}
	
	return _ids;
}