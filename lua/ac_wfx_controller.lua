	local function __ac_trackconfig()
	ac.getTrackConfig = function()
		return {
			bool = function(key, value, def)
				return ffi.C.lj_cfg_track_bool(tostring(key or ""), tostring(value or ""), def and true or false)
			end,
			number = function(key, value, def)
				return ffi.C.lj_cfg_track_decimal(tostring(key or ""), tostring(value or ""), def or 0)
			end,
			string = function(key, value, def)
				return ffi.string(ffi.C.lj_cfg_track_string(tostring(key or ""), tostring(value or ""), tostring(def or "")))
			end,
			rgb = function(key, value, def)
				return ffi.C.lj_cfg_track_rgb(tostring(key or ""), tostring(value or ""), def or rgb())
			end,
			rgbm = function(key, value, def)
				return ffi.C.lj_cfg_track_rgbm(tostring(key or ""), tostring(value or ""), def or rgbm())
			end,
			vec2 = function(key, value, def)
				return ffi.C.lj_cfg_track_vec2(tostring(key or ""), tostring(value or ""), def or vec2())
			end,
			vec3 = function(key, value, def)
				return ffi.C.lj_cfg_track_vec3(tostring(key or ""), tostring(value or ""), def or vec3())
			end,
			vec4 = function(key, value, def)
				return ffi.C.lj_cfg_track_vec4(tostring(key or ""), tostring(value or ""), def or vec4())
			end
		}
	end
end
local function __ac_weatherconditions()
	ffi.cdef [[ 
typedef struct {
  float ambient, road;
} weather_conditions_temperatures;

typedef struct {
  float sessionStart, sessionTransfer, randomness, lapGain;
} weather_conditions_track;

typedef struct {
  float direction, speedFrom, speedTo;
} weather_conditions_wind;

typedef struct {
  char currentType;
  char upcomingType;
  weather_conditions_temperatures temperatures;
  weather_conditions_track trackState;
  weather_conditions_wind wind;
  float transition;
  float humidity, pressure;
  float variableA, variableB, variableC;
  float rainIntensity, rainWetness, rainWater;
} weather_conditions;
]]
	ac.TrackConditions = ffi.metatype('weather_conditions_track', {
		__index = {}
	})
	ac.TemperatureParams = ffi.metatype('weather_conditions_temperatures', {
		__index = {}
	})
	ac.WindParams = ffi.metatype('weather_conditions_wind', {
		__index = {}
	})
	ac.ConditionsSet = ffi.metatype('weather_conditions', {
		__index = {}
	})
end
require "extension/lua/ac_common"
__ac_trackconfig()
__ac_weatherconditions()
ffi.cdef [[
double lj_getCurrentTime();
float lj_getDaySeconds();
int lj_getDayOfTheYear();
float lj_getTimeMultiplier();
vec3 lj_getSunDirection();
void lj_getSunDirectionTo(vec3& r);
vec3 lj_getMoonDirection();
void lj_getMoonDirectionTo(vec3& r);
float lj_getMoonFraction();
float lj_getAltitude();
float lj_getSunAltitude();
vec2 lj_getTrackCoordinates();
uint64_t lj_getInputDate();
float lj_getRealTrackHeadingAngle();
float lj_getTimeZoneOffset();
float lj_getTimeZoneDstOffset();
float lj_getTimeZoneBaseOffset();
weather_conditions lj_getConditionsSet();
void lj_getConditionsSetTo(weather_conditions& r);
const char* lj_getPpFilter();
char lj_getInputWeatherType__controller();
weather_conditions_temperatures lj_getInputTemperatures__controller();
weather_conditions_wind lj_getInputWind__controller();
weather_conditions_track lj_getInputTrackState__controller();
void lj_setConditionsSet__controller(const weather_conditions& c);
]]
ac.getCurrentTime = ffi.C.lj_getCurrentTime
ac.getDaySeconds = ffi.C.lj_getDaySeconds
ac.getDayOfTheYear = ffi.C.lj_getDayOfTheYear
ac.getTimeMultiplier = ffi.C.lj_getTimeMultiplier
ac.getSunDirection = ffi.C.lj_getSunDirection
ac.getSunDirectionTo = function(r)
	ffi.C.lj_getSunDirectionTo(ac.__sane(r))
end
ac.getMoonDirection = ffi.C.lj_getMoonDirection
ac.getMoonDirectionTo = function(r)
	ffi.C.lj_getMoonDirectionTo(ac.__sane(r))
end
ac.getMoonFraction = ffi.C.lj_getMoonFraction
ac.getAltitude = ffi.C.lj_getAltitude
ac.getSunAltitude = ffi.C.lj_getSunAltitude
ac.getTrackCoordinates = ffi.C.lj_getTrackCoordinates
ac.getInputDate = ffi.C.lj_getInputDate
ac.getRealTrackHeadingAngle = ffi.C.lj_getRealTrackHeadingAngle
ac.getTimeZoneOffset = ffi.C.lj_getTimeZoneOffset
ac.getTimeZoneDstOffset = ffi.C.lj_getTimeZoneDstOffset
ac.getTimeZoneBaseOffset = ffi.C.lj_getTimeZoneBaseOffset
ac.getConditionsSet = ffi.C.lj_getConditionsSet
ac.getConditionsSetTo = function(r)
	ffi.C.lj_getConditionsSetTo(ac.__sane(r))
end
ac.getPpFilter = function()
	return ffi.string(ffi.C.lj_getPpFilter())
end
ac.getInputWeatherType = ffi.C.lj_getInputWeatherType__controller
ac.getInputTemperatures = ffi.C.lj_getInputTemperatures__controller
ac.getInputWind = ffi.C.lj_getInputWind__controller
ac.getInputTrackState = ffi.C.lj_getInputTrackState__controller
ac.setConditionsSet = function(c)
	ffi.C.lj_setConditionsSet__controller(ac.__sane(c))
end
