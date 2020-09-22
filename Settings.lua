SurveyZone.Settings = {}

-- @var string The name of the setting panel
SurveyZone.Settings.panelName = "SurveyZoneSettingsPanel"

--[[
-- Initialise the Setting interface
--]]
function SurveyZone.Settings:init()
    local panelData = {
        type   = "panel",
        name   = "Survey Zone",
        author = "bulton-fr",
    }

    SurveyZone.LAM:RegisterAddonPanel(self.panelName, panelData)
    self:build()
end

--[[
-- Build the settings interface
--]]
function SurveyZone.Settings:build()
    local optionsData = {
        self:buildGUILocked(),
        self:buildDisplayedWithWorldMap(),
        self:buildCurrentZoneFirst(),
        self:buildDisplayItemText(),
        {
            type = "header",
            name = "Sort"
        },
        self:buildSort(1),
        self:buildSort(2),
        self:buildSort(3)
    }

    SurveyZone.LAM:RegisterOptionControls(self.panelName, optionsData)
end

--[[
-- Return info to build the setting panel for "lock ui"
--
-- @return table
--]]
function SurveyZone.Settings:buildGUILocked()
    return {
        type    = "checkbox",
        name    = GetString(SI_SURVEYZONE_SETTINGS_LOCKUI),
        getFunc = function()
            return SurveyZone.GUI:isLocked()
        end,
        setFunc = function(value)
            SurveyZone.GUI:defineLocked(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for "display with world map"
--
-- @return table
--]]
function SurveyZone.Settings:buildDisplayedWithWorldMap()
    return {
        type    = "checkbox",
        name    = GetString(SI_SURVEYZONE_SETTINGS_DISPLAYED_WITH_WM),
        getFunc = function()
            return SurveyZone.GUI:isDisplayWithWMap()
        end,
        setFunc = function(value)
            SurveyZone.GUI:defineDisplayWithWMap(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for "keep the current zone first"
--
-- @return table
--]]
function SurveyZone.Settings:buildCurrentZoneFirst()
    return {
        type    = "checkbox",
        name    = GetString(SI_SURVEYZONE_SETTINGS_CURRENT_ZONE_FIRST),
        getFunc = function()
            return SurveyZone.ItemSort:isKeepCurrentZoneFirst()
        end,
        setFunc = function(value)
            SurveyZone.ItemSort:defineKeepCurrentZoneFirst(value)
        end,
    }
end

--[[
-- Return info to build the setting panel for "item text format"
--
-- @return table
--]]
function SurveyZone.Settings:buildDisplayItemText()
    return {
        type        = "editbox",
        name        = GetString(SI_SURVEYZONE_SETTINGS_ITEM_TEXT_FORMAT),
        isMultiline = false,
        isExtraWide = false,
        tooltip     = GetString(SI_SURVEYZONE_SETTINGS_ITEM_TEXT_FORMAT_DESC),
        getFunc     = function()
            return SurveyZone.GUI:obtainDisplayItemText()
        end,
        setFunc     = function(value)
            return SurveyZone.GUI:defineDisplayItemText(value)
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
function SurveyZone.Settings:buildSort(pos)
    return {
        type          = "dropdown",
        name          = zo_strformat("sort #<<1>>", pos),
        choices       = {
            GetString(SI_SURVEYZONE_SETTINGS_SORT_ZONE_NAME),
            GetString(SI_SURVEYZONE_SETTINGS_SORT_NB_UNIQUE),
            GetString(SI_SURVEYZONE_SETTINGS_SORT_NB_SURVEY),
        },
        choicesValues = {
            SurveyZone.ItemSort.ORDER_TYPE_ZONE_NAME,
            SurveyZone.ItemSort.ORDER_TYPE_NB_UNIQUE,
            SurveyZone.ItemSort.ORDER_TYPE_NB_SURVEY
        },
        getFunc       = function()
            return SurveyZone.ItemSort:obtainOrder()[pos]
        end,
        setFunc       = function(sortOrder)
            SurveyZone.ItemSort:defineOrder(pos, sortOrder)
        end
    }
end
