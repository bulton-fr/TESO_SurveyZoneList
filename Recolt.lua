SurveyZoneList.Recolt = {}

--[[
-- @var int max number of node on a survey
--]]
SurveyZoneList.Recolt.maxNode = 6

--[[
-- @var int number of node recolted for the current survey
--]]
SurveyZoneList.Recolt.counter = 0

--[[
-- Reset the counter of node recolted
--]]
function SurveyZoneList.Recolt:reset()
    self.counter = 0
    SurveyZoneList.GUI:updateCounter()
end

--[[
-- Called when the loot window is closed
-- Check if the last interaction is a survey, and update the counter if true
-- Also call alerts systems if the number of spot recolted is equal to max node
--]]
function SurveyZoneList.Recolt:lootClosed()

    if SurveyZoneList.Interaction.lastIsSurvey == false then
        return
    end

    self.counter = self.counter + 1
    SurveyZoneList.GUI:updateCounter()

    if self.counter == self.maxNode then
        SurveyZoneList.Spot:execAlerts(SurveyZoneList.Spot.WHEN_END)
    end
end
