// VM:
//   P1 solve avg. time: 9.94ms
//   P2 solve avg. time: 4.64ms
// YYC:
//   P1 solve avg. time: 3.56ms
//   P2 solve avg. time: 2.88ms


function day05_part1(input){
	var _rules = ds_map_create(),
		_pages_start = array_find_index(input, function( a, b ) { return a == ""; } ),
		_answer = 0;
	
	var _new_rule;
	// Rules format: map[? page_number] = [ pages, that, must, be, after ];	
	for( var i = 0; i < _pages_start; i++ ) {
		_new_rule = string_split( input[i], "|" );
		
		if( !is_array( _rules[? _new_rule[0]] ) ) {
			_rules[? _new_rule[0]] = [];
		}
		
		array_push( _rules[? _new_rule[0]], real( _new_rule[1] ) );
	}
	
	var _length = array_length( input );
	for( var i = _length-1; i > _pages_start; i-- ) {
		var _manual = string_split_numbers( input[i], "," ),
			_manual_length = array_length( _manual ),
			_valid = true;
		
		for( var j = 0; j < _manual_length; j++ ) {
			var _page_rules = _rules[? string(_manual[j])];
			
			// If sorting rules for the page has been defined, check if 
			// there are pages to the left of it that shouldn't be there
			for( var k = 0; k < j; k++ ) {
				if( array_contains( _page_rules, _manual[k] ) ) {
					_valid = false;
					break;
				}
			}
				
			if( !_valid ) break;
			
			if( j == _manual_length-1 ) {
				_answer += _manual[ _manual_length div 2 ];
				// Remove the valid manual from the input to avoid redundant validation in part 2
				array_delete( input, i, 1 );
			}
		}
	}
	
	ds_map_destroy( _rules );
	
	return _answer;
}

function day05_part2(input){
	var _rules = ds_map_create(),
		_pages_start = array_find_index(input, function( a, b ) { return a == ""; } ),
		_answer = 0;
	
	var _new_rule;
	// Rules format: map[? page_number] = [ pages, that, must, be, after ];	
	for( var i = 0; i < _pages_start; i++ ) {
		_new_rule = string_split( input[i], "|" );
		
		if( !is_array( _rules[? _new_rule[0]] ) ) {
			_rules[? _new_rule[0]] = [];
		}
		
		array_push( _rules[? _new_rule[0]], real( _new_rule[1] ) );
	}
	
	function _sort_pages( _pages, _sort_rules ) {
		var _length = array_length(_pages);
		
		for( var i = 0; i < _length; i++ ) {
			var _rule = _sort_rules[? string( _pages[i] )];
			
			// Find the left-most page the current page should be left of and
			// insert it there, if it has rules defined for it
			for( var j = 0; j < i; j++ ) {
				if( array_contains( _rule, _pages[j] ) ) {
					array_insert( _pages, j, _pages[i] );
					array_delete( _pages, i+1, 1 );
					break;
				}
			}
		}
	}
	
	var _length = array_length( input );
	for( var i = _pages_start+1; i < _length; i++ ) {
		var _manual = string_split_numbers( input[i], "," ),
			_manual_length = array_length( _manual );
			
			// Sort the manual pages and find the page in the middle
			_sort_pages( _manual, _rules );
			_answer += _manual[ _manual_length div 2 ];
	}
	
	ds_map_destroy( _rules );
	
	return _answer;
}