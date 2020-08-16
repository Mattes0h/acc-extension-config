	local function __ac_primitive_vec2()
	return {
		__call = function(_, x, y)
			return setmetatable({
				x = x or 0,
				y = y or 0
			}, vec2)
		end,
		__tostring = function(v)
			return string.format('(%f, %f)', v.x, v.y)
		end,
		__add = function(v, u)
			if type(v) == 'number' then
				return vec2(v, v):add(u, vec2())
			end
			return v:add(u, vec2())
		end,
		__sub = function(v, u)
			if type(v) == 'number' then
				return vec2(v, v):sub(u, vec2())
			end
			return v:sub(u, vec2())
		end,
		__mul = function(v, u)
			if type(v) == 'number' then
				return vec2(v, v) * u
			end
			if vec2.isvec2(u) then
				return v:mul(u, vec2())
			elseif type(u) == 'number' then
				return v:scale(u, vec2())
			else
				error('vec2s can only be multiplied by vec2s and numbers')
			end
		end,
		__div = function(v, u)
			if type(v) == 'number' then
				return vec2(v, v) / u
			end
			if vec2.isvec2(u) then
				return v:div(u, vec2())
			elseif type(u) == 'number' then
				return v:scale(1 / u, vec2())
			else
				error('vec2s can only be divided by vec2s and numbers')
			end
		end,
		__pow = function(v, u)
			if type(v) == 'number' then
				return vec2(v, v) ^ u
			end
			if vec2.isvec2(u) then
				return v:pow(u, vec2())
			elseif type(u) == 'number' then
				return vec2(v.x ^ u, v.y ^ u)
			else
				error('vec2s can only be raised to power of vec2s and numbers')
			end
		end,
		__unm = function(v)
			return vec2(-v.x, -v.y)
		end,
		__len = function(v)
			return v:length()
		end,
		__eq = function(v, o)
			return o ~= nil and v.x == o.x and v.y == o.y
		end,
		__index = {
			new = function(x, y)
				if type(x) ~= 'number' then
					x = 0
				end
				if type(y) ~= 'number' then
					y = x
				end
				return vec2(x, y)
			end,
			isvec2 = function(x)
				return ffi.istype('vec2', x)
			end,
			type = function(x)
				return vec2
			end,
			clone = function(v)
				return vec2(v.x, v.y)
			end,
			unpack = function(v)
				return v.x,  v.y
			end,
			set = function(v, x, y)
				if vec2.isvec2(x) then
					x, y = x.x, x.y
				end
				v.x = x
				v.y = y
				return v
			end,
			setLerp = function(v, a, b, k)
				v.x = math.lerp(a.x, b.x, k)
				v.y = math.lerp(a.y, b.y, k)
				return v
			end,
			add = function(v, u, out)
				out = out or v
				if vec2.isvec2(u) then
					out.x = v.x + u.x
					out.y = v.y + u.y
				else
					out.x = v.x + u
					out.y = v.y + u
				end
				return out
			end,
			sub = function(v, u, out)
				out = out or v
				if vec2.isvec2(u) then
					out.x = v.x - u.x
					out.y = v.y - u.y
				else
					out.x = v.x - u
					out.y = v.y - u
				end
				return out
			end,
			mul = function(v, u, out)
				out = out or v
				out.x = v.x * u.x
				out.y = v.y * u.y
				return out
			end,
			div = function(v, u, out)
				out = out or v
				out.x = v.x / u.x
				out.y = v.y / u.y
				return out
			end,
			pow = function(v, u, out)
				out = out or v
				if type(u) == 'number' then
					out.x = v.x ^ u
					out.y = v.y ^ u
				else
					out.x = v.x ^ u.x
					out.y = v.y ^ u.y
				end
				return out
			end,
			scale = function(v, s, out)
				out = out or v
				out.x = v.x * s
				out.y = v.y * s
				return out
			end,
			saturate = function(v, out)
				out = out or v
				out.x = math.saturateN(v.x)
				out.y = math.saturateN(v.y)
				return out
			end,
			clamp = function(v, min, max, out)
				out = out or v
				out.x = math.clampN(v.x, min.x, max.x)
				out.y = math.clampN(v.y, min.y, max.y)
				return out
			end,
			length = function(v)
				return math.sqrt(v.x * v.x + v.y * v.y)
			end,
			distance = function(v, u)
				return vec2.sub(v, u, vtmp1):length()
			end,
			angle = function(v, u)
				return math.acos(v:dot(u) / (v:length() + u:length()))
			end,
			dot = function(v, u)
				return v.x * u.x + v.y * u.y
			end,
			normalize = function(v, out)
				out = out or v
				local len = v:length()
				return len == 0 and v or v:scale(1 / len, out)
			end,
			lerp = function(v, u, t, out)
				out = out or v
				out.x = v.x + (u.x - v.x) * t
				out.y = v.y + (u.y - v.y) * t
				return out
			end,
			project = function(v, u, out)
				out = out or v
				local unorm = vtmp1
				u:normalize(unorm)
				local dot = v:dot(unorm)
				out.x = unorm.x * dot
				out.y = unorm.y * dot
				return out
			end
		}
	}
end
local function __ac_primitive_vec3()
	return {
		__call = function(_, x, y, z)
			return setmetatable({
				x = x or 0,
				y = y or 0,
				z = z or 0
			}, vec3)
		end,
		__tostring = function(v)
			return string.format('(%f, %f, %f)', v.x, v.y, v.z)
		end,
		__add = function(v, u)
			if type(v) == 'number' then
				return vec3(v, v, v):add(u, vec3())
			end
			if v == nil then
				return u
			end
			return v:add(u, vec3())
		end,
		__sub = function(v, u)
			if type(v) == 'number' then
				return vec3(v, v, v):sub(u, vec3())
			end
			if v == nil then
				return u
			end
			return v:sub(u, vec3())
		end,
		__mul = function(v, u)
			if type(v) == 'number' then
				return vec3(v, v, v) * u
			end
			if v == nil or u == nil then
				return vec3()
			end
			if vec3.isvec3(u) then
				return v:mul(u, vec3())
			elseif type(u) == 'number' then
				return v:scale(u, vec3())
			else
				error('vec3s can only be multiplied by vec3s and numbers')
			end
		end,
		__div = function(v, u)
			if type(v) == 'number' then
				return vec3(v, v, v) / u
			end
			if v == nil or u == nil then
				return vec3()
			end
			if vec3.isvec3(u) then
				return v:div(u, vec3())
			elseif type(u) == 'number' then
				return v:scale(1 / u, vec3())
			else
				error('vec3s can only be divided by vec3s and numbers')
			end
		end,
		__pow = function(v, u)
			if type(v) == 'number' then
				return vec3(v, v, v) ^ u
			end
			if vec3.isvec3(u) then
				return v:pow(u, vec3())
			elseif type(u) == 'number' then
				return vec3(v.x ^ u, v.y ^ u, v.z ^ u)
			else
				error('vec3s can only be raised to power of vec3s and numbers')
			end
		end,
		__unm = function(v)
			return vec3(-v.x, -v.y, -v.z)
		end,
		__len = function(v)
			return v:length()
		end,
		__eq = function(v, o)
			return o ~= nil and v.x == o.x and v.y == o.y and v.z == o.z
		end,
		__index = {
			new = function(x, y, z)
				if type(x) ~= 'number' then
					x = 0
				end
				if type(y) ~= 'number' then
					y = x
				end
				if type(z) ~= 'number' then
					z = y
				end
				return vec3(x, y, z)
			end,
			isvec3 = function(x)
				return ffi.istype('vec3', x)
			end,
			type = function(x)
				return vec3
			end,
			clone = function(v)
				return vec3(v.x, v.y, v.z)
			end,
			unpack = function(v)
				return v.x,  v.y,  v.z
			end,
			set = function(v, x, y, z)
				if vec3.isvec3(x) then
					x, y, z = x.x, x.y, x.z
				end
				v.x = x
				v.y = y
				v.z = z
				return v
			end,
			setLerp = function(v, a, b, k)
				v.x = math.lerp(a.x, b.x, k)
				v.y = math.lerp(a.y, b.y, k)
				v.z = math.lerp(a.z, b.z, k)
				return v
			end,
			add = function(v, u, out)
				out = out or v
				if vec3.isvec3(u) then
					out.x = v.x + u.x
					out.y = v.y + u.y
					out.z = v.z + u.z
				elseif u ~= nil then
					out.x = v.x + u
					out.y = v.y + u
					out.z = v.z + u
				end
				return out
			end,
			sub = function(v, u, out)
				out = out or v
				if vec3.isvec3(u) then
					out.x = v.x - u.x
					out.y = v.y - u.y
					out.z = v.z - u.z
				elseif u ~= nil then
					out.x = v.x - u
					out.y = v.y - u
					out.z = v.z - u
				end
				return out
			end,
			mul = function(v, u, out)
				out = out or v
				out.x = v.x * u.x
				out.y = v.y * u.y
				out.z = v.z * u.z
				return out
			end,
			div = function(v, u, out)
				out = out or v
				out.x = v.x / u.x
				out.y = v.y / u.y
				out.z = v.z / u.z
				return out
			end,
			pow = function(v, u, out)
				out = out or v
				if type(u) == 'number' then
					out.x = v.x ^ u
					out.y = v.y ^ u
					out.z = v.z ^ u
				else
					out.x = v.x ^ u.x
					out.y = v.y ^ u.y
					out.z = v.z ^ u.z
				end
				return out
			end,
			scale = function(v, s, out)
				out = out or v
				out.x = v.x * s
				out.y = v.y * s
				out.z = v.z * s
				return out
			end,
			saturate = function(v, out)
				out = out or v
				out.x = math.saturateN(v.x)
				out.y = math.saturateN(v.y)
				out.z = math.saturateN(v.z)
				return out
			end,
			clamp = function(v, min, max, out)
				out = out or v
				out.x = math.clampN(v.x, min.x, max.x)
				out.y = math.clampN(v.y, min.y, max.y)
				out.z = math.clampN(v.z, min.z, max.z)
				return out
			end,
			length = function(v)
				return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
			end,
			distance = function(v, u)
				return vec3.sub(v, u, vtmp1):length()
			end,
			angle = function(v, u)
				return math.acos(v:dot(u) / (v:length() + u:length()))
			end,
			dot = function(v, u)
				return v.x * u.x + v.y * u.y + v.z * u.z
			end,
			normalize = function(v, out)
				out = out or v
				local len = v:length()
				return len == 0 and v or v:scale(1 / len, out)
			end,
			cross = function(v, u, out)
				out = out or v
				local a, b, c = v.x, v.y, v.z
				out.x = b * u.z - c * u.y
				out.y = c * u.x - a * u.z
				out.z = a * u.y - b * u.x
				return out
			end,
			lerp = function(v, u, t, out)
				out = out or v
				out.x = v.x + (u.x - v.x) * t
				out.y = v.y + (u.y - v.y) * t
				out.z = v.z + (u.z - v.z) * t
				return out
			end,
			project = function(v, u, out)
				out = out or v
				local unorm = vtmp1
				u:normalize(unorm)
				local dot = v:dot(unorm)
				out.x = unorm.x * dot
				out.y = unorm.y * dot
				out.z = unorm.z * dot
				return out
			end,
			rotate = function(v, q, out)
				out = out or v
				local u, c, o = vec3(), vec3(), out
				u.x, u.y, u.z = q.x, q.y, q.z
				o.x, o.y, o.z = v.x, v.y, v.z
				u:cross(v, c)
				local uu = u:dot(u)
				local uv = u:dot(v)
				o:scale(q.w * q.w - uu)
				u:scale(2 * uv)
				c:scale(2 * q.w)
				return o:add(u:add(c))
			end
		}
	}
end
local function __ac_primitive_vec4()
	return {
		__call = function(_, x, y, z, w)
			return setmetatable({
				x = x or 0,
				y = y or 0,
				z = z or 0,
				w = w or 0
			}, vec4)
		end,
		__tostring = function(v)
			return string.format('(%f, %f, %f, %f)', v.x, v.y, v.z, v.w)
		end,
		__add = function(v, u)
			if type(v) == 'number' then
				return vec4(v, v, v, v):add(u, vec4())
			end
			return v:add(u, vec4())
		end,
		__sub = function(v, u)
			if type(v) == 'number' then
				return vec4(v, v, v, v):sub(u, vec4())
			end
			return v:sub(u, vec4())
		end,
		__mul = function(v, u)
			if type(v) == 'number' then
				return vec4(v, v, v, v) * u
			end
			if vec4.isvec4(u) then
				return v:mul(u, vec4())
			elseif type(u) == 'number' then
				return v:scale(u, vec4())
			else
				error('vec4s can only be multiplied by vec4s and numbers')
			end
		end,
		__div = function(v, u)
			if type(v) == 'number' then
				return vec4(v, v, v, v) / u
			end
			if vec4.isvec4(u) then
				return v:div(u, vec4())
			elseif type(u) == 'number' then
				return v:scale(1 / u, vec4())
			else
				error('vec4s can only be divided by vec4s and numbers')
			end
		end,
		__pow = function(v, u)
			if type(v) == 'number' then
				return vec4(v, v, v, v) ^ u
			end
			if vec4.isvec4(u) then
				return v:pow(u, vec4())
			elseif type(u) == 'number' then
				return vec4(v.x ^ u, v.y ^ u, v.z ^ u, v.w ^ u)
			else
				error('vec4s can only be raised to power of vec4s and numbers')
			end
		end,
		__unm = function(v)
			return vec4(-v.x, -v.y, -v.z, -v.w)
		end,
		__len = function(v)
			return v:length()
		end,
		__eq = function(v, o)
			return o ~= nil and v.x == o.x and v.y == o.y and v.z == o.z and v.w == o.w
		end,
		__index = {
			new = function(x, y, z, w)
				if vec3.isvec3(x) then
					return vec4(x.x, x.y, x.z, w or 0)
				end
				if vec3.isvec3(y) then
					return vec4(x or 0, y.x, y.y, y.z)
				end
				if type(x) ~= 'number' then
					x = 0
				end
				if type(y) ~= 'number' then
					y = x
				end
				if type(z) ~= 'number' then
					z = y
				end
				if type(w) ~= 'number' then
					w = z
				end
				return vec4(x, y, z, w)
			end,
			isvec4 = function(x)
				return ffi.istype('vec4', x)
			end,
			type = function(x)
				return vec4
			end,
			clone = function(v)
				return vec4(v.x, v.y, v.z, v.w)
			end,
			unpack = function(v)
				return v.x,  v.y,  v.z,  v.w
			end,
			set = function(v, x, y, z, w)
				if vec4.isvec4(x) then
					x, y, z, w = x.x, x.y, x.z, x.w
				end
				v.x = x
				v.y = y
				v.z = z
				v.w = w
				return v
			end,
			setLerp = function(v, a, b, k)
				v.x = math.lerp(a.x, b.x, k)
				v.y = math.lerp(a.y, b.y, k)
				v.z = math.lerp(a.z, b.z, k)
				v.w = math.lerp(a.w, b.w, k)
				return v
			end,
			add = function(v, u, out)
				out = out or v
				if vec4.isvec4(u) then
					out.x = v.x + u.x
					out.y = v.y + u.y
					out.z = v.z + u.z
					out.w = v.w + u.w
				else
					out.x = v.x + u
					out.y = v.y + u
					out.z = v.z + u
					out.w = v.w + u
				end
				return out
			end,
			sub = function(v, u, out)
				out = out or v
				if vec4.isvec4(u) then
					out.x = v.x - u.x
					out.y = v.y - u.y
					out.z = v.z - u.z
					out.w = v.w - u.w
				else
					out.x = v.x - u
					out.y = v.y - u
					out.z = v.z - u
					out.w = v.w - u
				end
				return out
			end,
			mul = function(v, u, out)
				out = out or v
				out.x = v.x * u.x
				out.y = v.y * u.y
				out.z = v.z * u.z
				out.w = v.w * u.w
				return out
			end,
			div = function(v, u, out)
				out = out or v
				out.x = v.x / u.x
				out.y = v.y / u.y
				out.z = v.z / u.z
				out.w = v.w / u.w
				return out
			end,
			pow = function(v, u, out)
				out = out or v
				if type(u) == 'number' then
					out.x = v.x ^ u
					out.y = v.y ^ u
					out.z = v.z ^ u
					out.w = v.w ^ u
				else
					out.x = v.x ^ u.x
					out.y = v.y ^ u.y
					out.z = v.z ^ u.z
					out.w = v.w ^ u.w
				end
				return out
			end,
			scale = function(v, s, out)
				out = out or v
				out.x = v.x * s
				out.y = v.y * s
				out.z = v.z * s
				out.w = v.w * s
				return out
			end,
			saturate = function(v, out)
				out = out or v
				out.x = math.saturateN(v.x)
				out.y = math.saturateN(v.y)
				out.z = math.saturateN(v.z)
				out.w = math.saturateN(v.w)
				return out
			end,
			clamp = function(v, min, max, out)
				out = out or v
				out.x = math.clampN(v.x, min.x, max.x)
				out.y = math.clampN(v.y, min.y, max.y)
				out.z = math.clampN(v.z, min.z, max.z)
				out.w = math.clampN(v.w, min.w, max.w)
				return out
			end,
			length = function(v)
				return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z + v.w * v.w)
			end,
			distance = function(v, u)
				return vec4.sub(v, u, vtmp1):length()
			end,
			angle = function(v, u)
				return math.acos(v:dot(u) / (v:length() + u:length()))
			end,
			dot = function(v, u)
				return v.x * u.x + v.y * u.y + v.z * u.z + v.w * u.w
			end,
			normalize = function(v, out)
				out = out or v
				local len = v:length()
				return len == 0 and v or v:scale(1 / len, out)
			end,
			lerp = function(v, u, t, out)
				out = out or v
				out.x = v.x + (u.x - v.x) * t
				out.y = v.y + (u.y - v.y) * t
				out.z = v.z + (u.z - v.z) * t
				out.w = v.w + (u.w - v.w) * t
				return out
			end,
			project = function(v, u, out)
				out = out or v
				local unorm = vtmp1
				u:normalize(unorm)
				local dot = v:dot(unorm)
				out.x = unorm.x * dot
				out.y = unorm.y * dot
				out.z = unorm.z * dot
				out.w = unorm.w * dot
				return out
			end
		}
	}
end
local function __ac_primitive_rgb()
	local function rgbValue(v)
		return math.max(v.r, v.g, v.b)
	end
	local function rgbLuminance(v)
		return 0.299 * v.r + 0.587 * v.g + 0.114 * v.b
	end
	local function rgbHue(v)
		if v.r == v.g and v.g == v.b then
			return 0
		end
		local max = v.r
		local min = v.r
		if v.g > max then
			max = v.g
		end
		if v.b > max then
			max = v.b
		end
		if v.g < min then
			min = v.g
		end
		if v.b < min then
			min = v.b
		end
		local result = 0
		if v.r == max then
			result = (v.g - v.b) / (max - min)
		elseif v.g == max then
			result = 2 + (v.b - v.r) / (max - min)
		elseif v.b == max then
			result = 4 + (v.r - v.g) / (max - min)
		end
		if result < 0 then
			result = result + 6
		end
		return result * 60
	end
	local function rgbSaturation(v)
		local a = math.max(v.r, v.g, v.b)
		if a <= 0 then
			return 0
		end
		local i = math.min(v.r, v.g, v.b)
		return (a - i) / a
	end
	return {
		__call = function(_, r, g, b)
			return setmetatable({
				r = r or 0,
				g = g or 0,
				b = b or 0
			}, rgb)
		end,
		__tostring = function(v)
			return string.format('(%f, %f, %f)', v.r, v.g, v.b)
		end,
		__add = function(v, u)
			if type(v) == 'number' then
				return rgb(v, v, v):add(u, rgb())
			end
			return v:add(u, rgb())
		end,
		__sub = function(v, u)
			if type(v) == 'number' then
				return rgb(v, v, v):sub(u, rgb())
			end
			return v:sub(u, rgb())
		end,
		__mul = function(v, u)
			if type(v) == 'number' then
				return rgb(v, v, v) * u
			end
			if rgb.isrgb(u) then
				return v:mul(u, rgb())
			elseif type(u) == 'number' then
				return v:scale(u, rgb())
			else
				error('rgbs can only be multiplied by rgbs and numbers')
			end
		end,
		__div = function(v, u)
			if type(v) == 'number' then
				return rgb(v, v, v) / u
			end
			if rgb.isrgb(u) then
				return v:div(u, rgb())
			elseif type(u) == 'number' then
				return v:scale(1 / u, rgb())
			else
				error('rgbs can only be divided by rgbs and numbers')
			end
		end,
		__pow = function(v, u)
			if type(v) == 'number' then
				return rgb(v, v, v) ^ u
			end
			if rgb.isrgb(u) then
				return v:pow(u, rgb())
			elseif type(u) == 'number' then
				return rgb(v.r ^ u, v.g ^ u, v.b ^ u)
			else
				error('rgbs can only be raised to power of rgbs and numbers')
			end
		end,
		__unm = function(v)
			return rgb(-v.r, -v.g, -v.b)
		end,
		__len = function(v)
			return v:value()
		end,
		__eq = function(v, o)
			return o ~= nil and v.r == o.r and v.g == o.g and v.b == o.b
		end,
		__lt = function(v, o)
			return v:value() < o:value()
		end,
		__le = function(v, o)
			return v:value() <= o:value()
		end,
		__index = {
			new = function(r, g, b)
				if rgb.isrgb(r) then
					return r
				end
				if rgbm.isrgbm(r) then
					return r:color()
				end
				if hsv.ishsv(r) then
					return r:rgb()
				end
				if vec3.isvec3(r) then
					return rgb(r.x, r.y, r.z)
				end
				if vec4.isvec4(r) then
					return rgb(r.x * r.w, r.y * r.w, r.z * r.w)
				end
				if type(r) ~= 'number' then
					r = 0
				end
				if type(g) ~= 'number' then
					g = r
				end
				if type(b) ~= 'number' then
					b = g
				end
				return rgb(r, g, b)
			end,
			from0255 = function(r, g, b)
				if type(r) ~= 'number' then
					r = 0
				end
				if type(g) ~= 'number' then
					g = r
				end
				if type(b) ~= 'number' then
					b = g
				end
				return rgb(r / 255, g / 255, b / 255)
			end,
			isrgb = function(r)
				return ffi.istype('rgb', r)
			end,
			type = function(x)
				return rgb
			end,
			clone = function(v)
				return rgb(v.r, v.g, v.b)
			end,
			unpack = function(v)
				return v.r,  v.g,  v.b
			end,
			set = function(v, r, g, b)
				if rgb.isrgb(r) then
					r, g, b = r.r, r.g, r.b
				else
					if g == nil then
						g = r
					end
					if b == nil then
						b = g
					end
				end
				v.r = r
				v.g = g
				v.b = b
				return v
			end,
			setLerp = function(v, a, b, k)
				v.r = math.lerp(a.r, b.r, k)
				v.g = math.lerp(a.g, b.g, k)
				v.b = math.lerp(a.b, b.b, k)
				return v
			end,
			add = function(v, u, out)
				out = out or v
				if rgb.isrgb(u) then
					out.r = v.r + u.r
					out.g = v.g + u.g
					out.b = v.b + u.b
				else
					out.r = v.r + u
					out.g = v.g + u
					out.b = v.b + u
				end
				return out
			end,
			sub = function(v, u, out)
				out = out or v
				if rgb.isrgb(u) then
					out.r = v.r - u.r
					out.g = v.g - u.g
					out.b = v.b - u.b
				else
					out.r = v.r - u
					out.g = v.g - u
					out.b = v.b - u
				end
				return out
			end,
			mul = function(v, u, out)
				out = out or v
				out.r = v.r * u.r
				out.g = v.g * u.g
				out.b = v.b * u.b
				return out
			end,
			div = function(v, u, out)
				out = out or v
				out.r = v.r / u.r
				out.g = v.g / u.g
				out.b = v.b / u.b
				return out
			end,
			pow = function(v, u, out)
				out = out or v
				if type(u) == 'number' then
					out.r = v.r ^ u
					out.g = v.g ^ u
					out.b = v.b ^ u
				else
					out.r = v.r ^ u.r
					out.g = v.g ^ u.g
					out.b = v.b ^ u.b
				end
				return out
			end,
			scale = function(v, s, out)
				out = out or v
				out.r = v.r * s
				out.g = v.g * s
				out.b = v.b * s
				return out
			end,
			saturate = function(v, out)
				out = out or v
				out.r = math.saturateN(v.r)
				out.g = math.saturateN(v.g)
				out.b = math.saturateN(v.b)
				return out
			end,
			clamp = function(v, min, max, out)
				out = out or v
				out.r = math.clampN(v.r, min.r, max.r)
				out.g = math.clampN(v.g, min.g, max.g)
				out.b = math.clampN(v.b, min.b, max.b)
				return out
			end,
			normalize = function(v)
				local m = v:value()
				if m > 1 then
					return v / m
				end
				return v
			end,
			adjustSaturation = function(v, sat, out)
				out = out or v
				local avg = (v.r + v.g + v.b) / 3
				out.r = math.max(math.lerp(avg, out.r, sat), 0)
				out.g = math.max(math.lerp(avg, out.g, sat), 0)
				out.b = math.max(math.lerp(avg, out.b, sat), 0)
				return out
			end,
			value = rgbValue,
			getValue = rgbValue,
			hue = rgbHue,
			getHue = rgbHue,
			hue = rgbHue,
			getSaturation = rgbSaturation,
			saturation = rgbSaturation,
			luminance = rgbLuminance,
			getLuminance = rgbLuminance,
			hsv = function(v)
				return hsv(v:hue(), v:saturation(), v:value())
			end,
			toHsv = function(v)
				return hsv(v:hue(), v:saturation(), v:value())
			end,
			rgbm = function(v, m)
				return rgbm(v.r, v.g, v.b, __num_fallback(m, 1))
			end,
			toRgbm = function(v, m)
				return rgbm(v.r, v.g, v.b, __num_fallback(m, 1))
			end,
			vec3 = function(v)
				return vec3(v.r, v.g, v.b)
			end,
			toVec3 = function(v)
				return vec3(v.r, v.g, v.b)
			end
		}
	}
end
local function __ac_primitive_hsv()
	local function hsvToRgb(t)
		local v = t.v
		if t.s <= 0 then
			return rgb(v, v, v)
		end
		local e = t.h
		if e >= 360 then
			e = 0
		end
		e = e / 60
		local i = math.floor(e)
		local u = e - i
		local p = v * (1 - t.s)
		local q = v * (1 - t.s * u)
		local t = v * (1 - t.s * (1 - u))
		if i == 0 then
			return rgb(v, t, p)
		end
		if i == 1 then
			return rgb(q, v, p)
		end
		if i == 2 then
			return rgb(p, v, t)
		end
		if i == 3 then
			return rgb(p, q, v)
		end
		if i == 4 then
			return rgb(t, p, v)
		end
		return rgb(v, p, q)
	end
	return {
		__call = function(_, h, s, v)
			return setmetatable({
				h = h or 0,
				s = s or 0,
				v = v or 0
			}, hsv)
		end,
		__tostring = function(v)
			return string.format('(H=%f, S=%f, V=%f)', v.h, v.s, v.v)
		end,
		__eq = function(v, o)
			return o ~= nil and v.h == o.h and v.s == o.s and v.v == o.v
		end,
		__index = {
			new = function(h, s, v)
				if type(h) ~= 'number' then
					h = 0
				end
				if type(s) ~= 'number' then
					s = h
				end
				if type(v) ~= 'number' then
					v = s
				end
				return hsv(h, s, v)
			end,
			ishsv = function(h)
				return ffi.istype('hsv', h)
			end,
			type = function(x)
				return hsv
			end,
			clone = function(v)
				return hsv(v.h, v.s, v.v)
			end,
			unpack = function(v)
				return v.h,  v.s,  v.v
			end,
			set = function(v, h, s, v)
				if hsv.ishsv(h) then
					h, s, v = h.h, h.s, h.v
				end
				v.h = h
				v.s = s
				v.v = v
				return v
			end,
			rgb = hsvToRgb,
			toRgb = hsvToRgb
		}
	}
end
local function __ac_primitive_rgbm()
	return {
		__call = function(_, r, g, b, mult)
			return setmetatable({
				r = r or 0,
				g = g or 0,
				b = b or 0,
				mult = mult or 0
			}, rgbm)
		end,
		__tostring = function(v)
			return string.format('(rgb=(%f, %f, %f), mult=%f)', v.rgb.r, v.rgb.g, v.rgb.b, v.mult)
		end,
		__add = function(v, u)
			if type(v) == 'number' then
				return rgbm(v, v, v, v):add(u, rgbm())
			end
			return v:add(u, rgbm())
		end,
		__sub = function(v, u)
			if type(v) == 'number' then
				return rgbm(v, v, v, v):sub(u, rgbm())
			end
			return v:sub(u, rgbm())
		end,
		__mul = function(v, u)
			if type(v) == 'number' then
				return rgbm(v, v, v, v) * u
			end
			if rgbm.isrgbm(u) then
				return v:mul(u, rgbm())
			elseif type(u) == 'number' then
				return v:scale(u, rgbm())
			else
				error('rgbms can only be multiplied by rgbms and numbers')
			end
		end,
		__div = function(v, u)
			if type(v) == 'number' then
				return rgbm(v, v, v, v) / u
			end
			if rgbm.isrgbm(u) then
				return v:div(u, rgbm())
			elseif type(u) == 'number' then
				return v:scale(1 / u, rgbm())
			else
				error('rgbms can only be divided by rgbms and numbers')
			end
		end,
		__pow = function(v, u)
			if type(v) == 'number' then
				return rgbm(v, v, v) ^ u
			end
			if rgbm.isrgbm(u) then
				return v:pow(u, rgbm())
			elseif type(u) == 'number' then
				return rgbm(v.r ^ u, v.g ^ u, v.b ^ u, v.mult ^ u)
			else
				error('rgbms can only be raised to power of rgbms and numbers')
			end
		end,
		__unm = function(v)
			return v * -1
		end,
		__len = function(v)
			return v:value()
		end,
		__eq = function(v, o)
			return o ~= nil and v.rgb == o.rgb and v.mult == o.mult
		end,
		__lt = function(v, o)
			return v:value() < o:value()
		end,
		__le = function(v, o)
			return v:value() <= o:value()
		end,
		__index = {
			new = function(r, g, b, m)
				if rgbm.isrgbm(r) then
					return r
				end
				if rgb.isrgb(r) then
					return rgbm(r.r, r.g, r.b, g or 1)
				end
				if vec4.isvec4(r) then
					return rgbm(r.x, r.y, r.z, r.w)
				end
				if vec3.isvec3(r) then
					return rgbm(r.x, r.y, r.z, 1)
				end
				if type(r) ~= 'number' then
					return rgbm(0, 0, 0, 1)
				end
				if type(g) ~= 'number' then
					return rgbm(r, r, r, 1)
				end
				if type(b) ~= 'number' then
					return rgbm(r, r, r, g)
				end
				return rgbm(r, g, b, __num_fallback(m, 1))
			end,
			from0255 = function(r, g, b, a)
				if type(r) ~= 'number' then
					r = 0
				end
				if type(g) ~= 'number' then
					g = r
				end
				if type(b) ~= 'number' then
					b = g
				end
				return rgbm(r / 255, g / 255, b / 255, __num_fallback(a, 1))
			end,
			isrgbm = function(r)
				return ffi.istype('rgbm', r)
			end,
			type = function(x)
				return rgbm
			end,
			clone = function(v)
				return rgbm(v.r, v.g, v.b, v.mult)
			end,
			unpack = function(v)
				return v.rgb,  v.mult
			end,
			set = function(v, rgb, mult)
				if rgbm.isrgbm(r) then
					rgb, mult = r.rgb, r.mult
				end
				v.rgb = rgb
				v.mult = mult
				return v
			end,
			setLerp = function(v, a, b, k)
				v.r = math.lerp(a.r, b.r, k)
				v.g = math.lerp(a.g, b.g, k)
				v.b = math.lerp(a.b, b.b, k)
				v.mult = math.lerp(a.mult, b.mult, k)
				return v
			end,
			add = function(v, u, out)
				out = out or v
				if rgbm.isrgbm(u) then
					out.rgb = v.rgb + u.rgb
					out.mult = v.mult + u.mult
				else
					out.rgb = v.rgb + u
					out.mult = v.mult + u
				end
				return out
			end,
			sub = function(v, u, out)
				out = out or v
				if rgbm.isrgbm(u) then
					out.rgb = v.rgb - u.rgb
					out.mult = v.mult - u.mult
				else
					out.rgb = v.rgb - u
					out.mult = v.mult - u
				end
				return out
			end,
			mul = function(v, u, out)
				out = out or v
				out.rgb = v.rgb * u.rgb
				out.mult = v.mult * u.mult
				return out
			end,
			div = function(v, u, out)
				out = out or v
				out.rgb = v.rgb / u.rgb
				out.mult = v.mult / u.mult
				return out
			end,
			pow = function(v, u, out)
				out = out or v
				if type(u) == 'number' then
					out.r = v.r ^ u
					out.g = v.g ^ u
					out.b = v.b ^ u
					out.mult = v.mult ^ u
				else
					out.r = v.r ^ u.r
					out.g = v.g ^ u.g
					out.b = v.b ^ u.b
					out.mult = v.mult ^ u.mult
				end
				return out
			end,
			scale = function(v, s, out)
				out = out or v
				out.rgb = v.rgb * s
				out.mult = v.mult * s
				return out
			end,
			saturate = function(v, out)
				out = out or v
				out.r = math.saturateN(v.r)
				out.g = math.saturateN(v.g)
				out.b = math.saturateN(v.b)
				out.mult = math.saturateN(v.mult)
				return out
			end,
			clamp = function(v, min, max, out)
				out = out or v
				out.r = math.clampN(v.r, min.r, max.r)
				out.g = math.clampN(v.g, min.g, max.g)
				out.b = math.clampN(v.b, min.b, max.b)
				out.mult = math.clampN(v.mult, min.mult, max.mult)
				return out
			end,
			normalize = function(v)
				local m = v:value()
				if m > 1 then
					return v / m
				end
				return v
			end,
			value = function(v)
				return v.rgb:value() * v.mult
			end,
			getValue = function(v)
				return v.rgb:value() * v.mult
			end,
			luminance = function(v)
				return v.rgb:luminance() * v.mult
			end,
			getLuminance = function(v)
				return v.rgb:luminance() * v.mult
			end,
			color = function(v)
				return v.rgb * v.mult
			end,
			toRgb = function(v)
				return v.rgb * v.mult
			end,
			hsv = function(v)
				return v:color():hsv()
			end,
			toHsv = function(v)
				return v:color():hsv()
			end,
			vec3 = function(v)
				return v:color():vec()
			end,
			toVec3 = function(v)
				return v:color():vec()
			end,
			vec4 = function(v)
				return vec4(v.rgb.r, v.rgb.g, v.rgb.b, v.mult)
			end,
			toVec4 = function(v)
				return vec4(v.rgb.r, v.rgb.g, v.rgb.b, v.mult)
			end
		}
	}
end
local function __ac_primitive_quat()
	return {
		__call = function(_, x, y, z, w)
			return setmetatable({
				x = x,
				y = y,
				z = z,
				w = w
			}, quat)
		end,
		__tostring = function(q)
			return string.format('(%f, %f, %f, %f)', q.x, q.y, q.z, q.w)
		end,
		__add = function(q, r)
			return q:add(r, quat())
		end,
		__sub = function(q, r)
			return q:sub(r, quat())
		end,
		__mul = function(q, r)
			if quat.isquat(r) then
				return q:mul(r, quat())
			elseif vec3.isvec3(r) then
				return r:rotate(q, vec3())
			else
				error('quats can only be multiplied by quats and vec3s')
			end
		end,
		__unm = function(q)
			return q:scale(-1)
		end,
		__len = function(q)
			return q:length()
		end,
		__index = {
			type = function(x)
				return quat
			end,
			isquat = function(x)
				return ffi and ffi.istype('quat', x) or getmetatable(x) == quat
			end,
			clone = function(q)
				return quat(q.x, q.y, q.z, q.w)
			end,
			unpack = function(q)
				return q.x,  q.y,  q.z,  q.w
			end,
			set = function(q, x, y, z, w)
				if quat.isquat(x) then
					x, y, z, w = x.x, x.y, x.z, x.w
				end
				q.x = x
				q.y = y
				q.z = z
				q.w = w
				return q
			end,
			fromAngleAxis = function(angle, x, y, z)
				return quat():setAngleAxis(angle, x, y, z)
			end,
			setAngleAxis = function(q, angle, x, y, z)
				if vec3.isvec3(x) then
					x, y, z = x.x, x.y, x.z
				end
				local s = math.sin(angle * .5)
				local c = math.cos(angle * .5)
				q.x = x * s
				q.y = y * s
				q.z = z * s
				q.w = c
				return q
			end,
			getAngleAxis = function(q)
				if q.w > 1 or q.w < -1 then
					q:normalize()
				end
				local s = math.sqrt(1 - q.w * q.w)
				s = s < .0001 and 1 or 1 / s
				return 2 * math.acos(q.w),  q.x * s,  q.y * s,  q.z * s
			end,
			between = function(u, v)
				return quat():setBetween(u, v)
			end,
			setBetween = function(q, u, v)
				local dot = u:dot(v)
				if dot > .99999 then
					q.x, q.y, q.z, q.w = 0, 0, 0, 1
					return q
				elseif dot < -.99999 then
					vtmp1.x, vtmp1.y, vtmp1.z = 1, 0, 0
					vtmp1:cross(u)
					if #vtmp1 < .00001 then
						vtmp1.x, vtmp1.y, vtmp1.z = 0, 1, 0
						vtmp1:cross(u)
					end
					vtmp1:normalize()
					return q:setAngleAxis(math.pi, vtmp1)
				end
				q.x, q.y, q.z = u.x, u.y, u.z
				vec3.cross(q, v)
				q.w = 1 + dot
				return q:normalize()
			end,
			fromDirection = function(x, y, z)
				return quat():setDirection(x, y, z)
			end,
			setDirection = function(q, x, y, z)
				if vec3.isvec3(x) then
					x, y, z = x.x, x.y, x.z
				end
				vtmp2.x, vtmp2.y, vtmp2.z = x, y, z
				return q:setBetween(forward, vtmp2)
			end,
			add = function(q, r, out)
				out = out or q
				out.x = q.x + r.x
				out.y = q.y + r.y
				out.z = q.z + r.z
				out.w = q.w + r.w
				return out
			end,
			sub = function(q, r, out)
				out = out or q
				out.x = q.x - r.x
				out.y = q.y - r.y
				out.z = q.z - r.z
				out.w = q.w - r.w
				return out
			end,
			mul = function(q, r, out)
				out = out or q
				local qx, qy, qz, qw = q:unpack()
				local rx, ry, rz, rw = r:unpack()
				out.x = qx * rw + qw * rx + qy * rz - qz * ry
				out.y = qy * rw + qw * ry + qz * rx - qx * rz
				out.z = qz * rw + qw * rz + qx * ry - qy * rx
				out.w = qw * rw - qx * rx - qy * ry - qz * rz
				return out
			end,
			scale = function(q, s, out)
				out = out or q
				out.x = q.x * s
				out.y = q.y * s
				out.z = q.z * s
				out.w = q.w * s
				return out
			end,
			length = function(q)
				return math.sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
			end,
			normalize = function(q, out)
				out = out or q
				local len = q:length()
				return len == 0 and q or q:scale(1 / len, out)
			end,
			lerp = function(q, r, t, out)
				out = out or q
				r:scale(t, qtmp1)
				q:scale(1 - t, out)
				return out:add(qtmp1)
			end,
			slerp = function(q, r, t, out)
				out = out or q
				local dot = q.x * r.x + q.y * r.y + q.z * r.z + q.w * r.w
				if dot < 0 then
					dot = -dot
					r:scale(-1)
				end
				if 1 - dot < .0001 then
					return q:lerp(r, t, out)
				end
				local theta = math.acos(dot)
				q:scale(math.sin((1 - t) * theta), out)
				r:scale(math.sin(t * theta), qtmp1)
				return out:add(qtmp1):scale(1 / math.sin(theta))
			end
		}
	}
end
local function __ac_smoothing()
	local _dt = 0.0167
	return setmetatable({}, {
		__call = function(_, v, s)
			return setmetatable({
				val = v or 0,
				lastValue = v or 0,
				smooth = s or 100
			}, {
				__tostring = function(v)
					return string.format('(%s, s=%f)', v.val, v.smooth)
				end,
				__index = {
					update = function(v, x)
						v.val = math.applyLag(v.val, x, 1 - 1 / v.smooth, _dt)
					end,
					updateIfNew = function(v, x)
						if x ~= v.lastValue then
							v.val = math.applyLag(v.val, x, 1 - 1 / v.smooth, _dt)
							v.lastValue = x
						end
					end
				}
			})
		end,
		__index = {
			setDT = function(dt)
				_dt = math.applyLag(_dt, dt, 0.9, _dt)
			end
		}
	})
end
local function __ac_primitive()
	local forward
	local vtmp1
	local vtmp2
	local qtmp1
	ffi.cdef [[
  typedef struct { float x, y; } vec2;
  typedef struct { float x, y, z; } vec3;
  typedef struct { float x, y, z, w; } vec4;
  typedef struct { float r, g, b; } rgb;
  typedef struct { float h, s, v; } hsv;
  typedef struct { union { struct { float r, g, b; }; struct { rgb rgb; }; }; float mult; } rgbm;
  typedef struct { float x, y, z, w; } quat;
]]
	vec2 = ffi.metatype('vec2', __ac_primitive_vec2())
	vec3 = ffi.metatype('vec3', __ac_primitive_vec3())
	vec4 = ffi.metatype('vec4', __ac_primitive_vec4())
	rgb = ffi.metatype('rgb', __ac_primitive_rgb())
	hsv = ffi.metatype('hsv', __ac_primitive_hsv())
	rgbm = ffi.metatype('rgbm', __ac_primitive_rgbm())
	quat = ffi.metatype('quat', __ac_primitive_quat())
	smoothing = __ac_smoothing()
	local forward = vec3(0, 0, -1)
	local vtmp1 = vec3()
	local vtmp2 = vec3()
	local qtmp1 = quat()
end
local function __vector()
	local ffi = require 'ffi'
	local C = ffi.C
	local size_t = ffi.typeof('size_t')
	local function simple_deep_copy(x)
		if type(x) ~= 'table' then
			return x
		end
		local t = {}
		for k, v in pairs(x) do
			t[k] = simple_deep_copy(v)
		end
		return t
	end
	ffi.cdef [[
void* lj_calloc(size_t count, size_t size);
void* lj_realloc(void *ptr, size_t size);
void* lj_memmove(void *dst, const void *src, size_t len);
void lj_free(void *ptr); 
]]
	local MallocAllocatorT__mt = {
		__index = {
			allocate = function(self, n)
				return C.lj_calloc(n, self._ct_size)
			end,
			deallocate = function(self, p)
				if p ~= 0 then
					C.lj_free(p)
				end
			end,
			reallocate = function(self, p, n)
				return C.lj_realloc(p, n)
			end
		}
	}
	local function MallocAllocatorT(ct, which)
		if type(ct) ~= 'cdata' then
			error('argument 1 is not a valid "cdata"')
		end
		local t_mt = simple_deep_copy(MallocAllocatorT__mt)
		t_mt.__index._ct = ct
		t_mt.__index._ct_size = ffi.sizeof(ct)
		local t_anonymous = ffi.typeof('struct {}')
		return ffi.metatype(t_anonymous, t_mt)
	end
	local function MallocAllocator(ct)
		return MallocAllocatorT(ct)()
	end
	local VectorT__cdef = [[ struct { $ * _data; int _size; int _cap; } ]]
	local function VectorT__resize(v, reserve_n, shrinkToFit)
		local new_cap = math.max(1, reserve_n or 2 * v._cap, shrinkToFit and 1 or 2 * v._cap)
		if v._cap >= new_cap then
			return
		end
		local new_data = v.__alloc:reallocate(v._data, new_cap * v.__ct_size)
		v._data = ffi.cast(v._data, new_data)
		v._cap = new_cap
	end
	local Vector = {}
	function Vector:size()
		return self._size
	end
	function Vector:sizeBytes()
		return self._size * self.__ct_size
	end
	function Vector:isEmpty()
		return self._size == 0
	end
	function Vector:capacity()
		return self._cap
	end
	function Vector:capacityBytes()
		return self._cap * self.__ct_size
	end
	function Vector:reserve(reserve_n)
		VectorT__resize(self, reserve_n)
	end
	function Vector:shrinkToFit()
		VectorT__resize(self, self._size, true)
	end
	function Vector:get(i)
		if i < 1 or i > self._size then
			return nil
		end
		return self._data[i - 1]
	end
	function Vector:data()
		return self._data
	end
	function Vector:set(i, x)
		if x == nil then
			self:remove(i)
		end
		if i > self._size + 1 then
			i = self._size + 1
		end
		if i > self._cap then
			VectorT__resize(self, math.max(i, self._cap * 2))
			self._size = i
		elseif i < 1 then
			return nil
		end
		self._data[i - 1] = x
		if i > self._size then
			self._size = i
		end
		self.__keep_alive[i] = x
	end
	function Vector:insert(i, x)
		if type(x) == 'nil' then
			self:push(i)
		elseif i < 1 then
			error("insert: index out of bounds")
		elseif i > self._size then
			self:push(x)
		else
			if self._size + 1 > self._cap then
				VectorT__resize(self)
			end
			C.lj_memmove(self._data + i, self._data + i - 1, (self._size - i + 1) * self.__ct_size)
			self._data[i - 1] = x
			self._size = self._size + 1
			table.insert(self.__keep_alive, i, x)
		end
	end
	function Vector:push(x)
		if x == nil then
			return
		end
		self:set(self._size + 1, x)
	end
	function Vector:pushWhereFits(x)
		for i = 1, #self do
			if self:get(i) == nil then
				self:set(i, x)
				return i
			end
		end
		self:push(x)
		return #self
	end
	function Vector:erase(x)
		for i = 1, #self do
			if self:get(i) == x then
				self:remove(i)
				return
			end
		end
	end
	function Vector:remove(i)
		if type(i) == 'nil' then
			return self:pop()
		end
		if i < 1 or i > self._size then
			return nil
		end
		local x = self._data[i - 1]
		C.lj_memmove(self._data + i - 1, self._data + i, (self._size - i + 1) * self.__ct_size)
		self._size = self._size - 1
		table.remove(self.__keep_alive, i)
		return x
	end
	function Vector:pop()
		if self._size == 0 then
			return nil
		end
		local x = self._data[self._size - 1]
		self._size = self._size - 1
		table.remove(self.__keep_alive, #self.__keep_alive)
		return x
	end
	function Vector:clear()
		self._size = 0
		for k in pairs(self.__keep_alive) do
			self.__keep_alive[k] = nil
		end
	end
	local VectorT__mt = {
		__new = function(vt, reserve_n)
			local self = ffi.new(vt)
			reserve_n = 16
			if reserve_n and reserve_n > 0 then
				local data = self.__alloc:allocate(reserve_n)
				if notdata then
					error('VectorT.new allocation failed')
				end
				self._data, self._size, self._cap = data, 0, reserve_n
			else
				self._data, self._size, self._cap = nil, 0, 0
			end
			if self.__cb ~= 0 then
				ffi.C[self.__cb](self)
			end
			return self
		end,
		__gc = function(self)
			self.__alloc:deallocate(self._data)
			self.__keep_alive = {}
			self._data, self._cap, self._size = nil, 0, 0
			if self.__cb ~= 0 then
				ffi.C[self.__cb](nil)
			end
			return self
		end,
		__len = function(self)
			return self._size
		end,
		__index = Vector,
		__newindex = function(self, k, v)
			return self:set(k, v)
		end
	}
	local function VectorT(ct, cb)
		if type(ct) ~= 'cdata' then
			error("argument 1 is not a valid 'cdata'")
		end
		local vt_mt = simple_deep_copy(VectorT__mt)
		vt_mt.__index.__ct = ct
		vt_mt.__index.__ct_size = ffi.sizeof(ct)
		vt_mt.__index.__alloc = MallocAllocator(ct)
		vt_mt.__index.__keep_alive = {}
		vt_mt.__index.__cb = cb or 0
		local vt = ffi.typeof(VectorT__cdef, ct)
		local result = ffi.metatype(vt, vt_mt)()
		setmetatable(vt_mt.__index, {
			__index = function(self, k)
				return result:get(k)
			end
		})
		return result
	end
	__vector = Vector
	function __bound_array(ct, cb)
		return VectorT(ct, cb)
	end
end
local function __ac_enums()
	ac.FogAlgorithm = {
		Original = 0,
		New = 1
	}
	ac.ShadowsState = {
		Off = 0,
		On = 1,
		EverythingShadowed = 2
	}
	ac.WeatherType = {
		LightThunderstorm = 0,
		Thunderstorm = 1,
		HeavyThunderstorm = 2,
		LightDrizzle = 3,
		Drizzle = 4,
		HeavyDrizzle = 5,
		LightRain = 6,
		Rain = 7,
		HeavyRain = 8,
		LightSnow = 9,
		Snow = 10,
		HeavySnow = 11,
		LightSleet = 12,
		Sleet = 13,
		HeavySleet = 14,
		Clear = 15,
		FewClouds = 16,
		ScatteredClouds = 17,
		BrokenClouds = 18,
		OvercastClouds = 19,
		Fog = 20,
		Mist = 21,
		Smoke = 22,
		Haze = 23,
		Sand = 24,
		Dust = 25,
		Squalls = 26,
		Tornado = 27,
		Hurricane = 28,
		Cold = 29,
		Hot = 30,
		Windy = 31,
		Hail = 32
	}
	ac.TonemapFunction = {
		Linear = 0,
		LinearClamped = 1,
		Sensitometric = 2,
		Reinhard = 3,
		ReinhardLum = 4,
		Log = 5,
		LogLum = 6
	}
	ac.FolderId = {
		AppData = 0,
		Documents = 1,
		Root = 4,
		Cfg = 5,
		Setups = 6,
		Logs = 7,
		Screenshots = 8,
		Replays = 9,
		ReplaysTemp = 10,
		UserSetups = 11,
		PPFilters = 12,
		ContentCars = 13,
		ContentDrivers = 14,
		ContentTracks = 15,
		ExtRoot = 16,
		ExtCfgSys = 17,
		ExtCfgUser = 18,
		ExtTextures = 21,
		ACApps = 23,
		ACAppsPython = 24,
		ExtCfgState = 25,
		ContentFonts = 26,
		RaceResults = 27
	}
	ac.HolidayType = {
		None = 0,
		NewYear = 1,
		Christmas = 2,
		VictoryDay = 3,
		IndependenceDay = 4,
		Halloween = 5,
		JapanFestival = 6,
		ChineseNewYear = 7,
		EidAlAdha = 8,
		GuyFawkesNight = 9
	}
end
local function __math()
	local function __clamp(x, min, max)
		return math.min(math.max(x, min), max)
	end
	math.clampN = __clamp
	math.saturateN = function(x)
		return math.min(math.max(x, 0), 1)
	end
	math.clampV = function(x, min, max)
		return x:clone():clamp(min, max)
	end
	math.saturateV = function(x, min, max)
		return x:clone():saturate()
	end
	math.clamp = function(x, min, max)
		if type(x) == 'number' then
			return __clamp(x, min, max)
		end
		local bn = type(min) == 'number'
		local bt = type(max) == 'number'
		if bn and bt then
			if vec3.isvec3(x) then
				return vec3(__clamp(x.x, min, max), __clamp(x.y, min, max), __clamp(x.z, min, max))
			end
			if vec2.isvec2(x) then
				return vec2(__clamp(x.x, min, max), __clamp(x.y, min, max))
			end
			if vec4.isvec4(x) then
				return vec4(__clamp(x.x, min, max), __clamp(x.y, min, max), __clamp(x.z, min, max), __clamp(x.w, min, max))
			end
			if rgb.isrgb(x) then
				return rgb(__clamp(x.r, min, max), __clamp(x.g, min, max), __clamp(x.b, min, max))
			end
			if rgbm.isrgbm(x) then
				return rgbm(__clamp(x.r, min, max), __clamp(x.g, min, max), __clamp(x.b, min, max), __clamp(x.mult, min, max))
			end
		end
		local b = bn and min or x:type().new(min)
		local t = bt and max or x:type().new(max)
		if vec3.isvec3(x) then
			return vec3(__clamp(x.x, b.x, t.x), __clamp(x.y, b.y, t.y), __clamp(x.z, b.z, t.z))
		end
		if vec2.isvec2(x) then
			return vec2(__clamp(x.x, b.x, t.x), __clamp(x.y, b.y, t.y))
		end
		if vec4.isvec4(x) then
			return vec4(__clamp(x.x, b.x, t.x), __clamp(x.y, b.y, t.y), __clamp(x.z, b.z, t.z), __clamp(x.w, b.w, t.w))
		end
		if rgb.isrgb(x) then
			return rgb(__clamp(x.r, b.r, t.r), __clamp(x.g, b.g, t.g), __clamp(x.b, b.b, t.b))
		end
		if rgbm.isrgbm(x) then
			return rgbm(__clamp(x.r, b.r, t.r), __clamp(x.g, b.g, t.g), __clamp(x.b, b.b, t.b), __clamp(x.mult, b.mult, t.mult))
		end
		return __clamp(x, min, max)
	end
	math.sign = function(x)
		if x > 0 then
			return 1
		elseif x < 0 then
			return -1
		else
			return 0
		end
	end
	math.lerp = function(x, y, s)
		return x * (1 - s) + y * s
	end
	math.lerpInvSat = function(s, min, max)
		return math.saturate((s - min) / (max - min))
	end
	math.saturate = function(x)
		return math.clamp(x, 0, 1)
	end
	math.smoothstep = function(x)
		return x * x * (3 - 2 * x)
	end
	math.smootherstep = function(x)
		return x * x * x * (x * (x * 6 - 15) + 10)
	end
	math.normalize = function(x)
		return x:clone():normalize()
	end
	math.cross = function(x, y)
		return x:clone():cross(y)
	end
	math.dot = function(x, y)
		return x:dot(y)
	end
	math.angle = function(x, y)
		return x:angle(y)
	end
	math.distance = function(x, y)
		return x:distance(y)
	end
	math.project = function(x, y)
		return x:clone():project(y)
	end
	math.radians = function(x)
		return x * math.pi / 180
	end
	math.degress = function(x)
		return x * 180 / math.pi
	end
	math.lagMult = function(lag, dt)
		return math.saturate((1.0 - lag) * dt * 60)
	end
	math.applyLag = function(v, target, lag, dt)
		if lag <= 0 then
			return target
		end
		return v + (target - v) * math.lagMult(lag, dt)
	end
	local poissonData = __bound_array(ffi.typeof('vec2'), nil)
	math.poissonSamplerCircle = function(size)
		ffi.C.lj_poissonsampler_circle(poissonData, size)
		local result = {}
		for i = 1, #poissonData do
			result[i] = poissonData:get(i)
		end
		poissonData:clear()
		return result
	end
end
local function __ac_audio()
	ffi.cdef [[ 
typedef struct {
  void* host_;
  void* nativeEvent_;
  float volume;
  float cameraInteriorMultiplier;
  float cameraExteriorMultiplier;
  float cameraTrackMultiplier;
  bool inAutoLoopMode;
} audioevent;
]]
	ac.AudioEvent = function(s, reverbResponse)
		local created = ffi.C.lj_audioevent_new(tostring(s), reverbResponse and true or false)
		return ffi.gc(created, ffi.C.lj_audioevent_gc)
	end
	__audioEventKeepAlive = {}
	ffi.metatype('audioevent', {
		__index = function(self, key)
			if key == 'setPosition' then
				return function(s, pos, dir, up, vel)
					ffi.C.lj_audioevent_set_pos(s, pos, dir or vec3.new(0, 0, 1), up or vec3.new(0, 1, 0), vel or vec3.new(0, 0, 0))
				end
			end
			if key == 'keepAlive' then
				return function(s)
					__audioEventKeepAlive[#__audioEventKeepAlive + 1] = s
				end
			end
			if key == 'setParam' then
				return ffi.C.lj_audioevent_set_param
			end
			if key == 'isValid' then
				return function(s)
					return s.host_ ~= nil and s.nativeEvent_ ~= nil
				end
			end
			if key == 'isPlaying' then
				return ffi.C.lj_audioevent_is_playing
			end
			if key == 'isPaused' then
				return ffi.C.lj_audioevent_is_paused
			end
			if key == 'isWithinRange' then
				return ffi.C.lj_audioevent_is_within_range
			end
			if key == 'resume' then
				return ffi.C.lj_audioevent_resume
			end
			if key == 'resumeIf' then
				return ffi.C.lj_audioevent_resume_if
			end
			if key == 'stop' then
				return ffi.C.lj_audioevent_stop
			end
			if key == 'start' then
				return ffi.C.lj_audioevent_start
			end
			error('audioevent has no member called \'' .. key .. '\'')
		end,
		__newindex = function(self, key, value)
			error('audioevent has no member called \'' .. key .. '\'')
		end
	})
end
ac = {}
function __sane(x)
	if type(x) == 'number' then
		if not(x > -math.huge and x < math.huge) then
			error('finite value is required, got: ' .. x)
		end
	elseif vec2.isvec2(x) then
		__sane(x.x)
		__sane(x.y)
	elseif vec3.isvec3(x) then
		__sane(x.x)
		__sane(x.y)
		__sane(x.z)
	elseif vec4.isvec4(x) then
		__sane(x.x)
		__sane(x.y)
		__sane(x.z)
		__sane(x.w)
	elseif rgb.isrgb(x) then
		__sane(x.r)
		__sane(x.g)
		__sane(x.b)
	end
	return x
end
ac.__sane = __sane
ac.__sane_rgb = function(x)
	if type(x) == 'number' then
		__sane(x)
		return rgb(x, x, x)
	elseif rgb.isrgb(x) then
		__sane(x.r)
		__sane(x.g)
		__sane(x.b)
		return x
	else
		return rgb.new(x)
	end
end
ac.skipSaneChecks = function()
	ac.__sane = function(x)
		return x
	end
	ac.__sane_rgb = function(x)
		if type(x) == 'number' then
			return rgb(x, x, x)
		elseif rgb.isrgb(x) then
			return x
		else
			return rgb.new(x)
		end
	end
end
function __num_fallback(v, f)
	if type(v) ~= 'number' then
		return f
	end
	return v
end
require 'ffi'
__ac_primitive()
__vector()
__ac_enums()
__math()
__ac_audio()
ffi.cdef [[
void* lj_memmove(void* dst, const void* src, size_t len);
void* lj_malloc(size_t size);
void* lj_calloc(size_t count, size_t size);
void* lj_realloc(void* ptr, size_t size);
void lj_free(void* ptr);
void lj_debug(const char* key, const char* value);
void lj_log(const char* value);
void lj_warn(const char* value);
void lj_error(const char* value);
const char* lj_dirname();
const char* lj_getPatchVersion();
int lj_getPatchVersionCode();
const char* lj_getFolder(int f);
const char* lj_getTrackId();
const char* lj_getTrackLayout();
vec3 lj_getCameraPosition();
vec3 lj_getCameraUp();
vec3 lj_getCameraSide();
vec3 lj_getCameraForward();
vec3 lj_getCameraDirection();
float lj_getCameraFOV();
void lj_getCameraPositionTo(vec3& r);
void lj_getCameraUpTo(vec3& r);
void lj_getCameraSideTo(vec3& r);
void lj_getCameraForwardTo(vec3& r);
void lj_getCameraDirectionTo(vec3& r);
float lj_getSunAngle();
float lj_getSunPitchAngle();
float lj_getSunHeadingAngle();
bool lj_isInteriorView();
bool lj_isInReplayMode();
float lj_getDeltaT();
float lj_getGameDeltaT();
float lj_getConditionsTimeScale();
const char* lj_readDataFile(const char* value);
bool lj_loadSoundbank(const char* soundbank, const char* guids);
audioevent* lj_audioevent_new(const char* path, bool reverb_response);
void lj_audioevent_gc(audioevent* r);
void lj_audioevent_set_pos(audioevent* self, const vec3& pos, const vec3& dir, const vec3& up, const vec3& velocity);
void lj_audioevent_set_param(audioevent* self, const char* name, float value);
bool lj_audioevent_is_playing(audioevent* self);
bool lj_audioevent_is_paused(audioevent* self);
bool lj_audioevent_is_within_range(audioevent* self);
void lj_audioevent_resume(audioevent* self);
void lj_audioevent_resume_if(audioevent* self, bool c);
void lj_audioevent_stop(audioevent* self);
void lj_audioevent_start(audioevent* self);
bool lj_isJoystickButtonPressed(uint32_t joystick, uint32_t button);
float lj_getJoystickAxisValue(uint32_t joystick, uint32_t axis);
float lj_isJoystickAxisValue(uint32_t joystick, uint32_t axis);
int lj_getJoystickDpadValue(uint32_t joystick, uint32_t dpad);
int lj_isJoystickDpadValue(uint32_t joystick, uint32_t dpad);
void lj_poissonsampler_circle(void* value, int size);
void lj_poissonsampler_square(void* value, int size);
bool lj_cfg_track_bool(const char* key, const char* value, bool def);
int lj_cfg_track_integer(const char* key, const char* value, int def);
rgb lj_cfg_track_rgb(const char* key, const char* value, const rgb& def);
rgbm lj_cfg_track_rgbm(const char* key, const char* value, const rgbm& def);
vec2 lj_cfg_track_vec2(const char* key, const char* value, const vec2& def);
vec3 lj_cfg_track_vec3(const char* key, const char* value, const vec3& def);
vec4 lj_cfg_track_vec4(const char* key, const char* value, const vec4& def);
float lj_cfg_track_decimal(const char* key, const char* value, float def);
const char* lj_cfg_track_string(const char* key, const char* value, const char* def);
]]
ac.debug = function(key, value)
	ffi.C.lj_debug(key ~= nil and tostring(key) or nil, value ~= nil and tostring(value) or nil)
end
ac.log = function(value)
	ffi.C.lj_log(value ~= nil and tostring(value) or nil)
end
ac.warn = function(value)
	ffi.C.lj_warn(value ~= nil and tostring(value) or nil)
end
ac.error = function(value)
	ffi.C.lj_error(value ~= nil and tostring(value) or nil)
end
ac.dirname = function()
	return ffi.string(ffi.C.lj_dirname())
end
ac.getPatchVersion = function()
	return ffi.string(ffi.C.lj_getPatchVersion())
end
ac.getPatchVersionCode = ffi.C.lj_getPatchVersionCode
ac.getFolder = function(f)
	return ffi.string(ffi.C.lj_getFolder(ac.__sane(f)))
end
ac.getTrackId = function()
	return ffi.string(ffi.C.lj_getTrackId())
end
ac.getTrackLayout = function()
	return ffi.string(ffi.C.lj_getTrackLayout())
end
ac.getCameraPosition = ffi.C.lj_getCameraPosition
ac.getCameraUp = ffi.C.lj_getCameraUp
ac.getCameraSide = ffi.C.lj_getCameraSide
ac.getCameraForward = ffi.C.lj_getCameraForward
ac.getCameraDirection = ffi.C.lj_getCameraDirection
ac.getCameraFOV = ffi.C.lj_getCameraFOV
ac.getCameraPositionTo = function(r)
	ffi.C.lj_getCameraPositionTo(ac.__sane(r))
end
ac.getCameraUpTo = function(r)
	ffi.C.lj_getCameraUpTo(ac.__sane(r))
end
ac.getCameraSideTo = function(r)
	ffi.C.lj_getCameraSideTo(ac.__sane(r))
end
ac.getCameraForwardTo = function(r)
	ffi.C.lj_getCameraForwardTo(ac.__sane(r))
end
ac.getCameraDirectionTo = function(r)
	ffi.C.lj_getCameraDirectionTo(ac.__sane(r))
end
ac.getSunAngle = ffi.C.lj_getSunAngle
ac.getSunPitchAngle = ffi.C.lj_getSunPitchAngle
ac.getSunHeadingAngle = ffi.C.lj_getSunHeadingAngle
ac.isInteriorView = ffi.C.lj_isInteriorView
ac.isInReplayMode = ffi.C.lj_isInReplayMode
ac.getDeltaT = ffi.C.lj_getDeltaT
ac.getGameDeltaT = ffi.C.lj_getGameDeltaT
ac.getConditionsTimeScale = ffi.C.lj_getConditionsTimeScale
ac.readDataFile = function(value)
	return ffi.string(ffi.C.lj_readDataFile(value ~= nil and tostring(value) or nil))
end
ac.loadSoundbank = function(soundbank, guids)
	return ffi.C.lj_loadSoundbank(soundbank ~= nil and tostring(soundbank) or nil, guids ~= nil and tostring(guids) or nil)
end
ac.isJoystickButtonPressed = function(joystick, button)
	return ffi.C.lj_isJoystickButtonPressed(ac.__sane(joystick), ac.__sane(button))
end
ac.getJoystickAxisValue = function(joystick, axis)
	return ffi.C.lj_getJoystickAxisValue(ac.__sane(joystick), ac.__sane(axis))
end
ac.isJoystickAxisValue = function(joystick, axis)
	return ffi.C.lj_isJoystickAxisValue(ac.__sane(joystick), ac.__sane(axis))
end
ac.getJoystickDpadValue = function(joystick, dpad)
	return ffi.C.lj_getJoystickDpadValue(ac.__sane(joystick), ac.__sane(dpad))
end
ac.isJoystickDpadValue = function(joystick, dpad)
	return ffi.C.lj_isJoystickDpadValue(ac.__sane(joystick), ac.__sane(dpad))
end
