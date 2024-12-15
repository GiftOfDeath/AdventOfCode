// VM:
//   Input parsing time: 4.88ms
//   P1 solve avg. time: 1.43ms
//   P2 solve avg. time: 94.45ms
// YYC:
//   Input parsing time: 1.29ms
//   P1 solve avg. time: 55µs
//   P2 solve avg. time: 11.87ms

function day14_input(file) {
	var _input = input_array( file );
	
	var _line,
		_robots = [];
	
	for( var i = 0; i < array_length( _input ); i++ ) {
		_line = string_replace( string_replace( _input[i], "p=", "" ), " v=", "," );
		array_push( _robots, string_split_numbers( _line, "," ) );
	}
	
	return _robots;
}

function day14_part1(input){
	// Example 11,7
	// Actual input 101,103
	var _width  = 101,
		_height = 103,
		_robots_l = array_length( input ),
		_robot,
		_w_center = _width div 2,
		_h_center = _height div 2;
	
	
	var _quadrants = [0,0,0,0];
	
	for( var i = 0; i < _robots_l; i++ ) {
		_robot = input[i];
		
		_robot[0] = ( _robot[0]+_robot[2] * 100 ) mod _width;
		if( _robot[0] < 0 ) _robot[0] = _width + _robot[0];
			
		_robot[1] = ( _robot[1]+_robot[3] * 100 ) mod _height;
		if( _robot[1] < 0 ) _robot[1] = _height + _robot[1];
		
		
		if( _robot[0] < _w_center ) {
			if( _robot[1] < _h_center ) {
				_quadrants[0] += 1;
			}else if( _robot[1] > _h_center ){
				_quadrants[2] += 1;
			}
		} else if( _robot[0] > _w_center ) {
			if( _robot[1] < _h_center ) {
				_quadrants[1] += 1;
			}else if( _robot[1] > _h_center ){
				_quadrants[3] += 1;
			}
		}
	}
	
	
	return _quadrants[0] * _quadrants[1] * _quadrants[2] * _quadrants[3];
}


function day14_part2(input){
	// Actual input 101,103
	var _width  = 101,
		_height = 103,
		_w_center = _width div 2,
		_h_center = _height div 2,
		_max_iterations = _width*_height-100, // subtract 100 because part 1
		_robots_l = array_length( input ),
		_robot,
		_quadrants,
		_increment = 1,
		_safety_factor,
		_previous_sf = 0,
		_lowest_sf = infinity,
		_outlier = 0,
		_answer = 0;
	
	
	for( var k = 1; k < _max_iterations; k += _increment ) {
		_quadrants = [0,0,0,0];
		
		for( var i = 0; i < _robots_l; i++ ) {
			_robot = input[i];
			
			_robot[0] = ( _robot[0]+_robot[2] * _increment ) mod _width;
			if( _robot[0] < 0 ) _robot[0] = _width + _robot[0];
			
			_robot[1] = ( _robot[1]+_robot[3] * _increment ) mod _height;
			if( _robot[1] < 0 ) _robot[1] = _height + _robot[1];
			
			// Add the robot to a quadrant's robot count
			if( _robot[0] < _w_center ) {
				if( _robot[1] < _h_center ) {
					_quadrants[0] += 1;
				}else if( _robot[1] > _h_center ){
					_quadrants[2] += 1;
				}
			} else if( _robot[0] > _w_center ) {
				if( _robot[1] < _h_center ) {
					_quadrants[1] += 1;
				}else if( _robot[1] > _h_center ){
					_quadrants[3] += 1;
				}
			}
		}
		
		_safety_factor = _quadrants[0] * _quadrants[1] * _quadrants[2] * _quadrants[3];
		
		// Find an outlier in the safety factor to determine the recurrence of such
		if( _increment == 1 && _previous_sf > 0 && ( _previous_sf / _safety_factor > 2 ) ) {
			if( _outlier == 0 ) {
				_outlier = k;
			} else {
				// When we find a 2nd outlier adjust the increment of the positions 
				_increment = k-_outlier;
			}
		}
		
		// Lowest safety factor would mean the robots are either concentrated in the center
		// of the map, or in any single quadrant, forming a picture
		_lowest_sf = min( _safety_factor, _lowest_sf );
		
		if( _safety_factor == _lowest_sf ) {
			 // Add extra 100 because the robots resume from part 1 positions
			 // and deduct the time it takes for the positions of each robot to cycle back to start
			_answer = k+100;
		}
		
		_previous_sf = _safety_factor;
	}
	
	return _answer;
}