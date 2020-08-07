SurveyZone.Settings = {}

SurveyZone.Settings.panelName = "SurveyZoneSettingsPanel"

function SurveyZone.Settings:init()
    local panelData = {
        type   = "panel",
        name   = "Survey Zone",
        author = "bulton-fr",
    }

    SurveyZone.LAM:RegisterAddonPanel(self.panelName, panelData)
    self:build()
end

function SurveyZone.Settings:build()
    local optionsData = {
        self:buildGUILocked(),
        self:buildDisplayedWithWorldMap(),
        self:buildCurrentZoneFirst(),
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

function SurveyZone.Settings:buildGUILocked()
    return {
        type    = "checkbox",
        name    = "Lock UI",
        getFunc = function()
            return SurveyZone.GUI:isLocked()
        end,
        setFunc = function(value)
            SurveyZone.GUI:defineLocked(value)
        end,
    }
end

function SurveyZone.Settings:buildDisplayedWithWorldMap()
    return {
        type    = "checkbox",
        name    = "Displayed with the world map",
        getFunc = function()
            return SurveyZone.GUI:isDisplayWithWMap()
        end,
        setFunc = function(value)
            SurveyZone.GUI:defineDisplayWithWMap(value)
        end,
    }
end

function SurveyZone.Settings:buildCurrentZoneFirst()
    return {
        type    = "checkbox",
        name    = "Keep the current zone first",
        getFunc = function()
            return SurveyZone.ItemSort:isKeepCurrentZoneFirst()
        end,
        setFunc = function(value)
            SurveyZone.ItemSort:defineKeepCurrentZoneFirst(value)
        end,
    }
end

function SurveyZone.Settings:buildSort(pos)
    return {
        type          = "dropdown",
        name          = zo_strformat("sort #<<1>>", pos),
        choices       = {"zone name", "number of unique survey", "total number of survey"},
        choicesValues = {"zoneName", "nbUnique", "nbSurvey"},
        getFunc       = function()
            return SurveyZone.ItemSort:obtainOrder()[pos]
        end,
        setFunc       = function(sortOrder)
            SurveyZone.ItemSort:defineOrder(pos, sortOrder)
        end
    }
end
