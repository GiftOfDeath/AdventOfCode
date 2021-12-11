// VM:
//  P1 solve avg. time: 52.18ms;  median: 51.13ms
//  P2 solve avg. time: 172.46ms; median: 169.23ms

// YYC: 
//  P1 solve avg. time: 17.34ms; median: 16.74ms
//  P2 solve avg. time: 58.66ms; median: 56.55ms

function day_11_input(){
	var _arr = [],
		_line,
		_n,
		_f = file_text_open_read( "11.txt" );
	
	while( !file_text_eof(_f) ) {
		_line = string_strip( file_text_readln( _f ), ["\n","\r"] );
		_n = array_length(_arr);
		for( var i = 0; i < string_length(_line); i++ ) {
			_arr[_n][i] = real(string_char_at(_line,i+1));
		}
	}
	
	file_text_close( _f );
	
	return _arr;
}

function day_11_part1(input, steps) {
	var _flashes = 0,
		_reset = ds_stack_create();
	
	// Use recursion to add to the power of adjecent octopi and
	// flash them if they reach >9 power.
	function flash_octopus( xx, yy, octopi, resetStack ) {
		var _offset = [],
			_sum = 1,
			_maxX = array_length(octopi)-1,
			_maxY = array_length(octopi[0])-1;
		#region Offset coordinates (kinda micro optimisation)
			_offset[0] = [ 1, 0];
			_offset[1] = [ 1,-1];
			_offset[2] = [ 0,-1];
			_offset[3] = [-1,-1];
			_offset[4] = [-1, 0];
			_offset[5] = [-1, 1];
			_offset[6] = [ 0, 1];
			_offset[7] = [ 1, 1];
		#endregion
		
		for( var i = 0; i < 8; i++ ) {
			var _x = xx+_offset[i][0],
				_y = yy+_offset[i][1];
			
			if( _x < 0 || _x > _maxX || _y < 0 || _y > _maxY ) continue;
			
			octopi[@ _x][@ _y] += 1;
			
			if( octopi[_x][_y] == 10 ) {
				_sum += flash_octopus( _x, _y, octopi, resetStack );				
			}
		}
		
		ds_stack_push( resetStack, [xx,yy] );
		
		return _sum;
	}
	
	repeat(steps) {
		for( var i = 0; i < array_length(input); i++ ) {
			for( var j = 0; j < array_length(input[i]); j++ ) {
				input[@ i][@ j] += 1;
			
				if( input[i][j] == 10 ) {
					_flashes += flash_octopus( i, j, input, _reset );
				}
			}
		}
		
		while( !ds_stack_empty(_reset) ) {
			var _coords = ds_stack_pop(_reset);
			input[@ _coords[0]][@ _coords[1]] = 0;
		}
	}
	
	ds_stack_destroy(_reset);
	
	return _flashes;
}

// Part 2 just calls part 1 till the max amount of flashes occurs
// in the same step
function day_11_part2(input) {
	var _flashes = 0,
		_step = 0,
		_maxFlashes = array_length(input)*array_length(input[0]);
	
	while( _flashes != _maxFlashes ) {
		_flashes = day_11_part1( input, 1 );
		_step++;
	}
	
	return _step;
}