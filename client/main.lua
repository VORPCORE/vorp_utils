AddEventHandler('getUtils', function(cb)
    local UtilAPI = {}

    UtilAPI.General = GeneralAPI
    UtilAPI.Prompts = PromptsAPI
    UtilAPI.Blips = BlipAPI
    UtilAPI.Peds = PedAPI
    UtilAPI.DataView = DataView
    UtilAPI.Print = PrintAPI
    UtilAPI.Objects = ObjectAPI

    cb(UtilAPI)
end)
