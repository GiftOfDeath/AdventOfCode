// VM:
//  P1 solve time: 1.084 seconds!
//  P2 solve time: 25.812 seconds!

// YYC: 
//  P1 solve time: 805.933ms
//  P2 solve time: 19.931 seconds!

// Uploading a separate better optimised version later, going to keep this up
// for educational purposes (for myself xD)

function day_12_input(file){
	var _f = file_text_open_read(file),
		_input = ds_map_create(),
		_cave;
	
	while( !file_text_eof(_f) ) {
		_cave =  string_split( string_strip( file_text_readln( _f ), ["\n","\r"] ), "-", type_string );
		
		if( _cave[0] == "start" ) {
			
			if( !is_array( _input[? _cave[0]] ) ) {
				_input[? _cave[0]] = [];
			}
			
			array_push( _input[? _cave[0]], _cave[1] );
			
		} else
		if( _cave[1] == "start" ) {
			
			if( !is_array( _input[? _cave[1]] ) ) {
				_input[? _cave[1]] = [];
			}
			
			array_push( _input[? _cave[1]], _cave[0] );
			
		} else {
			
			if( !is_array( _input[? _cave[0]] ) ) {
				_input[? _cave[0]] = [];
			}
			
			array_push( _input[? _cave[0]], _cave[1] );
			
			if( !is_array( _input[? _cave[1]] ) ) {
				_input[? _cave[1]] = [];
			}
			
			array_push( _input[? _cave[1]], _cave[0] );
		}
	}
	
	file_text_close(_f);
	
	return _input;
}

function day_12_part1( input ) {
	
	var _totalPaths = 0,
		_visited = [];
	
	_totalPaths += cave_navigator( input, "start", _visited );
	
	return _totalPaths;
}

function day_12_part2( input ) {	
	var _totalPaths = 0,
		_visited = [];
	
	_totalPaths += cave_navigator_deluxe( input, "start", _visited, true );
	
	return _totalPaths;
}

function cave_navigator( caves, node, visited ) {	
	// Reached the end, return 1 to confirm a viable path
	if( node == "end" ) {
		return 1;
	}
	
	var _possiblePaths = [],
		_neighbours,
		_confirmedPaths = 0,
		_passVisited = [];
	
	array_copy( _possiblePaths, 0, caves[? node], 0, array_length(caves[? node]) );
	array_copy( _passVisited, 0, visited, 0, array_length(visited) );
	
	if( node == string_lower(node) ) {
		array_push( _passVisited, node );
	}
	
	// Remove visited small caves from the list of possible paths
	for( var i = array_length(_possiblePaths)-1; i >= 0; i-- ) {
		if( array_contains( _passVisited, _possiblePaths[i] ) ) {
			array_delete( _possiblePaths, i, 1 );
		}
	}
	
	_neighbours = array_length(_possiblePaths );
	
	// If no possible paths, it's a dead end
	if( _neighbours == 0 ) {
		return 0;
	}
	
	for( var i = 0; i < _neighbours; i++ ) {
		_confirmedPaths += cave_navigator( caves, _possiblePaths[i], _passVisited );
	}
	
	return _confirmedPaths;
}

function cave_navigator_deluxe( caves, node, visited, canVisitTwice ) {
	// Reached the end, return 1 to confirm a viable path
	if( node == "end" ) {
		return 1;
	}
	
	var _possiblePaths = [],
		_neighbours,
		_confirmedPaths = 0,
		_passVisited = [];
	
	array_copy( _possiblePaths, 0, caves[? node], 0, array_length(caves[? node]) );
	array_copy( _passVisited, 0, visited, 0, array_length(visited) );
	
	if( node != "start" && node == string_lower(node) ) {
		if( canVisitTwice && array_contains( _passVisited, node ) ) {
			canVisitTwice = false;
		}else{
			array_push( _passVisited, node );
		}
	}
	
	// Remove visited small caves from the list of possible paths
	
	if( !canVisitTwice ) {
		for( var i = array_length(_possiblePaths)-1; i >= 0; i-- ) {
			if( array_contains( _passVisited, _possiblePaths[i] ) ) {
				array_delete( _possiblePaths, i, 1 );
			}
		}
	}
	
	_neighbours = array_length(_possiblePaths );
	
	// If no possible paths, it's a dead end
	if( _neighbours == 0 ) {
		return 0;
	}
	
	for( var i = 0; i < _neighbours; i++ ) {
		_confirmedPaths += cave_navigator_deluxe( caves, _possiblePaths[i], _passVisited, canVisitTwice );
		//_confirmedPaths += cave_navigator_deluxe( caves, _possiblePaths[i], _passVisited, false, pString );
	}
	
	return _confirmedPaths;
}


// Just a version with a nice debugging method to find which paths didn't get generated
function cave_navigator_string( caves, node, visited, pathString) {
	pathString += ","+node;
	
	// Reached the end, return 1 to confirm a viable path
	if( node == "end" ) {
		log( pathString );
		return 1;
	}
	
	var _possiblePaths = [],
		_neighbours,
		_confirmedPaths = 0,
		_passVisited = [];
	
	array_copy( _possiblePaths, 0, caves[? node], 0, array_length(caves[? node]) );
	array_copy( _passVisited, 0, visited, 0, array_length(visited) );
	
	if( node == string_lower(node) ) {
		array_push( _passVisited, node );
	}
	
	// Remove visited small caves from the list of possible paths
	for( var i = array_length(_possiblePaths)-1; i >= 0; i-- ) {
		if( array_contains( _passVisited, _possiblePaths[i] ) ) {
			array_delete( _possiblePaths, i, 1 );
		}
	}
	
	_neighbours = array_length(_possiblePaths );
	
	// If no possible paths, it's a dead end
	if( _neighbours == 0 ) {
		return 0;
	}
	
	for( var i = 0; i < _neighbours; i++ ) {
		_confirmedPaths += cave_navigator( caves, _possiblePaths[i], _passVisited, pathString );
	}
	
	return _confirmedPaths;
}







