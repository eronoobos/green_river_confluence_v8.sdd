--------------------------------------------------------------------------------

--   Changelog:
--   v4.2-multi
--   * multiple metal textures for multiple metal values
--   * support for dynamic metal multilayouts
--
--   v4.2
--   * random rotation works again
--   * not drawn in f4 (metal mode) anymore
--
--	 v4.1
--   * No longer drawn while in F1 (height) mode.
-- 
--	 v4.0
--	 * Rewrote from scratch using Niobium metal finder available globally in BA.
--
--   v3.3
--   * fixed issues with archive loading
--   v3.2
--   * fixed drawing on sloped terrain
--   * randomness and multiple textures is broken
--
--   v3.1
--   * fixed depth testing issue
--
--   v3
--   * changed to Niobium metal finder with mass metal detection.
--
--   v2
--   * added display lists
--   * added loading metal maps from file
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:GetInfo()
  return {
    name      = "Lua Metal Spots V4.2-multi",
    desc      = "Requires Dynamic Metal Map Multilayout or Niobium's metal finder.",
    author    = "Cheesecan, zoggop",
    date      = "2014-02-28",
    license   = "LGPL v2",
    layer     = 5,
    enabled   = true  --  loaded by default?
  }
end

-- Variables
local displayList 		= 0
local metalSpotWidth    = 110
local metalSpotHeight   = 110
local halfWidth = math.ceil(metalSpotWidth / 2)
local halfHeight = math.ceil(metalSpotHeight / 2)
-- worth below or equal to the key gets this texture
local metalTextures = {
	"maps/metal1.png",
	"maps/metal2.png",
	"maps/metal3.png",
	"maps/metal4.png",
}
local defaultMetalTexture = "maps/metal.png"
local mm = {}
-- End variables

local function SortMetalValues(mSpots)
	local mvalues = {}
	local mvaluelist = {}
	local highestMetal = 0
	for i = 1, #mSpots do
		local spot = mSpots[i]
		local metal = spot.metal or math.ceil(spot.worth / 100) / 10
		if metal > highestMetal then highestMetal = metal end
		if mvalues[metal] == nil then
			mvalues[metal] = true
			table.insert(mvaluelist, metal)
		end
	end
	table.sort(mvaluelist)
	for i = 1, #mvaluelist do
		local metal = mvaluelist[i]
		mvalues[metal] = i
	end
	return mvalues, highestMetal
end

function widget:Initialize()

	-- below writes a dynamic metal layout of the current metal map
	--[[
	if WG then
		local mSpots = WG.metalSpots
		if mSpots then
			local metalfile = io.open("metals.lua", 'w')
			metalfile:write("return {\n\tspots = {\n")
			for i = 1, #mSpots do
				local spot = mSpots[i]
				metalfile:write("\t\t{x = " .. spot.x .. ", z = " .. spot.z .. ", metal = " .. spot.worth/1000 .. "},\n")
			end
			metalfile:write("\t}\n}")
			io.close()
		end
	end
	]]--

	-- which metal spot layout to load based on map option
	local layout = "normal"
	local options = Spring.GetMapOptions()
	if options ~= nil then
		if options.metal ~= nil then
			layout = options.metal
		end
	end
	local layoutFile = "mapconfig/metal_layouts/metal_layout_" .. layout .. ".lua"
	if VFS.FileExists(layoutFile) then
		mm = VFS.Include(layoutFile)
		Spring.Echo("Parsing " .. layoutFile)
	else
		Spring.Echo("missing " .. layoutFile .. " - using metal finder.")
	end
	if not mm.spots and not WG.metalSpots then
		Spring.Echo("<Lua Metal Patches> This widget requires either Dynamic Metal Multilayout gadget or the 'Metalspot Finder' widget to run.")
		widgetHandler:RemoveWidget(self)
	end

	displayList = gl.CreateList(drawPatches)
end

function drawPatches()
	local mSpots = mm.spots or WG.metalSpots
	local metalValues, highestMetal = SortMetalValues(mSpots)
	local hw, hh = halfWidth, halfHeight
	-- Switch to texture matrix mode
	gl.MatrixMode(GL.TEXTURE)
	
    gl.PolygonOffset(-25, -2)
    gl.Culling(GL.BACK)
    gl.DepthTest(true)
	gl.Color(1, 1, 1) -- fix color from other widgets
	
	for i = 1, #mSpots do
		local spot = mSpots[i]
		local metal = spot.metal or math.ceil(spot.worth / 100) / 10
		local tex = metalTextures[metalValues[metal]] or defaultMetalTexture
		gl.Texture(tex)
		local metal_rotation = math.random(0, 360)
		gl.PushMatrix()
		gl.Translate(0.5, 0.5, 0)
		gl.Rotate( metal_rotation, 0, 0, 1)
		gl.DrawGroundQuad( spot.x - hw, spot.z - hh, spot.x + hw, spot.z + hh, false, -0.5,-0.5, 0.5,0.5)
		gl.PopMatrix()
		
	end
    gl.Texture(false)
    gl.DepthTest(false)
    gl.Culling(false)
    gl.PolygonOffset(false)
	
	-- Restore Modelview matrix
	gl.MatrixMode(GL.MODELVIEW)
end

function widget:DrawWorldPreUnit()
	local mode = Spring.GetMapDrawMode()
	
	if(mode ~= "height" and mode ~= "metal") then
		gl.CallList(displayList)
	end
	
end