// VM:
//  P1 solve avg. time: 0.40ms; median: 0.37m
//  P2 solve avg. time: 1.27ms; median: 1.21ms

// YYC: 
//  P1 solve avg. time: 0.08ms; median: 0.07ms
//  P2 solve avg. time: 0.24ms; median: 0.22ms

function day_06_input(){
	var _arr = [],
	_f = file_text_open_read( "06.txt" );
	
	_arr = string_split( file_text_readln( _f ), ",", type_real );
	file_text_close( _f );
	
	var _l = array_length( _arr ),
		_fish = [0,0,0,0,0,0,0,0,0];
	for( var i = 0; i < _l; i++ ) {
		_fish[ _arr[i] ]++;
	}
	
	file_text_close(_f);
	return _fish;
}

function day_06_goFish( array, days ) {
	var _l = array_length(array),
		_babies;
	for( var i = 0; i < days; i++ ) {
	
		_babies = array[0];
	
		for( var j = 0; j < _l-1; j++ ) {
			array[j] = array[j+1];
		}
	
		array[6] += _babies;
		array[_l-1] = _babies;
	}
	
	return array_sum(array);
}