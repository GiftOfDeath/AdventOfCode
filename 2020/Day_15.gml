// VM:
// YYC: 

// No timers here for the time being, part 2 took about 53min 18s to finish 
// compiled with YYC. Gotta come up with something better.

function day15_part1(input, turns){
	var _numbers = ds_map_create(),
		_input_l,
		_n1,
		_n2;
	
	if( is_string(input) ) {
		input = string_split( input, ",", type_real );
		_input_l = array_length(input);
	}
	
	_n1 = 0;
	for( var i = 1; i < turns; i++ ) {
		if( i-1 < _input_l ) {
			_numbers[? input[i-1]] = i;
		}else{
			if( !is_undefined( _numbers[? _n1] ) ) {
				_n2 = (i)-_numbers[? _n1];
				_numbers[? _n1] = i;
				_n1 = _n2;
			}else{
				_numbers[? _n1] = i;
				_n1 = 0;
			}
		}
	}
	
	return _n1;
}

function day15_part2( input, turns, current, numbers, last_number ) {
	var _input_l,
	_n1,
	_n2,
	_t;
	
	if( is_undefined(numbers) ) {
		numbers = ds_list_create();
		input = string_split( input, ",", type_real );
		_input_l = array_length(input);
	}else{
		_input_l = 0;
	}
	
	_n1 = last_number;
	_t = get_timer();
	for( var i = current; i < turns; i++ ) {
		if( i-1 < _input_l ) {
			ds_list_add(numbers, input[i-1]);
		}else{
			var _pos = ds_list_find_index(numbers,_n1);
			if( _pos > -1 ) {
				_n2 = ds_list_size(numbers)-_pos-1;
				ds_list_delete(numbers,_pos);
				ds_list_add( numbers,_n1 );
				_n1 = _n2;
			}else{
				ds_list_add(numbers,_n1);
				_n1 = 0;
			}
		}
		
		if( get_timer()-_t > 499999 ) {
			i++;
			break;
		}
	}
	
	if( i == turns ) {
		return _n1;
	}else{
		return [i, numbers, _n1];
	}
}

function day15_part2_map(input, turns, current, numbers, last_number){
	var _input_l,
		_n1,
		_n2,
		_t;
	
	if( is_undefined(numbers) ) {
		numbers = ds_map_create();
		input = string_split( input, ",", type_real );
		_input_l = array_length(input);
	}else{
		_input_l = 0;
	}
	
	_n1 = last_number;
	_t = get_timer();
	for( var i = current; i < turns; i++ ) {
		if( i-1 < _input_l ) {
			numbers[? input[i-1]] = i;
		}else{
			if( !is_undefined( numbers[? _n1]) ) {
				_n2 = (i)-numbers[? _n1];
				numbers[? _n1] = i;
				_n1 = _n2;
			}else{
				numbers[? _n1] = i;
				_n1 = 0;
			}
		}
		
		if( get_timer()-_t > 499999 ) {
			i++;
			break;
		}
	}
	
	if( i == turns ) {
		return _n1;
	}else{
		return [i, numbers, _n1];
	}
}