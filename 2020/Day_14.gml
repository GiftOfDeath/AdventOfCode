// VM
//   P1 solve avg. time: 74.06ms
//   P2 solve avg. time: 921.67ms
// YYC
//   P1 solve avg. time: 42.59ms
//   P2 solve avg. time: 667.72ms

// input = input_array(file)
function day14_part1(input){
	var _line,
		_ones,
		_zeroes;
	
	var _memory = ds_map_create();
	
	for( var i = 0; i < array_length(input); i++ ) {
		if( string_pos( "mask", input[i] ) > 0 ) {
			_line = string_strip( input[i], "mask = " );
			_ones = "";
			_zeroes = "";
			for( var j = 1; j <= string_length(_line); j++ ) {
				switch( string_char_at( _line, j ) ) {
					case "X":
							_ones += "0";
							_zeroes += "0";
						break;
					case "0":
							_ones += "0";
							_zeroes += "1";
						break;
					case "1":
							_ones += "1";
							_zeroes += "0";
						break;
				}
			}
		}else{
			_line = string_strip( input[i], ["mem[","]"," ="] );
			_line = string_split( _line, " ", type_real );
			_memory[? _line[0]] = _line[1] | bindec(_ones);
			_memory[? _line[0]] = _memory[? _line[0]] & ~bindec(_zeroes);
		}
	}
	
	var _sum = 0;
	for( var _key = ds_map_find_first(_memory); !is_undefined(_key); _key = ds_map_find_next(_memory,_key) ) {
		_sum += _memory[? _key];
	}
	
	return _sum;
}

function day14_part2(input){
	var _line,
		_bits,
		_ones,
		_zeroes,
		_xes,
		_memAddress,
		_sum;
	
	var _memory = ds_map_create();
	_sum[0] = 0;
	
	for( var i = 0; i < array_length(input); i++ ) {
		if( string_pos( "mask", input[i] ) > 0 ) {
			_line = string_strip( input[i], "mask = " );
			_ones = "";
			_zeroes = "";
			_bits = string_length(_line);
			_xes = [];
			for( var j = 1; j <= _bits; j++ ) {
				switch( string_char_at( _line, j ) ) {
					case "X":
							_xes[array_length(_xes)] = _bits-j;
							_ones += "0";
							_zeroes += "1";
						break;
					case "0":
							_ones += "0";
							_zeroes += "0";
						break;
					case "1":
							_ones += "1";
							_zeroes += "0";
						break;
				}
			}
		}else{
			_line = string_strip( input[i], ["mem[","]"," ="] );
			_line = string_split( _line, " ", type_real );
			
			_memAddress = (_line[0] | bindec(_ones));
			_memAddress &= ~bindec(_zeroes); 
			
			day14_malloc( _memory, _memAddress, _xes, _line[1], 0, _sum );
		}
	}
	
	return _sum[0];
}

function day14_malloc( mem, address, mask, value, n, s ) {
	if( n == array_length(mask) ) return;
	
	if( !is_undefined(mem[? address]) ) {
		s[@ 0] -= mem[? address];
	}
	
	s[@ 0] += value;
	mem[? address] = value;
	day14_malloc( mem, address, mask, value, n+1,s  );
	
	address |= 1 << mask[n];
	
	if( !is_undefined(mem[? address]) ) {
		s[@ 0] -= mem[? address];
	}
	
	s[@ 0] += value;
	mem[? address] = value;
	day14_malloc( mem, address, mask, value, n+1, s );
}