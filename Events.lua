SurveyZoneList.Events = {}

--[[
-- Called when the addon is loaded
--
-- @param number eventCode
-- @param string addonName name of the loaded addon
--]]
function SurveyZoneList.Events.onLoaded(eventCode, addOnName)
    -- The event fires each time *any* addon loads - but we only care about when our own addon loads.
    if addOnName == SurveyZoneList.dirName then
        SurveyZoneList:Initialise()
    end
end

--[[
-- Called after each load screen.
-- When it's the character's first load after login (initial = true), it's always called after <EVENT_ADD_ON_LOADED>
--
-- @param integer eventCode
-- @param boolean initial : true if the user just logged on, false with a UI reload (for example)
--]]
function SurveyZoneList.Events.onLoadScreen(eventCode, initial)
    if SurveyZoneList.ready == false then
        return
    end

    SurveyZoneList.Collect:search()
    SurveyZoneList.ItemSort:updateCurrentZone()
    SurveyZoneList.GUI:refreshAll()
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
function SurveyZoneList.Events.onMoveItem(eventCode, bagId, slotIdx, bNewItem, itemSoundCategory, inventoryUpdateReason, qt)
    local itemLink = GetItemLink(bagId, slotIdx)
    local itemZoneName = ""

    if itemLink == "" then
        itemInfo = SurveyZoneList.Collect:findForSlotIdx(slotIdx)

        if itemInfo ~= nil then
            SurveyZoneList.Collect:removeItemFromList(itemInfo, slotIdx)
            SurveyZoneList.GUI:refreshAll()
        end
    else
        itemZoneName = SurveyZoneList.Collect:readItem(slotIdx)

        if itemZoneName ~= nil then
            SurveyZoneList.Collect:updateItemToList(itemZoneName, slotIdx)
            SurveyZoneList.GUI:refreshAll()
        end
    end
end

--[[
-- Called when the user stop to move the GUI
--]]
function SurveyZoneList.Events.onGuiMoveStop()
    SurveyZoneList.GUI:savePosition()
end

--[[
-- Called when the user trigger the keybinds for "toggle GUI"
--]]
function SurveyZoneList.Events.keybindingsToggle()
    SurveyZoneList.GUI:toggle()
end

--[[
-- PostHook on TryHandlingInteraction, called when something can be interacted with it
--]]
function SurveyZoneList.Events.reticleTryHandlingInteraction(interactionPossible, currentFrameTimeSeconds)
    return SurveyZoneList.Interaction:updateInteractContext(interactionPossible)
end

--[[
-- Called when the loot window is closed.
-- With auto-loot enabled, call when all the loot has been get
--]]
function SurveyZoneList.Events.onLootClosed(eventCode)
    --d("Loot cloded")
    SurveyZoneList.Recolt:lootClosed()
end

--[[
-- Called when a bank is opened
--]]
function SurveyZoneList.Events.onOpenBank(eventCode, bankBag)
    SurveyZoneList.Alerts:setInBank(true)
end

--[[
-- Called when a bank is closed
--]]
function SurveyZoneList.Events.onCloseBank(eventCode, bankBag)
    SurveyZoneList.Alerts:setInBank(false)
end
