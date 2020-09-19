SurveyZone = {}

SurveyZone.name           = "SurveyZone"
SurveyZone.savedVariables = nil
SurveyZone.ready          = false
SurveyZone.LAM            = LibAddonMenu2

--[[
-- Module initialiser
-- Intiialise savedVariables and GUI
--]]
function SurveyZone:Initialise()
    SurveyZone.savedVariables = ZO_SavedVars:NewAccountWide("SurveyZoneSavedVariables", 1, nil, {})

    if SurveyZone.savedVariables.gui == nil then
        SurveyZone.savedVariables.gui = {}
    end
    if SurveyZone.savedVariables.sort == nil then
        SurveyZone.savedVariables.sort = {}
    end

    SurveyZone.Settings:init()
    SurveyZone.GUI:init()
    SurveyZone.ItemSort:init()
    SurveyZone.ready = true
end
