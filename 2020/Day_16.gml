// VM:
//   P1 solve avg. time: 10.43ms
//   P2 solve avg. time: 153.23ms
// YYC
//   P1 solve avg. time: 3.12ms
//   P2 solve avg. time: 38.95ms

function day16_part1( tickets, ranges ) {
	var _joinedRanges = ds_list_create(),
		_key,
		_sum = 0;
	
	for( var _key = ds_map_find_first(ranges); !is_undefined(_key); _key = ds_map_find_next(ranges,_key) ) {
		ds_list_add( _joinedRanges, [ranges[? _key][0],ranges[? _key][1]] );
		ds_list_add( _joinedRanges, [ranges[? _key][2],ranges[? _key][3]] );
	}
	
	// some pretty wacky joining of the ranges that overlap
	for( var i = 0; i < ds_list_size(_joinedRanges); i++ ) {	
		for( var j = i+1; j < ds_list_size(_joinedRanges); j++ ) {
			if( in_range( min(_joinedRanges[| i][0], _joinedRanges[| j][0]), max(_joinedRanges[| i][1], _joinedRanges[| j][1]), max(_joinedRanges[| i][0], _joinedRanges[| j][0]) ) ||
				in_range( min(_joinedRanges[| i][0], _joinedRanges[| j][0]), max(_joinedRanges[| i][1], _joinedRanges[| j][1]), min(_joinedRanges[| i][1], _joinedRanges[| j][1]) ) ) {
				
				_joinedRanges[| i] = [ min(_joinedRanges[| i][0], _joinedRanges[| j][0]), 
					                   max(_joinedRanges[| i][1], _joinedRanges[| j][1]) ];
				ds_list_delete( _joinedRanges, j );
				i = 0;
				break;
			}
		}
	}
	
	// check if we can join the last 2 ranges that for whatever reason didn't get joined in the above loop
	// (would be nice if we could that inside the loop though but I cba to figure it out)
	if( in_range( min(_joinedRanges[| 0][0], _joinedRanges[| 1][0]), max(_joinedRanges[| 0][1], _joinedRanges[| 1][1]), max(_joinedRanges[| 0][0], _joinedRanges[| 1][0]) ) ||
		in_range( min(_joinedRanges[| 0][0], _joinedRanges[| 1][0]), max(_joinedRanges[| 0][1], _joinedRanges[| 1][1]), min(_joinedRanges[| 0][1], _joinedRanges[| 1][1]) ) ) {
				
		_joinedRanges[| 0] = [ min(_joinedRanges[| 0][0], _joinedRanges[| 1][0]), 
				               max(_joinedRanges[| 0][1], _joinedRanges[| 1][1]) ];
		ds_list_delete( _joinedRanges, 1 );
	}
		
	var _isValid = true;
	for( var i = 0; i < ds_list_size(tickets); i++ ) {
		_isValid = true;
		
		for( var j = 0; j < array_length(tickets[| i]); j++ ) {
			for( var k = 0; k < ds_list_size( _joinedRanges ); k++ ) {
				if( !in_range( _joinedRanges[| k][0], _joinedRanges[| k][1], tickets[| i][j] ) ) {
					_sum += tickets[| i][j];
					_isValid = false;
					break;
				}
			}
		}
		
		if( !_isValid ) ds_list_delete( tickets, i-- );
	}
	
	ds_list_destroy(_joinedRanges);
	
	return _sum;
}

function day16_part2(myTicket,tickets,ranges) {
	var _possibleFields,
		_product = 1;
	
	// Fill the _PossibleFields array with all the keys to start off
	var _allFields = ds_list_create();
	
	for( var _key = ds_map_find_first(ranges); !is_undefined(_key); _key = ds_map_find_next(ranges,_key) ) {
		ds_list_add( _allFields, _key );
	}
	
	for( var i = 0; i < array_length(myTicket); i++ ) {
		_possibleFields[i] = ds_list_create();
		ds_list_copy( _possibleFields[i], _allFields );
	}
	
	ds_list_destroy( _allFields );
	
	// Narrow down the possible names for every field
	var _range, _value;
	for( var i = 0; i < ds_list_size(tickets); i++ ) {
		for( var j = 0; j < array_length(tickets[| i]); j++ ) {
			for( var k = 0; k < ds_list_size( _possibleFields[j] ); k++ ) {
				_range = ranges[? _possibleFields[j][| k]];
				_value = tickets[| i][j];
				
				// if the value doesn't fit the range of the field, remove the field from the list for 
				// this column
				if( !in_range( _range[0], _range[1], _value ) && !in_range( _range[2], _range[3], _value ) ) {
					ds_list_delete( _possibleFields[j], k-- );
				}
			}
		}
	}
	
	// Remove the known fields (lists of length 1) from other fields lists of matches (lists length >1)
	var _l = array_length( _possibleFields ),
		_solved = ds_list_create(),
		_remove;
		
	for( var i = 0; i < _l; i++ ) {
		if( ds_list_find_index(_solved,i) == -1 ) {
			
			// if the list has only 1 item in it we know which field it is
			if( ds_list_size( _possibleFields[i] ) == 1 ) { 
				_remove = _possibleFields[i][| 0];
				
				// clear the other fields' potential matches of the known one
				for( var j = 0; j < _l; j++ ) {
					if( j == i ) continue; // make sure we don't accidentally clear the known field
					
					var _pos = ds_list_find_index( _possibleFields[j], _remove );
					if( _pos > -1 )
						ds_list_delete( _possibleFields[j], _pos );
				}
				
				// add to the list of already solved fields so we don't bother
				// checking for it again
				ds_list_add( _solved, i ); 
				i = -1; // reset the loop
			}
		}
	}
	
	ds_list_destroy( _solved );
	
	// Get the product of the values from my ticket from fields related to departure.
	// Also deletes the data structures as we don't need them anymore
	for( var i = 0; i < array_length(myTicket); i++ ) {
		if( string_pos( "departure", _possibleFields[i][| 0] ) > 0 ) {
			_product *= myTicket[i];
		}
		
		ds_list_destroy( _possibleFields[i] );
	}
	
	return _product;
}

function day16_input(file) {
	file = file_text_open_read(file)
	
	var _line,
		_ranges = ds_map_create(),
		_key,
		_r_current = [],
		_myTicket = [],
		_tickets = ds_list_create(),
		_part = 0;
	
	while( !file_text_eof(file) ) {
		_line = string_strip( file_text_readln(file), ["\n","\r"] );
		
		if( _line = "" ) { 
			_part++;
			continue;
		}
		
		if( string_char_at_is( _line, 1, "y" ) || string_char_at_is( _line, 1, "n" ) ) continue;
			
		if( _part == 0 ) {
			_key = string_copy( _line, 1, string_pos(": ",_line)-1 );
			_line = string_replace( _line, _key+": ", "" );
			_line = string_replace( _line, " or ", "-" );
			_r_current = string_split( _line, "-", type_real );
			_ranges[? _key] = _r_current;
		}else if( _part == 1 ) {
			_myTicket = string_split( _line, ",", type_real );
		}else if( _part == 2 ) {
			ds_list_add( _tickets, string_split( _line, ",", type_real ) );
		}
	}
	
	file_text_close(file);
	
	return [_myTicket, _tickets, _ranges];
}