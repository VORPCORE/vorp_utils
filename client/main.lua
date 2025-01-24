local UtilAPI = {}

UtilAPI.General = GeneralAPI
UtilAPI.Prompts = PromptsAPI
UtilAPI.Blips = BlipAPI
UtilAPI.Peds = PedAPI
UtilAPI.DataView = DataView
UtilAPI.Print = PrintAPI
UtilAPI.Objects = ObjectAPI
UtilAPI.Events = EventsAPI
UtilAPI.Destruct = DestructionAPI
UtilAPI.Render = RenderAPI
UtilAPI.Gps = GpsApi
UtilAPI.Shared = Shared

AddEventHandler('getUtils', function(cb)
    cb(UtilAPI)
end)

exports('GetUtils', function()
    return UtilAPI
end)
