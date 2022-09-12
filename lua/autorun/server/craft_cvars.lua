--Temporary fix for cvars not being sent between client and server properly until the Gmod devs fix those bugs
util.AddNetworkString( "Craft_ChangeCvar" )
local function ChangeCvar( len, ply )
	if !ply:IsSuperAdmin() then return end
	local name = net.ReadString()
	local new = net.ReadString()
	RunConsoleCommand( name, new )
end
net.Receive( "Craft_ChangeCvar", ChangeCvar )
