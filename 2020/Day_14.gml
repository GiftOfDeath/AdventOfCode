// VM
//   P1 solve avg. time: 71.55ms
//   P2 solve avg. time: 105122.21ms
// YYC
//   P1 solve avg. time: 42.41ms
//   P2 solve avg. time: 90555.36ms

// ...might have to try to optimise p2 a bit, the sum calculation seems to be the problem:
//   Processing memory block 0-99...
//     Done in 359.13ms
//   Calculating sum...
//     Done in 88321.57ms

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
		_memAddress;
	
	var _memory = ds_map_create();
	
	var b = 0, t = get_timer();
	for( var i = 0; i < array_length(input); i++ ) {
		if( string_pos( "mask", input[i] ) > 0 ) {
			log( "Processing memory block "+string(b++)+"..." );
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
			_memAddress &= ~bindec(_zeroes); // Flip X:s to 0:s
			_memory[? _memAddress] = _line[1];
			
			day14_malloc( _memory, _memAddress, _xes, _line[1], 0 );
		}
	}
	
	log( "Done in "+string((get_timer()-t)/1000)+"ms" );
	log( "Calculating sum..." );
	t = get_timer();
	var _sum = 0;
	for( var _key = ds_map_find_first(_memory); !is_undefined(_key); _key = ds_map_find_next(_memory,_key) ) {
		_sum += _memory[? _key];
	}
	log( "Done in "+string((get_timer()-t)/1000)+"ms" );
	
	return _sum;
}

function day14_malloc( mem, address, mask, value, n ) {
	if( n == array_length(mask) ) return;
	
	mem[? address] = value;
	day14_malloc( mem, address, mask, value, n+1 );
	
	address |= 1 << mask[n];
	mem[? address] = value;
	day14_malloc( mem, address, mask, value, n+1 );
}