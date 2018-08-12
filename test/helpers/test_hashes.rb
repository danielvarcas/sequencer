@hash_abc = {
	"a" => "", 
	"b" => "c", 
	"c" => ""
}

@hash_long = {
	"a" => "",
	"b" => "c",
	"c" => "f",
	"d" => "a",
	"e" => "b",
	"f" => ""
}

@hash_self_dependent = {
	"a" => "",
	"b" => "",
	"c" => "c"
}

@hash_circular ={
	"a" => "",
	"b" => "c",
	"c" => "f",
	"d" => "a",
	"e" => "",
	"f" => "b"
}