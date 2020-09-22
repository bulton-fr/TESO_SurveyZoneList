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
-- Called after each load screen.
-- When it's the character's first load after login (initial = true), it's always called after <EVENT_ADD_ON_LOADED>
--
-- @param integer eventCode
-- @param boolean initial : true if the user just logged on, false with a UI reload (for example)
--]]
function SurveyZone.Events.onLoadScreen(eventCode, initial)
    if SurveyZone.ready == false then
        return
    end

    SurveyZone.Collect:search()
    SurveyZone.ItemSort:updateCurrentZone()
    SurveyZone.GUI:refreshAll()
end

--[[
-- Called when a item move in the character bag (filter on event)
--
-- @link https://wiki.esoui.com/EVENT_INVENTORY_SINGLE_SLOT_UPDATE
--
-- @param integer eventCode
-- @param integer bagId The bag id (always character bag because filter on event)
-- @param integer slotIdx The item slot index
-- @param bool bNewItem
-- @param integer itemSoundCategory
-- @param integer inventoryUpdateReason
-- @param integer qt
--]]
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

--[[
-- Called when the user stop to move the GUI
--]]
function SurveyZone.Events.onGuiMoveStop()
    SurveyZone.GUI:savePosition()
end

--[[
-- Called when the user trigger the keybinds for "toggle GUI"
--]]
function SurveyZone.Events.keybindingsToggle()
    SurveyZone.GUI:toggle()
end
