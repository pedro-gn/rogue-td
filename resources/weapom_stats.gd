extends Resource


enum WEAPONS_TYPES {MELEE, RANGED}

@export var name : String
@export var texture : CompressedTexture2D
@export var type : WEAPONS_TYPES
@export var gold_cost : int 
