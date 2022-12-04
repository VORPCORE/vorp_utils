BlipAPI = {}

function BlipAPI:SetBlip(name, sprite, scale, x, y, z)
    local BlipClass = {}

    BlipClass.blip =  Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, vector3(x, y, z))
    SetBlipSprite(BlipClass.blip, GetHashKey(sprite), true)
    SetBlipScale(BlipClass.blip, scale)
    Citizen.InvokeNative(0x9CB1A1623062F402, BlipClass.blip, name)

    function BlipClass:Remove()
        RemoveBlip(self.blip)
    end


    return BlipClass.blip
end

function BlipAPI:RemoveBlip(blip)
    RemoveBlip(blip)
end