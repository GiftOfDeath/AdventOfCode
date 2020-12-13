// VM:
//   P1 solve avg. time: 2.88ms
//   P2 solve avg. time: 33.90ms
//   P2 solve avg. time: 17.94ms (_on_crack version, to be improved further)
// YYC:
//   P1 solve avg. time: 1.41ms
//   P2 solve avg. time: 17.07ms
//   P2 solve avg. time: 8.75ms (_on_crack version, to be improved further)

function day8_part1(input){
	var _instructions = input,
		_repeat = ds_list_create(),
		_accumulator = 0;
		
	for( var i = 0; i < array_length(_instructions); i++ ) {
		if( ds_list_find_index(_repeat,i) > -1 ) {
			ds_list_destroy(_repeat);
			return _accumulator;
		}
		
		show_debug_message( _instructions[i] );
		switch( _instructions[i][0] ) {
			case "acc": _accumulator += _instructions[i][1]; break;
			case "jmp": i += _instructions[i][1]-1; break;
			case "nop": break;
		}
		
		ds_list_add(_repeat, i);
	}
}

function day8_part2(input){
	var _instructions = input,
		_repeat = ds_list_create(),
		_changed = ds_list_create(),
		_hasChanged = false,
		_accumulator = 0;
		
	for( var i = 0; i < array_length(_instructions); i++ ) {
		if( ds_list_find_index(_repeat,i) > -1 ) {
			_accumulator = 0;
			_hasChanged = false;
			i = -1;
			ds_list_clear(_repeat);
			
			continue;
		}
		
		ds_list_add(_repeat, i);
		switch( _instructions[i][0] ) {
			case "acc": _accumulator += _instructions[i][1]; break;
			
			case "jmp": 
					if( ds_list_find_index(_changed,i) > -1 || _hasChanged ) {
						i += _instructions[i][1]-1;
					}else{
						_hasChanged = true;
						ds_list_add(_changed,i);
					}
				break;
				
			case "nop": 
					if( ds_list_find_index(_changed,i) == -1 && !_hasChanged ) {
						if( _instructions[i][1] == 0 ) {
							ds_list_add(_changed,i);
						}else{
							ds_list_add(_changed,i);
							i += _instructions[i][1]-1;
							_hasChanged = true;
						}
					}
				break;
		}
	}
	
	ds_list_destroy(_changed);
	ds_list_destroy(_repeat);
	
	return _accumulator;
}

function day8_part2_on_crack(input){
	var _instructions = input,
		_repeat = ds_list_create(),
		_changed = ds_list_create(),
		_accumulator = 0, 
		_accuTemp = 0,
		_hasChanged = false;
		
	for( var i = 0; i < array_length(_instructions); i++ ) {
		if( ds_list_find_index(_repeat,i) > -1 ) {
			_accumulator = _accuTemp;
			_hasChanged = false;
			i = _changed[| ds_list_size(_changed)-1];
			
			var _last = ds_list_find_index(_repeat,i);
			while( ds_list_size(_repeat) > _last ) {
				ds_list_delete(_repeat,_last);
			}
		}
		
		ds_list_add(_repeat, i);
		switch( _instructions[i][0] ) {
			case "acc": _accumulator += _instructions[i][1]; break;
			
			case "jmp": 
					if( ds_list_find_index(_changed, i) != -1 || _hasChanged ) {
						i += _instructions[i][1]-1;
					}else{
						_hasChanged = true;
						ds_list_add(_changed,i);
						_accuTemp = _accumulator;
					}
				break;
				
			case "nop": 
					if( ds_list_find_index(_changed,i) == -1 && !_hasChanged ) {
						ds_list_add(_changed,i);
						if( _instructions[i][1] != 0 ) {
							_accuTemp = _accumulator;
							i += _instructions[i][1]-1;
							_hasChanged = true;
						}
					}
				break;
		}
	}
	
	ds_list_destroy(_changed);
	ds_list_destroy(_repeat);
	
	return _accumulator;
}

// Made a bruteforce method just for the funsies after already solving part 2
// Turns out it's significantly slower unless the target instruction is 
// relatively early on in the file! (measured in VM)
// Proper solve avg. time: 30.27ms
// Bruteforce solve avg. time: 145.07ms (my input, changed in. 425)
// Proper solve avg. time: 26.35ms
// Bruteforce solve avg. time: 65.51ms  (another user, changed in. 195)
// Proper solve avg. time: 27.26ms
// Bruteforce solve avg. time: 84.37ms  (another user, changed in. 246)
function day8_part2_bf(input){
	var _instructions = input,
		_repeat = ds_list_create(),
		_accumulator = 0;
	
	for( var i = 0; i < array_length(_instructions); i++ ) {
		if( _instructions[i][0] == "nop" || _instructions[i][0] == "jmp" ) {
			_accumulator = 0;
			ds_list_clear(_repeat);
			
			if( _instructions[i][1] = 0 ) { continue; }
			_instructions[i][0] = (_instructions[i][0] == "nop" ? "jmp" : "nop");
			
			for( var j = 0; j < array_length(_instructions); j++ ) {
				if( ds_list_find_index(_repeat,j) > -1 ) {
					break;
				}
				
				ds_list_add(_repeat, j);
				switch( _instructions[j][0] ) {
					case "acc": _accumulator += _instructions[j][1]; break;
					case "jmp": j += _instructions[j][1]-1; break;
					case "nop": break;
				}
			}
			
			_instructions[i][0] = (_instructions[i][0] == "nop" ? "jmp" : "nop");
			
			if( j == array_length(_instructions) ) { 
				ds_list_destroy(_repeat);
				show_debug_message( "Changed instruction: "+string(i));
				return _accumulator;
			}
		}
	}
}

function day8_input() {
	var _file = file_text_open_read("8.txt"),
	_input = [],
	_line,
	_instr;
	
	while( !file_text_eof(_file) ) {
		_line = file_text_readln(_file);
		_line = string_strip( _line, ["\n","\r"] );
		_instr = string_split( _line, " ", type_string );
		_input[array_length(_input)] = [_instr[0],real(_instr[1])];
	}
	
	return _input;
}