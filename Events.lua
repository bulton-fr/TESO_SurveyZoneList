SurveyZone.Events = {}

--[[
-- Called when the addon is loaded
--
-- @param number eventCode
-- @param string addonName name of the loaded addon
--]]
function SurveyZone.Events.onLoaded(eventCode, addOnName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addOnName == SurveyZone.name then
        SurveyZone:Initialise()
    end
end

--[[
-- Called when the user's interface loads and their character is activated after logging in or performing a reload of the UI.
-- This happens after <EVENT_ADD_ON_LOADED>, so the UI and all addons should be initialised already.
--
-- @param integer eventCode
-- @param boolean initial : true if the user just logged on, false with a UI reload (for example)
--]]
function SurveyZone.Events.onLoadScreen(eventCode, initial)
    if SurveyZone.ready == false then
        return
    end

    SurveyZone.Collect:search()
    SurveyZone.ItemSort:updateZone()
    SurveyZone.GUI:refreshAll()
end

function SurveyZone.Events.onMoveItem(eventCode, bagId, slotIdx, bNewItem, itemSoundCategory, inventoryUpdateReason, qt)
    local itemLink = GetItemLink(bagId, slotIdx)
    local itemZoneName = ""

    if itemLink == "" then
        itemInfo = SurveyZone.Collect:findForSlotIdx(slotIdx)

        if itemInfo ~= nil then
            SurveyZone.Collect:removeItemFromList(itemInfo, slotIdx)
            SurveyZone.GUI:refreshAll()
        end
    else
        itemZoneName = SurveyZone.Collect:readItem(slotIdx)

        if itemZoneName ~= nil then
            SurveyZone.Collect:updateItemToList(itemZoneName, slotIdx)
            SurveyZone.GUI:refreshAll()
        end
    end
end

function SurveyZone.Events.onGuiMoveStop()
    SurveyZone.GUI:savePosition()
end

function SurveyZone.Events.keybindingsToggle()
    SurveyZone.GUI:toggle()
end
