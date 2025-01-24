local UtilAPI = {}

UtilAPI.General = GeneralAPI
UtilAPI.Files = FilesAPI
UtilAPI.Print = PrintAPI
UtilAPI.DataView = DataView

AddEventHandler('getUtils', function(cb)
    cb(UtilAPI)
end)

exports('GetUtils', function()
    return UtilAPI
end)