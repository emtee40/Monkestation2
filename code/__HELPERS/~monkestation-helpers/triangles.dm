/// A list that caches base appearances of triangles for later access.
GLOBAL_LIST_EMPTY(triangle_appearances)
/// Big triangle size, can be useful if you're dealing with large triangles that might get pretty absurd transforms
#define TRIANGLE_ICON_BIG 'monkestation/code/modules/shadowcasting/icons/geometric_big.dmi'
#define TRIANGLE_ICON_BIG_SIZE 256

#define TRIANGLE_ICON 'monkestation/code/modules/shadowcasting/icons/geometric.dmi'
#define TRIANGLE_ICON_SIZE 32

/// A list that caches base appearances of lighting for later access.
GLOBAL_LIST_EMPTY(lighting_appearances)

/// Alpha of ALL lighting objects. Kept around for debug purposes.
GLOBAL_VAR_INIT(light_alpha, 255)
/// How much light power is multiplied by, to get the final color of a lighting object.
GLOBAL_VAR_INIT(light_power_multiplier, 0.75)
/**
 * List of plane offset + 1 -> mutable appearance to use.
 * Fills with offsets as they are generated.
 */
GLOBAL_LIST_INIT_TYPED(fullbright_overlays, /mutable_appearance, list(create_fullbright_overlay(0)))

/mutable_appearance/triangle
	icon = TRIANGLE_ICON
	icon_state = "triangle"
	color = COLOR_BLACK


/// Wrapper for get_triangle_appearance() that uses a list for every point
/proc/get_triangle_appearance_from_points(list/p1, list/p2, list/p3, icon_size = TRIANGLE_ICON_SIZE, icon = TRIANGLE_ICON, icon_state = "triangle")
	return get_triangle_appearance(p1[1],p1[2], p2[1],p2[2], p3[1],p3[2], icon_size, icon, icon_state)


/// Returns a mutable appearance of a triangle of the given points, and caches it for later use
/proc/get_triangle_appearance(x1,y1, x2,y2, x3,y3, icon_size = TRIANGLE_ICON_SIZE, icon = TRIANGLE_ICON, icon_state = "triangle")
	var/key = "[x1]_[y2]_[x2]_[y2]_[x3]_[y3]_[icon_size]_[icon]_[icon_state]"
	if(GLOB.triangle_appearances[key])
		return GLOB.triangle_appearances[key]
	var/mutable_appearance/triangle_appearance = new()
	triangle_appearance.icon = icon
	triangle_appearance.icon_state = icon_state
	triangle_appearance.transform = transform_triangle(x1,y1, x2,y2, x3,y3, icon_size)
	GLOB.triangle_appearances[key] = triangle_appearance
	return triangle_appearance

/// Returns a matrix which when applied to a proper triangle image, creates an arbitrary triangle
/proc/transform_triangle(x1, y1, x2, y2, x3, y3, icon_size = TRIANGLE_ICON_SIZE)
	var/i = 1/icon_size
	var/a = (x3*i)-(x2*i)
	var/b = -(x2*i)+(x1*i)
	var/c = (x3*0.5)+(x1*0.5)
	var/d = (y1*i)-(y2*i)
	var/e = -(y2*i)+(y3*i)
	var/f = (y1*0.5)+(y3*0.5)
	return matrix(a,b,c,e,d,f)

/**
 * Initially, these were used to make complex broken glass effects.
 * That was a gigantic flop. So this is now unused.
 */
/atom/movable/triangle
	name = "triangle"
	appearance_flags = KEEP_APART | RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM
	icon = TRIANGLE_ICON
	icon_state = "triangle"
	color = COLOR_BLACK
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/x1 = 0
	var/y1 = TRIANGLE_ICON_SIZE
	var/x2 = 0
	var/y2 = 0
	var/x3 = TRIANGLE_ICON_SIZE
	var/y3 = 0

/atom/movable/triangle/Initialize(mapload, x1, y1, x2, y2, x3, y3)
	. = ..()
	//literally pointless
	if(!x1 && !y1 && !x2 && !y2 && !x3 && !x3)
		return
	src.x1 = x1
	src.y1 = y1
	src.x2 = x2
	src.y2 = y2
	src.x3 = x3
	src.y3 = y3
	transform = transform_triangle(src.x1,src.y1, src.x2,src.y2, src.x3,src.y3, TRIANGLE_ICON_SIZE)

/atom/movable/triangle/proc/update_transform()
	transform = transform_triangle(src.x1,src.y1, src.x2,src.y2, src.x3,src.y3, TRIANGLE_ICON_SIZE)

/atom/movable/triangle/square
	name = "square"
	icon_state = "square"
