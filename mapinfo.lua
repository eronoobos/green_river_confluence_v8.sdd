--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- mapinfo.lua
--

local mapinfo = {
	name        = "Green River Confluence",
	shortname   = "GRCv8",
	description = "3 player FFA map. Metal in the river.",
	author      = "heightmap by zoggop, texture by Beherith, features by SirArtturi and LathanStanley",
	version     = "v8",
	--mutator   = "deployment";
	--mapfile   = "", --// location of smf/sm3 file (optional)
	modtype     = 3, --// 1=primary, 0=hidden, 3=map
	depend      = {"Map Helper v1"},
	replace     = {},

	--startpic   = "", --// deprecated
	--StartMusic = "", --// deprecated

	maphardness     = 200,
	notDeformable   = false,
	gravity         = 120,
	tidalStrength   = 15,
	maxMetal        = 1.0,
	extractorRadius = 100.0,
	voidWater       = false,
	autoShowMetal   = true,


	smf = {
		minheight = -22,
		maxheight = 263,
		--smtFileName0 = "",
		--smtFileName1 = "",
		--smtFileName.. = "",
		--smtFileNameN = "",
	},

	sound = {
		--// Sets the _reverb_ preset (= echo parameters),
		--// passfilter (the direct sound) is unchanged.
		--//
		--// To get a list of all possible presets check:
		--//   https://github.com/spring/spring/blob/master/rts/System/Sound/EFXPresets.cpp
		--//
		--// Hint:
		--// You can change the preset at runtime via:
		--//   /tset UseEFX [1|0]
		--//   /tset snd_eaxpreset preset_name   (may change to a real cmd in the future)
		--//   /tset snd_filter %gainlf %gainhf  (may    "   "  "  "    "  "   "    "   )
		preset = "default",

		passfilter = {
			--// Note, you likely want to set these
			--// tags due to the fact that they are
			--// _not_ set by `preset`!
			--// So if you want to create a muffled
			--// sound you need to use them.
			gainlf = 1.0,
			gainhf = 1.0,
		},

		reverb = {
			--// Normally you just want use the `preset` tag
			--// but you can use handtweak a preset if wanted
			--// with the following tags.
			--// To know their function & ranges check the
			--// official OpenAL1.1 SDK document.
			
			--density
			--diffusion
			--gain
			--gainhf
			--gainlf
			--decaytime
			--decayhflimit
			--decayhfratio
			--decaylfratio
			--reflectionsgain
			--reflectionsdelay
			--reflectionspan
			--latereverbgain
			--latereverbdelay
			--latereverbpan
			--echotime
			--echodepth
			--modtime
			--moddepth
			--airabsorptiongainhf
			--hfreference
			--lfreference
			--roomrollofffactor
		},
	},

	resources = {
		--grassBladeTex = "",

		--grassShadingTex = "",
		--detailTex = "",
		specularTex = "spec.tga",
		splatDetailTex = "splattex.tga",
		splatDistrTex = "splatdist.tga",
		--skyReflectModTex = "",
		--detailNormalTex = "",
		--lightEmissionTex = "",
	},

	splats = {
		texScales = {0.004, 0.009, 0.005, 0.01},
		texMults  = {0.3, 0.8, 0.5, 0.8},
	},

	atmosphere = {
		minWind      = 5.0,
		maxWind      = 25.0,

		fogStart     = 0.1,
		fogEnd       = 1.0,
		fogColor     = {0.7, 0.7, 0.8},

		sunColor     = {1.0, 1.0, 1.0},
		skyColor     = {0.1, 0.15, 0.7},
		skyDir       = {0.0, 0.0, -1.0},
		skyBox       = "",

		cloudDensity = 0.5,
		cloudColor   = {1.0, 1.0, 1.0},
	},

	grass = {
		bladeWaveScale = 3.0,
		bladeWidth  = 0.4,
		bladeHeight = 8.0,
		bladeAngle  = 2.5,
		bladeColor  = {0.59, 0.81, 0.57}, --// does nothing when `grassBladeTex` is set
	},

	lighting = {
		--// dynsun
		sunStartAngle = 0.0,
		sunOrbitTime  = 1440.0,
		sunDir        = {1.0, 0.8, 0.0, 1e9},

		--// unit & ground lighting
		groundAmbientColor  = {0.5, 0.5, 0.6},
		groundDiffuseColor  = {1.0, 1.0, 0.7},
		groundSpecularColor = {1.0, 1.0, 1.0},
		groundShadowDensity = 0.8,
		unitAmbientColor    = {0.5, 0.5, 0.6},
		unitDiffuseColor    = {1.0, 1.0, 0.7},
		unitSpecularColor   = {1.0, 1.0, 1.0},
		unitShadowDensity   = 0.8,
		
		specularExponent    = 100.0,
	},
	
	water = {
		damage =  0.0,

		repeatX = 0.0,
		repeatY = 0.0,

		absorb    = {0.2, 0.1, 0.2},
		baseColor = {0.5, 0.6, 0.2},
		minColor  = {0.3, 0.2, 0.1},

		ambientFactor  = 1.0,
		diffuseFactor  = 1.0,
		specularFactor = 1.0,
		specularPower  = 20.0,

		planeColor = {0.0, 0.4, 0.0},

		surfaceColor  = {0.5, 0.6, 0.2},
		surfaceAlpha  = 0.55,
		diffuseColor  = {1.0, 1.0, 1.0},
		specularColor = {0.5, 0.5, 0.5},

		fresnelMin   = 0.2,
		fresnelMax   = 0.8,
		fresnelPower = 4.0,

		reflectionDistortion = 1.0,

		blurBase      = 2.0,
		blurExponent = 1.5,

		perlinStartFreq  =  8.0,
		perlinLacunarity = 3.0,
		perlinAmplitude  =  0.9,
		windSpeed = 1.0, --// does nothing yet

		shoreWaves = true,
		forceRendering = false,

		--// undefined == load them from resources.lua!
		--texture =       "",
		--foamTexture =   "",
		--normalTexture = "",
		--caustics = {
		--	"",
		--	"",
		--},
	},

	teams = {
		[0] = {startPos = {x = 4746, z = 7934}},
		[1] = {startPos = {x = 7702, z = 839}},
		[2] = {startPos = {x = 64, z = 1870}},
	},

	terrainTypes = {
		[0] = {
			name = "Default",
			hardness = 1.0,
			receiveTracks = true,
			moveSpeeds = {
				tank  = 1.0,
				kbot  = 1.0,
				hover = 1.0,
				ship  = 1.0,
			},
		},
	},

	custom = {
		fog = {
			color    = {0.26, 0.30, 0.41},
			height   = "80%", --// allows either absolue sizes or in percent of map's MaxHeight
			fogatten = 0.003,
		},
		precipitation = {
			density   = 30000,
			size      = 1.5,
			speed     = 50,
			windscale = 1.2,
			texture   = 'LuaGaia/effects/snowflake.png',
		},
	},
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Helper

local function lowerkeys(ta)
	local fix = {}
	for i,v in pairs(ta) do
		if (type(i) == "string") then
			if (i ~= i:lower()) then
				fix[#fix+1] = i
			end
		end
		if (type(v) == "table") then
			lowerkeys(v)
		end
	end
	
	for i=1,#fix do
		local idx = fix[i]
		ta[idx:lower()] = ta[idx]
		ta[idx] = nil
	end
end

lowerkeys(mapinfo)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Map Options

if (Spring) then
	local function tmerge(t1, t2)
		for i,v in pairs(t2) do
			if (type(v) == "table") then
				t1[i] = t1[i] or {}
				tmerge(t1[i], v)
			else
				t1[i] = v
			end
		end
	end

	-- make code safe in unitsync
	if (not Spring.GetMapOptions) then
		Spring.GetMapOptions = function() return {} end
	end
	function tobool(val)
		local t = type(val)
		if (t == 'nil') then
			return false
		elseif (t == 'boolean') then
			return val
		elseif (t == 'number') then
			return (val ~= 0)
		elseif (t == 'string') then
			return ((val ~= '0') and (val ~= 'false'))
		end
		return false
	end

	getfenv()["mapinfo"] = mapinfo
		local files = VFS.DirList("mapconfig/mapinfo/", "*.lua")
		table.sort(files)
		for i=1,#files do
			local newcfg = VFS.Include(files[i])
			if newcfg then
				lowerkeys(newcfg)
				tmerge(mapinfo, newcfg)
			end
		end
	getfenv()["mapinfo"] = nil
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return mapinfo

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------