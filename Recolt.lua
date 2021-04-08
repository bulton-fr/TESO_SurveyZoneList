SurveyZoneList.Recolt = {}

SurveyZoneList.Recolt.maxNode = 6
SurveyZoneList.Recolt.counter = 0

function SurveyZoneList.Recolt:reset(surveyItemName)
    self.counter = 0
    SurveyZoneList.GUI:updateCounter()
end

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
