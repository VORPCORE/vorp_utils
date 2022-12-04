AddEventHandler('getUtils', function(cb)
    local UtilAPI = {}

    UtilAPI.Prompts = PromptsAPI
    UtilAPI.Blips = BlipAPI
    UtilAPI.Peds = PedAPI

    cb(UtilAPI)
end)
