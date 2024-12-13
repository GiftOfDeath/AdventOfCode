// VM:
//   Input parsing time: 2.39ms
//   P1 solve avg. time: 328µs
//   P2 solve avg. time: 353µs
// YYC:
//   Input parsing time: 1.70ms
//   P1 solve avg. time: 118µs
//   P2 solve avg. time: 123µs

function day13_input(file) {
	var _input = input_array( file );
	var _claw_machines = [];
	
	for( var i = 0; i < array_length( _input ); i++ ) {
		var _claw_mch = {};
		array_push( _claw_machines, _claw_mch );
		
		var _line = string_split( _input[i++], "," );
		_claw_mch.a_btn = [ real( string_digits( _line[0] ) ), real( string_digits( _line[1] ) ) ];
		
		var _line = string_split( _input[i++], "," );
		_claw_mch.b_btn = [ real( string_digits( _line[0] ) ), real( string_digits( _line[1] ) ) ];
		
		var _line = string_split( _input[i++], "," );
		_claw_mch.prize = [ real( string_digits( _line[0] ) ), real( string_digits( _line[1] ) ) ];
	}
		
	return _claw_machines;
}

function day13_part1(input){
	var _answer = 0,
		_machine;
	
	for( var i = 0; i < array_length(input); i++ ) {
		_machine   = input[i];
		
		var _target_x = _machine.prize[0];
		var _target_y = _machine.prize[1];
		
		var _a1 = _machine.a_btn[0], 
			_b1 = _machine.a_btn[1],
			_c1 = _machine.b_btn[0], 
			_d1 = _machine.b_btn[1];
		
		// Find the determinant
		var _det = 1 / ( ( _a1 * _d1 ) - ( _b1 * _c1 ) );
		
		// Inverse the matrix
		var _a2 = _det * _d1, 
			_b2 = _det *-_b1,
			_c2 = _det *-_c1, 
			_d2 = _det * _a1;
			
		var _ab = round( ( _target_x * _a2 ) + ( _target_y * _c2 ) ); // A-button presses
		var _bb = round( ( _target_x * _b2 ) + ( _target_y * _d2 ) ); // B-button presses
		
		if( (_a1 * _ab + _c1 * _bb ) == _target_x && (_b1 * _ab + _d1 * _bb) == _target_y ) {
			_answer += _ab*3 + _bb;
		}
	}
	
	return _answer;
}

function day13_part2(input){
	var _offset = 10000000000000,
		_answer = 0,
		_machine;
	
	for( var i = 0; i < array_length(input); i++ ) {
		_machine   = input[i];
		
		var _target_x = _machine.prize[0]+_offset;
		var _target_y = _machine.prize[1]+_offset;
		
		var _a1 = _machine.a_btn[0], 
			_b1 = _machine.a_btn[1],
			_c1 = _machine.b_btn[0], 
			_d1 = _machine.b_btn[1];
		
		// Find the determinant
		var _det = 1 / ( ( _a1 * _d1 ) - ( _b1 * _c1 ) );
		
		// Inverse the matrix
		var _a2 = _det * _d1, 
			_b2 = _det *-_b1,
			_c2 = _det *-_c1, 
			_d2 = _det * _a1;
			
		var _ab = round( ( _target_x * _a2 ) + ( _target_y * _c2 ) ); // A-button presses
		var _bb = round( ( _target_x * _b2 ) + ( _target_y * _d2 ) ); // B-button presses
		
		if( (_a1 * _ab + _c1 * _bb ) == _target_x && (_b1 * _ab + _d1 * _bb) == _target_y ) {
			_answer += _ab*3 + _bb;
		}
	}
	
	return _answer;
}


// Just leaving this here for funsies :D
function day13_part1_by_the_force_of_brute(input){
	
	var _cost_A = 3,
		_cost_B = 1,
		_answer = 0;
	
	var _machine,
		_A_presses,
		_B_presses,
		_max,
		_x, _y,
		_lowest_cost,
		_k;
		
	for( var i = 0; i < array_length(input); i++ ) {
		_machine   = input[i];
		_A_presses = 0;
		_B_presses = 0;
		_max = _machine.prize[0] div _machine.b_btn[0];
		
		_x = 0;
		_y = 0;
		_lowest_cost = infinity;
		
		for( var j = 0; j < _max+1; j++ ) {
			_x = j * _machine.b_btn[0];
			_y = j * _machine.b_btn[1];
			
			_k = 0;
			while( _x < _machine.prize[0] && _y < _machine.prize[1] ) {
				_k++;
				_x += _machine.a_btn[0];
				_y += _machine.a_btn[1];
			}
			
			if( _x == _machine.prize[0] && _y == _machine.prize[1] ) {
				var _cost = j * _cost_B + _k * _cost_A;
				if( _cost < _lowest_cost ) {
					_lowest_cost = _cost;
				}
			}
		}
		
		if( _lowest_cost != infinity ) {
			_answer += _lowest_cost;
		}
	}
	
	return _answer;
}