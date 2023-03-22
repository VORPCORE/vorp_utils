EventsAPI = {}
EventListeners = {}
EventListenerCount = 0
EventsDevMode = {
	false,
	false
}

local function startGlobalEventListeners(eventgroup)
	-- Inspired by https://github.com/femga/rdr3_discoveries/tree/master/AI/EVENTS
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
            local eventmode = eventgroup + 1
			if EventListenerCount > 0 or EventsDevMode[eventmode] == true then
				local size = GetNumberOfEvents(eventgroup)
				if size > 0 then
					for i = 0, size - 1 do
						local eventAtIndex = GetEventAtIndex(eventgroup, i)
						if EVENTS[eventAtIndex] then
							local eventDataStruct = DataView.ArrayBuffer(8*EVENTS[eventAtIndex].datasize) --memory allocation


							for p = 0,EVENTS[eventAtIndex].datasize - 1, 1 do
                                -- TODO: When new type data is added, code here will need to change to allow other types than int.
                                eventDataStruct:SetInt32(8 * p, 0) --memory pre-allocation
							end

							local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, eventgroup, i, eventDataStruct:Buffer(),
								EVENTS[eventAtIndex].datasize) -- GET_EVENT_DATA

							local datafields = {}
							if is_data_exists then
								for t = 0,EVENTS[eventAtIndex].datasize - 1, 1 do
                                    -- TODO: When new type data is added, code here will need to change to allow other types than int.
									datafields[#datafields + 1] = eventDataStruct:GetInt32(8 * t)
								end
							end

                            if EventsDevMode[eventmode] == true then
								print("EVENT TRIGGERED:", EVENTS[eventAtIndex].name, DumpTable(datafields))
							end
          
							if EventListeners[eventAtIndex] then
								for index, event in ipairs(EventListeners[eventAtIndex]) do
									event.trigger(datafields)
								end
							end
						end
					end
				end
			end
		end
	end)
end

function EventsAPI:RegisterEventListener(eventname, cb)
	local key = GetHashKey(eventname)
	local postition = 1
	if EventListeners[key] then
		postition = #EventListeners[key] + 1
	else
		EventListeners[key] = {}
		postition = 1
	end

	EventListeners[key][postition] = {
		eventname = eventname,
		trigger = cb
	}
    EventListenerCount = EventListenerCount + 1

	return { key, postition }
end

-- remove event listeners is best practice for memory management. however, this only applies if you are creating temporary listeners.
function EventsAPI:RenoveEventListener(listener)
	if EventListeners[listener[1]] and EventListeners[listener[1]][listener[2]] then
		EventListeners[listener[1]][listener[2]] = nil
        EventListenerCount = EventListenerCount - 1
	end

	if #EventListeners[listener[1]] < 1 then --clear memory if there are not registered listeners for this event
		EventListeners[listener[1]] = nil
	end
end

function EventsAPI:DevMode(state, type)
	if type == 'entities' then
		EventsDevMode[0] = state
	elseif type == 'network' then
		EventsDevMode[1] = state
	else
		EventsDevMode[0] = state
		EventsDevMode[1] = state
	end
end

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
	startGlobalEventListeners(0) -- 0 = SCRIPT_EVENT_QUEUE_AI (CEventGroupScriptAI)
	startGlobalEventListeners(1) -- 1 = SCRIPT_EVENT_QUEUE_NETWORK (CEventGroupScriptNetwork)
end)



EventsAPI:RegisterEventListener('EVENT_ENTITY_DAMAGED', function (args)
    print(DumpTable(args))
end)