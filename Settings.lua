SurveyZoneList.Settings = {}

-- @var string The name of the setting panel
SurveyZoneList.Settings.panelName = "SurveyZoneListSettingsPanel"

--[[
-- Initialise the Setting interface
--]]
function SurveyZoneList.Settings:init()
    local panelData = {
        type   = "panel",
        name   = SurveyZoneList.name,
        author = "bulton-fr",
    }

    SurveyZoneList.LAM:RegisterAddonPanel(self.panelName, panelData)
    self:build()
end

--[[
-- Build the settings interface
--]]
function SurveyZoneList.Settings:build()
    local optionsData = {
        self:buildGUILocked(),
        self:buildDisplayedWithWorldMap(),
        self:buildCurrentZoneFirst(),
        self:buildDisplayItemText(),
        {
            type = "header",
            name = GetString(SI_SURVEYZONELIST_SETTINGS_SORT_TITLE)
        },
        {
            type = "description",
            text = GetString(SI_SURVEYZONELIST_SETTINGS_SORT_DESC)
        },
        self:buildSort(1),
        self:buildSort(2),
        self:buildSort(3)
    }

    SurveyZoneList.LAM:RegisterOptionControls(self.panelName, optionsData)
end

--[[
-- Return info to build the setting panel for "lock ui"
--
-- @return table
--]]
function SurveyZoneList.Settings:buildGUILocked()
    return {
        type    = "checkbox",
        name    = GetString(SI_SURVEYZONELIST_SETTINGS_LOCKUI),
        getFunc = function()
            return SurveyZoneList.GUI:isLocked()
        end,
        setFunc = function(value)
            SurveyZoneList.GUI:defineLocked(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for "display with world map"
--
-- @return table
--]]
function SurveyZoneList.Settings:buildDisplayedWithWorldMap()
    return {
        type    = "checkbox",
        name    = GetString(SI_SURVEYZONELIST_SETTINGS_DISPLAYED_WITH_WM),
        getFunc = function()
            return SurveyZoneList.GUI:isDisplayWithWMap()
        end,
        setFunc = function(value)
            SurveyZoneList.GUI:defineDisplayWithWMap(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for "keep the current zone first"
--
-- @return table
--]]
function SurveyZoneList.Settings:buildCurrentZoneFirst()
    return {
        type    = "checkbox",
        name    = GetString(SI_SURVEYZONELIST_SETTINGS_CURRENT_ZONE_FIRST),
        getFunc = function()
            return SurveyZoneList.ItemSort:isKeepCurrentZoneFirst()
        end,
        setFunc = function(value)
            SurveyZoneList.ItemSort:defineKeepCurrentZoneFirst(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for "item text format"
--
-- @return table
--]]
function SurveyZoneList.Settings:buildDisplayItemText()
    return {
        type        = "editbox",
        name        = GetString(SI_SURVEYZONELIST_SETTINGS_ITEM_TEXT_FORMAT),
        isMultiline = false,
        isExtraWide = false,
        tooltip     = GetString(SI_SURVEYZONELIST_SETTINGS_ITEM_TEXT_FORMAT_DESC),
        getFunc     = function()
            return SurveyZoneList.GUI:obtainDisplayItemText()
        end,
        setFunc     = function(value)
            return SurveyZoneList.GUI:defineDisplayItemText(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for a "sort" order
--
-- @param integer pos The sort order
--
-- @return table
--]]
function SurveyZoneList.Settings:buildSort(pos)
    return {
        type          = "dropdown",
        name          = zo_strformat("#<<1>>", pos),
        choices       = {
            GetString(SI_SURVEYZONELIST_SETTINGS_SORT_ZONE_NAME),
            GetString(SI_SURVEYZONELIST_SETTINGS_SORT_NB_UNIQUE),
            GetString(SI_SURVEYZONELIST_SETTINGS_SORT_NB_SURVEY),
        },
        choicesValues = {
            SurveyZoneList.ItemSort.ORDER_TYPE_ZONE_NAME,
            SurveyZoneList.ItemSort.ORDER_TYPE_NB_UNIQUE,
            SurveyZoneList.ItemSort.ORDER_TYPE_NB_SURVEY
        },
        getFunc       = function()
            return SurveyZoneList.ItemSort:obtainOrder()[pos]
        end,
        setFunc       = function(sortOrder)
            SurveyZoneList.ItemSort:defineOrder(pos, sortOrder)
        end
    }
end
