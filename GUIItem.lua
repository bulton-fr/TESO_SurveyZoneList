SurveyZone.GUIItem = {}
SurveyZone.GUIItem.__index = SurveyZone.GUIItem

-- @var static integer uiIdx The current uiItem index which represents
-- the number of item already created
SurveyZone.GUIItem.uiIdx = 0

--[[
-- Instanciate a new GUIItem "object"
--
-- @return GUIItem
--]]
function SurveyZone.GUIItem:new()
    local guiItem = {
        ui       = nil, -- (table) The item's ui BACKDROP
        uiLabel  = nil, -- (table) The item's ui label
        parentUI = SurveyZone.GUI.ui, -- (table) The TopLevelWindow in GUI table
        used     = false, -- (bool) If the current item is used or not (cannot be destroyed)
        zoneName = nil, -- (string) The zone name to display
        zoneInfo = nil -- (table) Info about the zone, value in SurveyZone.Collect.orderedList 
    }

    setmetatable(guiItem, self)
    self.uiIdx = self.uiIdx + 1

    guiItem:initUI()
    return guiItem
end

--[[
-- Create ui elements used by the item
--]]
function SurveyZone.GUIItem:initUI()
    local WindowManager = GetWindowManager()
    local uiName        = "SurveyZoneUIItem"..self.uiIdx
    local uiLabelName   = uiName.."_Label"

    self.ui = WindowManager:CreateControl(uiName, self.parentUI, CT_BACKDROP)
    self.ui:SetDimensions(self.parentUI:GetWidth(), 30)
	self.ui:SetCenterColor(0, 0, 0, .25)
	self.ui:SetEdgeColor(0, 0, 0, .25)
    self.ui:SetEdgeTexture(nil, 1, 1, 0, 0)
    
    self.uiLabel = WindowManager:CreateControl(uiLabelName, self.ui, CT_LABEL)
    self.uiLabel:SetAnchor(TOPLEFT, self.ui, TOPLEFT, 5, 3)
    self.uiLabel:SetFont("ZoFontGame")
end

--[[
-- To display or not the gui
--
-- @param bool isHidden To hide (if true) the item's ui or not (if false)
--]]
function SurveyZone.GUIItem:display(isHidden)
    if isHidden == true then
        self:hide()
    else
        self:show()
    end
end

--[[
-- To hide the item's ui
--]]
function SurveyZone.GUIItem:hide()
    self.ui:SetHidden(true)
end

--[[
-- To show the item's ui
--]]
function SurveyZone.GUIItem:show()
    self.ui:SetHidden(false)
end

--[[
-- Define the item's ui position from the index
--
-- @param integer index The index (position in the list) defined for the item
--]]
function SurveyZone.GUIItem:definePosition(index)
    self.ui:SetAnchor(TOPLEFT, self.parentUI, TOPLEFT, 0, index*30)
end

--[[
-- Update the text to display
--]]
function SurveyZone.GUIItem:updateText()
    self.uiLabel:SetText(zo_strformat(
        SurveyZone.GUI:obtainDisplayItemText(),
        self.zoneName,
        self.zoneInfo.nbUnique,
        self.zoneInfo.nbSurvey
    ))
end
