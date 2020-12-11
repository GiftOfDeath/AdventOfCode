// VM:
//   P1 solve avg. time: 5.07ms
//   P2 solve avg. time: 9.40ms
// YYC:
//   P1 solve avg. time: 4.94ms
//   P2 solve avg. time: 6.41ms

function day4_v2_p1(input){
	var _passports = input,
		_map,
		_valid_passports = 0;
	
	for( var i = 0; i < array_length( _passports ); i++ ) {
		_map = json_decode( _passports[i] );
		if( ( ds_map_size(_map) == 7 && _map[? "cid"] == undefined ) || ds_map_size(_map) == 8  ) {
			_valid_passports++;
		}
		ds_map_destroy(_map);
	}
	
	return _valid_passports;
}

function day4_v2_p2(input) {
	var _passports = input,
		_map,
		_valid_passports = 0,
		_ecl_values = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"];;
		
	for( var i = 0; i < array_length( _passports ); i++ ) {
		_map = json_decode( _passports[i] );
		
		if( ( ds_map_size(_map) == 7 && _map[? "cid"] == undefined ) || ds_map_size(_map) == 8  ) {
			
			if( in_range( 1920, 2002, real(_map[?"byr"]) ) &&
				in_range( 2010, 2020, real(_map[?"iyr"]) ) &&
				in_range( 2020, 2030, real(_map[?"eyr"]) ) &&
				string_length( string_digits( _map[?"pid"] ) ) == 9 ) {
					
				if( string_char_at_is( _map[?"hcl"], 1, "#" ) ) {
					var _hex = string_delete( _map[?"hcl"], 1, 1 );
					if( is_hexadecimal(_hex) ) {
						var _ecl_matches = 0;
						for( var k = 0; k < array_length( _ecl_values ); k++ ) {
							if( _map[?"ecl"] == _ecl_values[k] ) {
								_ecl_matches++;
							}
						}
				
						if( _ecl_matches == 1 ) {
							if( string_pos( "cm", _map[?"hgt"] ) != 0 ) {
								var _height = real( string_digits( _map[?"hgt"] ) );
					
								if( in_range( 150, 193, _height ) ) {
									_valid_passports++;
								}
							} else if( string_pos( "in", _map[?"hgt"] ) != 0 ) {
								var _height = real( string_digits( _map[?"hgt"] ) );
						
								if( in_range( 59, 76, _height ) ) {
									_valid_passports++;
								}
							}
						}
					}
				}
			}
		}
		
		ds_map_destroy(_map);
	}
	
	return _valid_passports;
}


function day4_v2_input() {
	var _file = file_text_open_read("4.txt"),
		_ids = ["{\""],
		_id = 0,
		_line = "";
	
	while( !file_text_eof(_file) ) {
		_line = string_replace( file_text_readln(_file), "\n", " " );
		if( _line != " " ) {
			_ids[_id] += _line;
		}
		
		if( _line == " " || file_text_eof(_file) ) {
			_ids[_id] = string_delete(_ids[_id],string_length(_ids[_id]),1);
			_ids[_id] += "\"}";
			_ids[_id] = string_replace_all( _ids[_id], " ", "\",\"" );
			_ids[_id] = string_replace_all( _ids[_id], ":", "\":\"" );
			_id++;
			
			if( !file_text_eof(_file) ) {
				_ids[_id] = "{\"";
			}
		}
	}
	
	return _ids;
}