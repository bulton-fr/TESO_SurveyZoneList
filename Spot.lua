SurveyZoneList.Spot = {}

SurveyZoneList.Spot.WHEN_START = "BEFORE"
SurveyZoneList.Spot.WHEN_END = "END"

--[[
-- @var table All saved variables dedicated to the spot system.
--]]
SurveyZoneList.Spot.savedVars = nil

SurveyZoneList.Spot.inBag = false
SurveyZoneList.Spot.inBank = false
SurveyZoneList.Spot.spotQuantity = 0
SurveyZoneList.Spot.zoneQuantity = 0

function SurveyZoneList.Spot:init()
    self.savedVars = SurveyZoneList.savedVariables.spot

    self:initSavedVarsValues()
    self:initOpenBagEvent()
end

--[[
-- Initialise with a default value all saved variables dedicated to the spot system
--]]
function SurveyZoneList.Spot:initSavedVarsValues()
    if self.savedVars.sound == nil then
        self.savedVars.sound = {}
    end
    if self.savedVars.sound.use == nil then
        self.savedVars.sound.use = false
    end
    if self.savedVars.sound.id == nil then
        self.savedVars.sound.id = "NONE"
    end
    
    if self.savedVars.alert == nil then
        self.savedVars.alert = false
    end
    
    if self.savedVars.when == nil then
        self.savedVars.when = self.WHEN_START
    end
end

function SurveyZoneList.Spot:initOpenBagEvent()
    local inventoryScene = SCENE_MANAGER:GetScene("inventory")
    inventoryScene:RegisterCallback("StateChange", function(oldState, newState)
        SurveyZoneList.Spot.inBag = newState
    end)
end

function SurveyZoneList.Spot:setInBank(newState)
    self.inBank = newState
end

function SurveyZoneList.Spot:getSoundUse()
    return self.savedVars.sound.use
end

function SurveyZoneList.Spot:setSoundUse(useSound)
    self.savedVars.sound.use = useSound
end

function SurveyZoneList.Spot:getSoundId()
    return self.savedVars.sound.id
end

function SurveyZoneList.Spot:setSoundId(idSound)
    self.savedVars.sound.id = idSound
end

function SurveyZoneList.Spot:getAlert()
    return self.savedVars.alert
end

function SurveyZoneList.Spot:setAlert(useAlert)
    self.savedVars.alert = useAlert
end

function SurveyZoneList.Spot:getWhen()
    return self.savedVars.when
end

function SurveyZoneList.Spot:setWhen(when)
    self.savedVars.when = when
end

function SurveyZoneList.Spot:uiOpen()
    return self.inBag or self.inBank
end

function SurveyZoneList.Spot:updateQuantity(spotQuantity, zoneQuantity)
    self.spotQuantity = spotQuantity
    self.zoneQuantity = zoneQuantity

    if self:uiOpen() == false then
        self:updateGUI()

        if spotQuantity == 0 then
            self:execAlerts(self.WHEN_START)
        end
    end
end

function SurveyZoneList.Spot:execAlerts(when)
    if when ~= self.savedVars.when then
        return
    end

    self:displayAnnounce()
    self:playSong()
end

function SurveyZoneList.Spot:updateGUI()
    SurveyZoneList.GUI:updateSpotInfo()
end

function SurveyZoneList.Spot:displayAnnounce()
    if self.savedVars.alert == false then
        return
    end

    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.NONE)
	messageParams:SetText(GetString(SI_SURVEYZONELIST_SPOT_NOTIFY_LASTSPOT))
	messageParams:SetLifespanMS(5000)
	CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
end

function SurveyZoneList.Spot:playSong()
    if self.savedVars.sound.use == false then
        return
    end

    if SOUNDS[self.savedVars.sound.id] ~= nil then
        PlaySound(SOUNDS[self.savedVars.sound.id])
    end
end
