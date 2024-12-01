// VM:
//   P1 solve avg. time: 2.27ms
//   P2 solve avg. time: 2.12ms
// YYC:
//   P1 solve avg. time: 1.70ms
//   P2 solve avg. time: 1.42ms


function day01_part1(input){
	
	var _left = [], _right = [];
	for( var i = 0; i < array_length(input); i++ ) {
		var _line = string_split( input[i], "   ", true );
		
		array_push( _left, real( _line[0] ) );
		array_push( _right, real( _line[1] ) );
	}
	
	array_sort( _left, true );
	array_sort( _right, true );
	
	var _total = 0;
	
	for( var i = 0; i < array_length( input ); i++ ) {
		_total += abs( _right[i]-_left[i] );
	}
	
	return _total;
}

function day01_part2(input){
	
	var _left = [], _right = {};
	
	for( var i = 0; i < array_length(input); i++ ) {
		var _line = string_split( input[i], "   ", true );
		
		array_push( _left, real( _line[0] ) );
		
		var _right_value = struct_get( _right, _line[1] );
		if( _right_value != undefined ) {
			struct_set( _right, _line[1], _right_value+1 )
		} else {
			struct_set( _right, _line[1], 1 );
		}
	}
	
	var _total = 0;
	
	for( var i = 0; i < array_length( input ); i++ ) {	
		var _similarity = struct_get( _right, _left[i] );
		
		if( _similarity != undefined ) {
			_total += _left[i] * _similarity;
		}
	}
	
	return _total;
}