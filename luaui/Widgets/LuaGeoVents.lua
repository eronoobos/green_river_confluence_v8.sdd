function widget:GetInfo()
  return {
    name      = "Lua GeoVents V1.0",
    desc      = "Draws vents where there are vents.",
    author    = "zoggop",
    date      = "2014-02-28",
    license   = "whatever",
    layer     = 5,
    enabled   = true  --  loaded by default?
  }
end

-- Variables
local displayList 		= 0
local geoVentWidth    = 48
local geoVentHeight   = 48
local halfGeoVentWidth = geoVentWidth / 2
local halfGeoVentHeight = geoVentHeight / 2
-- End variables

-- local functions
local function GetGeoVents()
	local geoVents = {}
	local features = Spring.GetAllFeatures()
	for i = 1, #features do
		local fID = features[i]
		if FeatureDefs[Spring.GetFeatureDefID(fID)]["geoThermal"] then
			local x, y, z = Spring.GetFeaturePosition(fID)
			table.insert(geoVents, {x = x, z = z})
		end
	end
	return geoVents
end
-- end local functions

function widget:Initialize()
	displayList = gl.CreateList(drawPatches)
end

function drawPatches()
	local gVents = GetGeoVents()
	
	-- Switch to texture matrix mode
	gl.MatrixMode(GL.TEXTURE)

    gl.PolygonOffset(-25, -2)
    gl.Culling(GL.BACK)
    gl.DepthTest(true)
	gl.Texture("maps/geo.png")
	gl.Color(1, 1, 1) -- fix color from other widgets
	
	for i = 1, #gVents do
		local rotation = math.random(0, 360)
		gl.PushMatrix()
		gl.Translate(0.5, 0.5, 0)
		gl.Rotate( rotation, 0, 0, 1)
		gl.DrawGroundQuad( gVents[i].x - halfGeoVentWidth, gVents[i].z - halfGeoVentHeight, gVents[i].x + halfGeoVentWidth, gVents[i].z + halfGeoVentHeight, false, -0.5,-0.5, 0.5,0.5)
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
	gl.CallList(displayList)
end