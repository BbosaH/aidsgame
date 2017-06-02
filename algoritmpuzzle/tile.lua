tile={
	width=0,
	height=0,
	orientation=0,
	boundary={"f","f","f","f"},
	name = nil,
	width_inc = 0,
	height_inc = 0
}

 function tile:new(boundary)
 	local o={}
 	setmetatable(o,self)
 	self.__index=self
 	o.boundary=boundary
 	return o
 end
 function tile:name_mask()
 	local maskname=self.boundary[1] .. self.boundary[2] .. self.boundary[3] .. self.boundary[4]
 	return maskname
 end

return tile
