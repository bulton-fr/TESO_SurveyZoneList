SurveyZoneList.Interaction = {}

--[[
-- @var string The last interactible item see
--]]
SurveyZoneList.Interaction.lastName = nil

--[[
-- @var bool If the last interactible item is a survey node or not
--]]
SurveyZoneList.Interaction.lastIsSurvey = false

--[[
-- Called by PostHook on TryHandlingInteraction
-- Call the check if the interaction is with a survey node; If true, display
-- the craft icon before the interaction item's name
--
-- @var bool interactionPossible (see TryHandlingInteraction method)
--]]
function SurveyZoneList.Interaction:updateInteractContext(interactionPossible)
    if not interactionPossible then
        return nil
    end

    local action, name, _, _, additionalInteractInfo, _, _, _ = GetGameCameraInteractableActionInfo()

    local sameInteraction = true
    if name ~= self.lastName then
        sameInteraction   = false
        self.lastName     = name
        self.lastIsSurvey = false
    end
    
    if action and name then
        if additionalInteractInfo ~= ADDITIONAL_INTERACT_INFO_NONE then
            return nil
        end

        if sameInteraction == false then
            self.lastIsSurvey = self:isSurveyNode(action, name)
        end

        if self.lastIsSurvey == false then
            return nil
        end

        RETICLE.interactContext:SetText(
            zo_iconTextFormat(
                '/esoui/art/icons/poi/poi_crafting_complete.dds',
                40,
                40,
                self.lastName
            )
        )
    end
end

--[[
-- Check if the interacionName and the action match with a survey node
--
-- @param string action Action label feasible on the item
-- @param string interactionName The name of the interactible item
--
-- @return bool
--]]
function SurveyZoneList.Interaction:isSurveyNode(action, interactionName)
    local actionAllowed = false
    for avActionIdx, availableAction in pairs(SurveyZoneList.lang.surveyAction) do
        if action == availableAction then
            actionAllowed = true
            break
        end
    end

    if actionAllowed == false then
        return false
    end

    local language     = GetCVar("Language.2")
    local nodeNameList = SurveyZoneList.lang.nodeName[language]

    if nodeNameList == nil then
        return false
    end

    for nodeNameIdx, nodeNamePartToFind in pairs(nodeNameList) do
        if string.find(interactionName:lower(), nodeNamePartToFind) then
            return true
        end
    end

    return false
end
