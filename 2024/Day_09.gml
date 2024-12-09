// VM:
//   Input parsing time: 8s 387ms
//   P1 solve avg. time: 25.35ms
//   P2 solve avg. time: 2s 299ms
// YYC:
//   Input parsing time: 8s 262ms
//   P1 solve avg. time: 2.18ms
//   P2 solve avg. time: 162.88ms


function day09_input(file) {
	var _disk_data_raw = input_string( file ),
		_disk_data_p1 = array_create( string_length(_disk_data_raw) ),
		_disk_data_p2 = [],
		_block_size;
	
	// Part 1 format: array presenting each element as either free (-1) or a file id (0...n)
	// Part 2 format: [file_id, block_size]
			
	var _pos = 0;
	for(  var i = 1; i <= string_length(_disk_data_raw); i++ ) {
		_block_size = string_byte_at( _disk_data_raw, i )-48;
		
		// every 2nd data point represents free blocks
		if( i % 2 == 0 ) {
			repeat( _block_size ) {
				_disk_data_p1[_pos++] = -1;
			}
			
			if( _block_size > 0 ) {
				array_push( _disk_data_p2, [-1, _block_size] );
			}
		} else {
			repeat( _block_size ) {
				_disk_data_p1[_pos++] = i div 2;
			}
			
			array_push( _disk_data_p2, [i div 2, _block_size] );
		}
	}
	
	return [_disk_data_p1, _disk_data_p2];
}

function day09_part1(input){
	var _disk = input[0];
	
	var _disk_size = array_length(_disk),
		_first_free_space = 1; // Use to keep track from where to loop right for placement
		
	for( var i = _disk_size-1; i >= _first_free_space; i-- ) {
		if( _disk[i] == -1 ) continue;
		
		// j < i to make sure we don't move file blocks right instead of left
		for( var j = _first_free_space; j < i; j++ ) { 
			
			// If block is free move the file block here
			if( _disk[j] == -1 ) {
				_disk[j] = _disk[i];
				_disk[i] = -1;
				_first_free_space = j+1;
				break;
			}
		}
		
		if( _first_free_space >= i ) break;
	}
	
	// Calculate the checksum (sum of all file blocks' position * file_id)
	var _answer = 0;
	for(  var i = 0; i < array_length(_disk); i++ ) {
		if( _disk[i] == -1 ) break;
		_answer += i*_disk[i];
	}
	
	return _answer;
}

function day09_part2(input){
	var _disk = input[1],
		_first_free_space = 1,
		_first_free_space_moved;
	
	var _disk_size = array_length(_disk)-1;
	for( var i = _disk_size; i > _first_free_space; i-- ) {
		// Skip checks of already free blocks
		if( _disk[i][0] == -1 ) continue;
		
		_first_free_space_moved = false;
		for( var j = _first_free_space; j < i; j++ ) {
			var _is_free = _disk[j][0] == -1;
			
			// Keep track of the earliest free block
			if( !_first_free_space_moved && _is_free ) {
				_first_free_space = j;
				_first_free_space_moved = true;
			}
			
			// If the block is free and can fit the file
			if( _is_free && _disk[j][1] >= _disk[i][1] ) {
				
				// Find out if we have leftover free blocks
				var _new_free_blocks = _disk[j][1] - _disk[i][1];
				
				_disk[j][0] = _disk[i][0];
				_disk[j][1] = _disk[i][1]
				
				// Mark the file's original block as free
				_disk[i][0] = -1;
				
				if( _new_free_blocks > 0 ) {
					if( _disk[j+1][0] == -1 ) {
						_disk[j+1][1] += _new_free_blocks;
					} else {
						// Insert the reminder of the free blocks right of the moved file
						array_insert( _disk, j+1, [-1, _new_free_blocks] );
						i++;
					}
				}
				
				break;
			}
		}
	}
	
	var _pos = 0,
		_answer = 0;
		
	// Calculate the checksum (still sum of all file blocks' position * file_id)
	for( var i = 0; i < array_length( _disk ); i++ ) {
		if( _disk[i][0] != -1 ) {
			repeat( _disk[i][1] ) {
				_answer += _disk[i][0] * _pos;
				_pos++;
			}
		} else {
			_pos += _disk[i][1];
		}
	}
	
	return _answer;
}