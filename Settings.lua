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

function SurveyZone.Settings:buildDisplayItemText()
    return {
        type        = "editbox",
        name        = "Text format used for each zone",
        isMultiline = false,
        isExtraWide = false,
        tooltip     = "You can use the following placeholders in the text format, which will be replaced with the value information :\n<<1>> Zone's name\n<<2>> number of unique survey in the zone\n<<3>>total number of survey in the zone\n\nDefault value is <<1>> : <<2>> - <<3>>",
        getFunc     = function()
            return SurveyZone.GUI:obtainDisplayItemText()
        end,
        setFunc     = function(value)
            return SurveyZone.GUI:defineDisplayItemText(value)
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
