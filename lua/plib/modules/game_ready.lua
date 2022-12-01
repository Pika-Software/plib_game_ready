local timer_Simple = timer.Simple
local LocalPlayer = LocalPlayer
local hook_Remove = hook.Remove
local hook_Add = hook.Add
local hook_Run = hook.Run
local IsValid = IsValid
local Info = plib.Info

local PLAYER = FindMetaTable( 'Player' )
if (PLAYER) then
    function PLAYER:Initialized()
        return self:GetNWBool( 'm_pInitialized', false )
    end
end

module( 'game' )

local ready = false
function IsReady()
    return ready
end

if (CLIENT) then
    hook_Add('RenderScene', 'Game Ready - CLIENT', function()
        local ply = LocalPlayer()
        if IsValid( ply ) then
            hook_Remove( 'RenderScene', 'Game Ready - CLIENT' )
            ready = true

            hook_Run( 'PlayerInitialized', ply )
            hook_Run( 'GameReady' )
            Info( 'Game ready!' )
        end
    end)

    hook_Add('ShutDown', 'Game Ready - CLIENT', function()
        hook_Remove('ShutDown', 'Game Ready - CLIENT')

        local ply = LocalPlayer()
        if IsValid( ply ) then
            hook_Run( 'PlayerDisconnected', ply )
        end
    end)

    return
end

timer_Simple(0, function()
    ready = true

    hook_Add('PlayerInitialSpawn', 'Game Ready - SERVER', function( ply )
        hook_Add('SetupMove', ply, function( self, _, mv, cmd )
            if (self == ply) and not cmd:IsForced() then
                hook_Remove( 'SetupMove', self )
                Info( 'Player {0} ({1}) is fully initialized.', self:Nick(), self:IsBot() and 'BOT' or self:SteamID() )
                self:SetNWBool( 'm_pInitialized', true )
                hook_Run( 'PlayerInitialized', self )
            end
        end)
    end)

    Info( 'Game is ready!')
    hook_Run( 'GameReady' )
end)

