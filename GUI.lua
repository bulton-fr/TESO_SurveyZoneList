SurveyZone.GUI = {}

--[[
-- @var table The ui TolLevelWindow
--]]
SurveyZone.GUI.ui        = nil

--[[
-- @var table The ui backdrop
--]]
SurveyZone.GUI.backUI    = nil

--[[
-- @var table The first item of the list which display list title
--]]
SurveyZone.GUI.title     = nil

--[[
-- @var table The fragment used to link the ui to a scene
--]]
SurveyZone.GUI.fragment  = nil

--[[
-- @var table A list of all GUIItems created. We cannot remove an ui item from
-- memory, so we keep it all created items here to reuse it when the list is refreshed.
--]]
SurveyZone.GUI.itemList  = {}

--[[
-- @var table All saved variables dedicated to the gui.
--]]
SurveyZone.GUI.savedVars = nil

--[[
-- Initialise the GUI
--]]
function SurveyZone.GUI:init()
    self.savedVars = SurveyZone.savedVariables.gui

    self:initSavedVarsValues()
    self:build()
    self:defineFragment()
end

--[[
-- Initialise with a default value all saved variables dedicated to the gui
--]]
function SurveyZone.GUI:initSavedVarsValues()
    if self.savedVars.position == nil then
        self.savedVars.position = {}
    end
    if self.savedVars.position.top == nil then
        self.savedVars.position.top = 0
    end
    if self.savedVars.position.left == nil then
        self.savedVars.position.left = 0
    end
    
    if self.savedVars.hidden == nil then
        self.savedVars.hidden = false
    end
    
    if self.savedVars.locked == nil then
        self.savedVars.locked = false
    end
    
    if self.savedVars.displayWithWMap == nil then
        self.savedVars.displayWithWMap = false
    end

    if self.savedVars.displayItemText == nil then
        self.savedVars.displayItemText = "<<1>> : <<2>> - <<3>>"
    end
end

--[[
-- Build the GUI
--]]
function SurveyZone.GUI:build()
    local WindowManager = GetWindowManager()

    self.ui = WindowManager:CreateTopLevelWindow("SurveyZoneUI")
	self.ui:SetClampedToScreen(true)
	self.ui:ClearAnchors()
    self.ui:SetHidden(self.savedVars.hidden)
    self.ui:SetDimensions(300, 30)
	self.ui:SetHandler("OnMoveStop", function(...) SurveyZone.Events.onGuiMoveStop() end)
    self:restorePosition()
    self:defineLocked(self.savedVars.locked)

	self.backUI = WindowManager:CreateControl("SurveyZoneUIBack", self.ui, CT_BACKDROP)
    self.backUI:SetAnchor(TOPLEFT, self.ui, TOPLEFT, 0, 0)
    self.backUI:SetDimensions(self.ui:GetWidth(), self.ui:GetHeight())
    self.backUI:SetHidden(self.savedVars.hidden)
	self.backUI:SetCenterColor(0, 0, 0, .25)
	self.backUI:SetEdgeColor(0, 0, 0, .25)
	self.backUI:SetEdgeTexture(nil, 1, 1, 0, 0)

	self.title = WindowManager:CreateControl("SurveyZoneUITitle", self.ui, CT_BACKDROP)
    self.title:SetAnchor(TOPLEFT, self.ui, TOPLEFT, 0, 0)
    self.title:SetDimensions(self.ui:GetWidth(), 30)
    self.title:SetHidden(self.savedVars.hidden)
	self.title:SetCenterColor(0, 0, 0, .25)
	self.title:SetEdgeColor(0, 0, 0, .25)
	self.title:SetEdgeTexture(nil, 1, 1, 0, 0)

    local titleLabel = WindowManager:CreateControl("titleLabel", self.title, CT_LABEL)
    titleLabel:SetAnchor(TOPLEFT, self.title, TOPLEFT, 5, 3)
    titleLabel:SetText(GetString(SI_SURVEYZONE_LIST_TITLE))
    titleLabel:SetFont("ZoFontGame")
end

--[[
-- Restore the GUI's position from saved variables
--]]
function SurveyZone.GUI:restorePosition()
    self.ui:ClearAnchors()

    local left = self.savedVars.position.left
    local top  = self.savedVars.position.top

    self.ui:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

--[[
-- Return info about if the GUI position is locked or not
--
-- @return bool
--]]
function SurveyZone.GUI:isLocked()
    return self.savedVars.locked
end

--[[
-- Define if the GUI is locked or not.
--
-- @param bool value
--]]
function SurveyZone.GUI:defineLocked(value)
    self.savedVars.locked = value

	self.ui:SetMouseEnabled(not value)
	self.ui:SetMovable(not value)
end

--[[
-- Return info about if the GUI should be displayed when the world map is open or not
--
-- @return bool
--]]
function SurveyZone.GUI:isDisplayWithWMap()
    return self.savedVars.displayWithWMap
end

--[[
-- Define if the GUI should be displayed when the world map is open or not
--
-- @param bool value
--]]
function SurveyZone.GUI:defineDisplayWithWMap(value)
    self.savedVars.displayWithWMap = value

	if value == true then
        SCENE_MANAGER:GetScene("worldMap"):AddFragment(self.fragment)
    else
        SCENE_MANAGER:GetScene("worldMap"):RemoveFragment(self.fragment)
    end
end

--[[
-- Return the text format used for each item
--
-- @return string
--]]
function SurveyZone.GUI:obtainDisplayItemText()
    return self.savedVars.displayItemText
end

--[[
-- Define a new text format for items
--
-- @param string value
--]]
function SurveyZone.GUI:defineDisplayItemText(value)
    self.savedVars.displayItemText = value
    self:refreshAll()
end

--[[
-- Save the GUI's position to savedVariables
--]]
function SurveyZone.GUI:savePosition()
    self.savedVars.position.left = self.ui:GetLeft()
    self.savedVars.position.top  = self.ui:GetTop()
end

--[[
-- Define GUI as a fragment linked to scenes.
-- With that, the GUI is hidden when we open a menu (like inventory or map)
--]]
function SurveyZone.GUI:defineFragment()
    self.fragment = ZO_SimpleSceneFragment:New(self.ui)

    SCENE_MANAGER:GetScene("hud"):AddFragment(self.fragment)
    SCENE_MANAGER:GetScene("hudui"):AddFragment(self.fragment)
end

--[[
-- Show or hide the GUI
-- If the GUI is currently hidden, it will be shown.
-- If the GUI is currently shown, it will be hidden.
--]]
function SurveyZone.GUI:toggle()
    self.savedVars.hidden = not self.savedVars.hidden
    self.ui:SetHidden(self.savedVars.hidden)
    self.backUI:SetHidden(self.savedVars.hidden)
    self.title:SetHidden(self.savedVars.hidden)

    if self.savedVars.hidden == true then
        self:hideAllItems()
    else
        self:showAllItems()
    end
end

--[[
-- Refresh all items displayed
--]]
function SurveyZone.GUI:refreshAll()
    self:resetAllItems()

    local idx    = 1
    local uiItem = nil

    SurveyZone.ItemSort:exec()

    for listIdx, zoneInfo in pairs(SurveyZone.Collect.orderedList) do
        local zoneName = zoneInfo.name

        if zoneInfo.nbUnique > 0 then
            if self.itemList[idx] == nil then
                self.itemList[idx] = SurveyZone.GUIItem:new()
            end

            guiItem = self.itemList[idx]
            guiItem.used     = true
            guiItem.zoneName = zoneName
            guiItem.zoneInfo = zoneInfo
            guiItem:updateText()
            guiItem:display(self.savedVars.hidden)
            
            guiItem:definePosition(idx)
            idx = idx + 1
        end
    end

    self.ui:SetDimensions(self.ui:GetWidth(), idx*30)
    self.backUI:SetDimensions(self.ui:GetWidth(), self.ui:GetHeight())
end

--[[
-- Reset each item values an hide it
--]]
function SurveyZone.GUI:resetAllItems()
    for idx, guiItem in pairs(self.itemList) do
        if guiItem ~= nil then
            guiItem.used     = false
            guiItem.zoneName = nil
            guiItem.zoneInfo = nil
            guiItem:hide()
        end
    end
end

--[[
-- Hide all items
--]]
function SurveyZone.GUI:hideAllItems()
    for idx, guiItem in pairs(self.itemList) do
        if guiItem ~= nil then
            if guiItem.used == true then
                guiItem:hide()
            end
        end
    end
end

--[[
-- Show all used items
--]]
function SurveyZone.GUI:showAllItems()
    for idx, guiItem in pairs(self.itemList) do
        if guiItem ~= nil then
            if guiItem.used == true then
                guiItem:show()
            end
        end
    end
end
