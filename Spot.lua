SurveyZoneList.Spot = {}

--[[
-- @const WHEN_START string The value for when alerts should be executed on the first survey's node
--]]
SurveyZoneList.Spot.WHEN_START = "BEFORE"

--[[
-- @const WHEN_END string The value for when alerts should be executed on the last survey's node
--]]
SurveyZoneList.Spot.WHEN_END = "END"

--[[
-- @var table All saved variables dedicated to the spot system.
--]]
SurveyZoneList.Spot.savedVars = nil

--[[
-- @var bool inBag To know if we have the bag displayed
--]]
SurveyZoneList.Spot.inBag = false

--[[
-- @var bool inBank To know if we have the bank displayed
--]]
SurveyZoneList.Spot.inBank = false

--[[
-- @var int The quantity of survey for the current spot
--]]
SurveyZoneList.Spot.spotQuantity = 0

--[[
-- @var int The quantity of survey for the current zone
--]]
SurveyZoneList.Spot.zoneQuantity = 0

--[[
-- Initialise the Spot system
--]]
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

--[[
-- Add an event for when the inventory scene is trigger
--]]
function SurveyZoneList.Spot:initOpenBagEvent()
    local inventoryScene = SCENE_MANAGER:GetScene("inventory")
    inventoryScene:RegisterCallback("StateChange", function(oldState, newState)
        SurveyZoneList.Spot.inBag = newState
    end)
end

--[[
-- Set the value of inBank
--
-- @param bool newState
--]]
function SurveyZoneList.Spot:setInBank(newState)
    self.inBank = newState
end

--[[
-- Get the value of sound.use
--]]
function SurveyZoneList.Spot:getSoundUse()
    return self.savedVars.sound.use
end

--[[
-- Set the value of sound.use
--
-- @param bool newState
--]]
function SurveyZoneList.Spot:setSoundUse(useSound)
    self.savedVars.sound.use = useSound
end

--[[
-- Get the value of sound.id
--]]
function SurveyZoneList.Spot:getSoundId()
    return self.savedVars.sound.id
end

--[[
-- Set the value of sound.id
--
-- @param string idSound
--]]
function SurveyZoneList.Spot:setSoundId(idSound)
    self.savedVars.sound.id = idSound
end

--[[
-- Get the value of alert
--]]
function SurveyZoneList.Spot:getAlert()
    return self.savedVars.alert
end

--[[
-- Set the value of alert
--
-- @param bool useAlert
--]]
function SurveyZoneList.Spot:setAlert(useAlert)
    self.savedVars.alert = useAlert
end

--[[
-- Get the value of when
--]]
function SurveyZoneList.Spot:getWhen()
    return self.savedVars.when
end

--[[
-- Set the value of when
--
-- @param string when
--]]
function SurveyZoneList.Spot:setWhen(when)
    self.savedVars.when = when
end

--[[
-- Check if the bag or the bank is displayed/opened
--
-- @return bool
--]]
function SurveyZoneList.Spot:uiOpen()
    return self.inBag or self.inBank
end

--[[
-- Change about the quantity of survey
--
-- @var int spotQuantity The survey's quantity for the spot which have changed
-- @var int zoneQuantity The survey's quantity for the zone which have changed
--]]
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

--[[
-- Execute all configured alert for a specific time
--
-- @param string when If the function is called on the first or the last node
--]]
function SurveyZoneList.Spot:execAlerts(when)
    if when ~= self.savedVars.when then
        return
    end

    self:displayAnnounce()
    self:playSong()
end

--[[
-- Call the update of the spot info in the GUI
--]]
function SurveyZoneList.Spot:updateGUI()
    SurveyZoneList.GUI:updateSpotInfo()
end

--[[
-- Display the announce about the last spot
--]]
function SurveyZoneList.Spot:displayAnnounce()
    if self.savedVars.alert == false then
        return
    end

    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.NONE)
	messageParams:SetText(GetString(SI_SURVEYZONELIST_SPOT_NOTIFY_LASTSPOT))
	messageParams:SetLifespanMS(5000)
	CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
end

--[[
-- Play sound about the last spot
--]]
function SurveyZoneList.Spot:playSong()
    if self.savedVars.sound.use == false then
        return
    end

    if SOUNDS[self.savedVars.sound.id] ~= nil then
        PlaySound(SOUNDS[self.savedVars.sound.id])
    end
end
