judiciary={
	--who can fill next after....
	ffnn = {
		{rotation = 0,tiles={"A","B","C","D"}}
	},
	vfnn = {
		{rotation = 90,tiles={"M","O","P","Q"}}
	},
	pfnn = {
		{rotation = 90,tiles={"N","L","K","J"}}
	},
	pffn = {
		{rotation = 90,tiles={"A","B"}}
	},
	vffn = {
		{rotation = 90,tiles={"C","D"}}
	},
	--next line
	fpnn = {
		{rotation = 0,tiles={"J","N","P","Q"}}
	},
	fvnn = {
		{rotation = 0,tiles={"K","L","M","O"}}
	},
	fpnf = {
		{rotation = 270,tiles={"A","D"}}
	},
	fvnf = {
		{rotation = 270,tiles={"C","B"}}
	},
	--next line
	vvnf = {
		{rotation = 270,tiles={"M","L"}}
	},
	pvnf = {
		{rotation = 270,tiles={"N","P"}}
	},
	vpnf = {
		{rotation = 270,tiles={"O","K"}}
	},
	ppnf = {
		{rotation = 270,tiles={"J","Q"}}
	},
	--next line
	vpfn = {
		{rotation = 180,tiles={"N","L"}}
	},
	pvfn = {
		{rotation = 180,tiles={"O","Q"}}
	},
	vvfn = {
		{rotation = 180,tiles={"M","P"}}
	},
	ppfn = {
		{rotation = 180,tiles={"J","K"}}
	},
	--last corner
	ppff = {
		{rotation = 180,tiles={"A"}}
	},
	pvff = {
		{rotation = 180,tiles={"D"}}
	},
	vpff = {
		{rotation = 180,tiles={"B"}}
	},
	vvff = {
		{rotation = 180,tiles={"C"}}
	},
	--middle 
	ppnn = {
		{ rotation = 90,tiles={"E","G","F"} },
		{ rotation = 180,tiles={"F"} }
	},
	vvnn = {
		{ rotation = 270, tiles={"G","H","I"}},
		{ rotation = 180, tiles={"H"} }
	},
	vpnn = {
		{ rotation = 270, tiles={"F"}},
		{ rotation = 180, tiles={"G"}},
		{ rotation = 90, tiles={"H"}}
	},
	pvnn = {
		{ rotation = 0, tiles={"F","G","H"}}
	},

}
function judiciary:where_is_fx( ... )
	local x,cols = ...
	
	if x == 1 then
		return 1
	elseif x == cols then
		return 3

	end
	
	return nil;
end
function judiciary:where_is_fy( ... )
	local y,rows = ...
	if y == 1 then
		return 2
	elseif y == rows then
		return 4

	end
end


return judiciary