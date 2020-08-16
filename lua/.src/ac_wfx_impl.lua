require './ac_common'
require './wfx_common/ac_trackconfig'
require './wfx_common/ac_weatherconditions'
require './wfx_impl/ac_clouds'
require './wfx_impl/ac_gradients'
require './wfx_impl/ac_colorcorrections'
require './wfx_impl/ac_particlematerials'
require './wfx_impl/ac_lightpollution'

ffi.cdef [[
DEFINITIONS
]]
SANE
EXPORT

ac.setTrackCondition = function (key, value)
  ffi.C.lj_set_track_condition__impl(key, value)
end

require './wfx_impl/ac_obsolete'
require './wfx_impl/ac_lists'