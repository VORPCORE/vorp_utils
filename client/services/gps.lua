GpsApi = {}

local GpsToEntity = false

function GpsApi:SetGps(x, y, z)
    local pl = GetEntityCoords(PlayerPedId())
    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(pl.x, pl.y, pl.z)
    AddPointToGpsMultiRoute(x, y, z)
    SetGpsMultiRouteRender(true)
end

function GpsApi:GpsToEntity(entity)
    GpsToEntity = true
    local entityinitcoords = GetEntityCoords(entity)
    GpsApi:SetGps(entityinitcoords.x, entityinitcoords.y, entityinitcoords.z)
    while GpsToEntity do
        Citizen.Wait(200)
        local entitycoords = GetEntityCoords(entity)
        if GetDistanceBetweenCoords(entityinitcoords.x, entityinitcoords.y, entityinitcoords.z, entitycoords.x, entitycoords.y, entitycoords.z, false) > 10 then
            entityinitcoords = entitycoords
            AddPointToGpsMultiRoute(entitycoords.x, entitycoords.y, entitycoords.z)
            SetGpsMultiRouteRender(true)
        end
    end
end

function GpsApi:RemoveGps()
    GpsToEntity = false
    ClearGpsMultiRoute()
end