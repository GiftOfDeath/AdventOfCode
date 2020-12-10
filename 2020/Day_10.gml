// Don't ask me how any of this works
// Part 1 solve avg. time: 0.19ms
// Part 2 solve avg. time: 25.35ms

function day10_part1(input){
	var _joltage = 0,
		_1jolt = 0,
		_2jolt = 0,
		_3jolt = 1;
	
	var adapters = ds_list_create();
	ds_list_copy(adapters,input);
	ds_list_sort( adapters, true );
	
	for( var i = 0; i < ds_list_size(adapters); i++ ) {
		switch( adapters[| i]-_joltage ) {
			case 1: _1jolt++; break;
			case 2: _2jolt++; break;
			case 3: _3jolt++; break;
		}
		
		_joltage = adapters[| i];
	}
	
	ds_list_destroy(adapters);
	var _sum = _1jolt+_2jolt+_3jolt;
	return string(_1jolt*_3jolt)+" (End joltage: "+string(_joltage)+", distribution: 1-jolt "+string(_1jolt)+", 2-jolt "+string(_2jolt)+", 3-jolt "+string(_3jolt)+", total adapters: "+string(ds_list_size(input))+", distribution sum: "+string(_sum)+")";
}

function day10_part2(input) {
	var _arrangements = 0;
	
	var adapters = ds_list_create();
	ds_list_copy( adapters, input );
	ds_list_sort( adapters, false );
	
	var visited = ds_map_create();
	
	
	_arrangements = day10_possible_adapters(adapters,visited,0);
	
	var _s = 0;
	for( var i = 1; i <= 3; i++ ) {
		if( adapters[| 0]-adapters[| i] <= 3 ) {
			_s += visited[? i];
		}
	}
	
	ds_list_destroy( adapters );
	ds_map_destroy( visited );
	
	return _s;
}

function day10_possible_adapters(list,visited,pos) {
	if( !is_undefined( visited[? pos] ) ) {
		return visited[? pos];
	}
	
	var _matches = 0,
		_diff;
	
	for( var i = pos; i < ds_list_size(list); i++ ) {
		_matches = 0;
		
		if( list[|i ] <= 3 ) {
			_matches++;
		}
		
		for( var j = i+1; j < ds_list_size(list); j++ ) {
			_diff = list[| i]-list[| j];
			
			if( _diff <= 3 ) {
				if( is_undefined( visited[? j] ) ) {
					_matches += day10_possible_adapters(list,visited,j);
				}else{
					_matches += visited[? j];
				}
			}else{
				break;
			}
		}
		
		visited[? i] = _matches;
	}
	
	return _matches;
}