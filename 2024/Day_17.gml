// VM:
//   Input parsing time: 222µs
//   P1 solve avg. time: 56µs
//   P2 solve avg. time: 4.18ms
// YYC:
//   Input parsing time: 220µs
//   P1 solve avg. time: 33µs
//   P2 solve avg. time: 886µs

function day17_input(file) {
	var input = input_array( file );
	
	var _registers = [];
	for( var i = 0; i < 3; i++ ) {
		array_push( _registers, real( string_digits(input[i]) ) );
	}
	
	var _instructions = string_split_numbers( string_replace( input[4], "Program: ", "" ), "," );
	
	return [ _registers, _instructions ];
}

function day17_part1(input){
	//log( input );
	var _register = input[0],
		_instructions = input[1];
	
	// Registers for code readability
	var r_A = 0,
		r_B = 1,
		r_C = 2;
		
	// Operations
	var adv = 0,
		bxl = 1,
		bst = 2,
		jnz = 3,
		bxc = 4,
		out = 5,
		bdv = 6,
		cdv = 7;
	
	var get_combo_operand = function( operand, register ) {
		if( operand >= 0 && operand <= 3 ) return operand;
		
		if( operand == 4 ) return register[0];
		if( operand == 5 ) return register[1];
		if( operand == 6 ) return register[2];
		
		if( operand == 7 ) log( "Error! Operand 7 found, something's gone awry!" );
	}
		
	var i = 0,
		output = "",
		_l = array_length(_instructions)-1;
	while( i < _l ) {
		
		switch( _instructions[i] ) {
			// Performs division: register_A / 2^combo_operand (op. 0)
			case adv: var _num = _register[ r_A ];
					  var _den = power( 2, get_combo_operand( _instructions[i+1], _register ) );
					  _register[ r_A ] = _num div _den;
				break;
		
			// Performs bitwise XOR on register_B of the literal operator
			case bxl: _register[ r_B ] = _register[ r_B ] ^ _instructions[i+1];
				break;
			
			// Combo operator mod 8
			case bst: _register[ r_B ] = get_combo_operand( _instructions[i+1], _register ) mod 8;
				break;
		
			// Does nothing if register_A == 0, else i = literal operand, skip i+2
			case jnz: if( _register[ r_A ] != 0 ) {
					      i = _instructions[i+1];
						  continue;
					  }
				break;
		
			// Performs B ^ C and stores in register_C
			case bxc: _register[ r_B ] = _register[ r_B ] ^ _register[ r_C ];
				break;
			
			// Outputs its combo operand mod 8
			case out: output += string( get_combo_operand( _instructions[i+1], _register ) mod 8 )+",";
				break;
			
			// Same as adv, but stored in B
			case bdv: var _num = _register[ r_A ];
					  var _den = power( 2, get_combo_operand( _instructions[i+1], _register ) );
					  _register[ r_B ] = _num div _den;
				break;
				
			// Same as adv but stored in C
			case cdv: var _num = _register[ r_A ];
					  var _den = power( 2, get_combo_operand( _instructions[i+1], _register ) );
					  _register[ r_C ] = _num div _den;
				break;
		}
		
		i += 2;
	}	
	
	return string_delete( output, string_length(output), 1 );
}

function day17_part2(input){
	var _instructions = input[1];
		
	function get_combo_operand( operand, register ) {
		if( operand >= 0 && operand <= 3 ) return operand;
		
		if( operand == 4 ) return register[0];
		if( operand == 5 ) return register[1];
		if( operand == 6 ) return register[2];
		
		if( operand == 7 ) log( "Error! Operand 7 found, something's gone awry!" );
	}
	
	function test_output( arr1, arr2 ) {
		for( var i = 0; i < array_length(arr1); i++ ) {
			if( arr1[array_length(arr1)-1-i] != arr2[array_length(arr2)-1-i] ) {
				return false;
			}
		}
		
		return true;
	}
	
	function find_A( start_A, instructions ) {
		var _answer = 0;
		
		// Registers for code readability
		var r_A = 0,
			r_B = 1,
			r_C = 2;
		
		// Operations
		var adv = 0,
			bxl = 1,
			bst = 2,
			jnz = 3,
			bxc = 4,
			out = 5,
			bdv = 6,
			cdv = 7;
			
		var ip, 
			_l = array_length(instructions)-1, 
			output,
			_register; 
		
		for( var n = 0; n < 9; n++ ) {
			ip = 0;
			output = [];
			
			_register[0] = start_A+n;
			_register[1] = 0;
			_register[2] = 0;
						
			while( ip < _l ) {
			
				switch( instructions[ip] ) {
					// Performs division: register_A / 2^combo_operand (op. 0)
					case adv: var _num = _register[ r_A ];
								var _den = power( 2, get_combo_operand( instructions[ip+1], _register ) );
								_register[ r_A ] = _num div _den;
						break;
		
					// Performs bitwise XOR on register_B of the literal operator
					case bxl: _register[ r_B ] = _register[ r_B ] ^ instructions[ip+1];
						break;
			
					// Combo operator mod 8
					case bst: _register[ r_B ] = get_combo_operand( instructions[ip+1], _register ) mod 8;
						break;
		
					// Does nothing if register_A == 0, else i = literal operand, skip i+2
					case jnz: if( _register[ r_A ] != 0 ) {
									ip = instructions[ip+1];
									continue;
							  }
						break;
		
					// Performs B ^ C and stores in register_C
					case bxc: _register[ r_B ] = _register[ r_B ] ^ _register[ r_C ];
						break;
			
					// Outputs its combo operand mod 8
					case out: array_push( output, get_combo_operand( instructions[ip+1], _register ) mod 8 );
						break;
			
					// Same as adv, but stored in B
					case bdv: var _num = _register[ r_A ];
								var _den = power( 2, get_combo_operand( instructions[ip+1], _register ) );
								_register[ r_B ] = _num div _den;
						break;
				
					// Same as adv but stored in C
					case cdv: var _num = _register[ r_A ];
								var _den = power( 2, get_combo_operand( instructions[ip+1], _register ) );
								_register[ r_C ] = _num div _den;
						break;
				}
			
				ip += 2;
			}
			
			// If the output matches the tail end of the program, consider it viable
			// and try the next number
			if( test_output( output, instructions ) ) {
				if( array_length( output ) < array_length(instructions) ) {
					_answer = find_A( ( start_A + n ) * 8, instructions );
				} else {
					// If the program and output match fully, return the calculated A-registry value!
					return start_A + n;
				}
				
				// If we got a viable answer, return it
				if( _answer != -1 ) return _answer;
			}
		}
		
		// If the for loop capped the route had no viable answers
		return -1;
	}
	
	return find_A( 1, _instructions );
}