/proc/extend_corner(list/corner, range = world.view)
	var/x
	var/y
	var/angle = arctan(corner[1], corner[2])
	var/slope_x = cos(angle)
	var/slope_y = sin(angle)
	//corners of bounding box
	if(abs(slope_x) == abs(slope_y))
		x = (SIGN(slope_x) * range) + (SIGN(slope_x) * 0.5)
		y = (SIGN(slope_y) * range) + (SIGN(slope_y) * 0.5)
	//sides of bounding box
	else if(abs(slope_x) > abs(slope_y))
		x = (SIGN(slope_x) * range) + (SIGN(slope_x) * 0.5)
		y = (slope_y * range)
	//top or bottom
	else
		x = (slope_x * range)
		y = (SIGN(slope_y) * range) + (SIGN(slope_y) * 0.5)

	return list(x, y)

/proc/get_shadows(x_offset, y_offset, range, icon_size = TRIANGLE_ICON_SIZE, icon = TRIANGLE_ICON, icon_state = "triangle")
	. = list()
	var/list/list/corners = list(
		"NW" = list((x_offset - 0.5), (y_offset + 0.5)),
		"SW" = list((x_offset - 0.5), (y_offset - 0.5)),
		"NE" = list((x_offset + 0.5), (y_offset + 0.5)),
		"SE" = list((x_offset + 0.5), (y_offset - 0.5)),
	)
	var/list/list/corners_ext = list(
		"NW" = extend_corner(corners["NW"], range),
		"SW" = extend_corner(corners["SW"], range),
		"NE" = extend_corner(corners["NE"], range),
		"SE" = extend_corner(corners["SE"], range),
	)
	for(var/key as anything in corners)
		corners[key][1] = round(corners[key][1] * world.icon_size)
		corners[key][2] = round(corners[key][2] * world.icon_size)
	for(var/key as anything in corners_ext)
		corners_ext[key][1] = round(corners_ext[key][1] * world.icon_size)
		corners_ext[key][2] = round(corners_ext[key][2] * world.icon_size)
	var/angle = ATAN2(y_offset, x_offset)
	var/dir = angle2dir(angle)
	if(dir & NORTH)
		. += get_triangle_appearance_from_points(corners_ext["SW"], corners["SW"], corners["SE"], icon_size, icon, icon_state)
		. += get_triangle_appearance_from_points(corners_ext["SE"], corners["SE"], corners_ext["SW"], icon_size, icon, icon_state)
	else if(dir & SOUTH)
		. += get_triangle_appearance_from_points(corners_ext["NW"], corners["NW"], corners["NE"], icon_size, icon, icon_state)
		. += get_triangle_appearance_from_points(corners_ext["NE"], corners["NE"], corners_ext["NW"], icon_size, icon, icon_state)

	if(dir & WEST)
		. += get_triangle_appearance_from_points(corners_ext["NE"], corners["NE"], corners["SE"], icon_size, icon, icon_state)
		. += get_triangle_appearance_from_points(corners_ext["SE"], corners["SE"], corners_ext["NE"], icon_size, icon, icon_state)
	else if(dir & EAST)
		. += get_triangle_appearance_from_points(corners_ext["NW"], corners["NW"], corners["SW"], icon_size, icon, icon_state)
		. += get_triangle_appearance_from_points(corners_ext["SW"], corners["SW"], corners_ext["NW"], icon_size, icon, icon_state)

	return .
