local objectname= "artBush3Lo" 
local featureDef	=	{
	name			= "artBush3Lo",
	world				="All Worlds",
	description				="artBush3Lo",
	category				="Vegetation",
	object				="features/artturi/artBush3Lo.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=30,
	blocking				=false,
	upright				=true,
	hitdensity				=0,
	energy				=1,

	damage				=100,
	flammable				=true,
	reclaimable				=false,
	autoreclaimable				=false,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	collisionvolumetype				="box",
	collisionvolumescales				={5, 50, 5},
	collisionvolumeoffsets				={0, 0, 0},
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
