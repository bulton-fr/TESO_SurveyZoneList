SurveyZone.ItemSort = {}

SurveyZone.ItemSort.savedVars = nil
SurveyZone.ItemSort.currentZoneName = ""

function SurveyZone.ItemSort:init()
    self.savedVars = SurveyZone.savedVariables.sort

    self:initSavedVarsValues()
end

function SurveyZone.ItemSort:initSavedVarsValues()
    if self.savedVars.order == nil then
        self.savedVars.order = {
            "nbUnique",
            "nbSurvey",
            "zoneName"
        }
    end

    if self.savedVars.keepCurrentZoneFirst == nil then
        self.savedVars.keepCurrentZoneFirst = true
    end
end

function SurveyZone.ItemSort:obtainOrder()
    return self.savedVars.order
end

function SurveyZone.ItemSort:defineOrder(pos, value)
    self.savedVars.order[pos] = value
    SurveyZone.GUI:refreshAll()
end

function SurveyZone.ItemSort:isKeepCurrentZoneFirst()
    return self.savedVars.keepCurrentZoneFirst
end

function SurveyZone.ItemSort:defineKeepCurrentZoneFirst(value)
    self.savedVars.keepCurrentZoneFirst = value
    SurveyZone.GUI:refreshAll()
end

function SurveyZone.ItemSort:updateCurrentZone()
    self.currentZoneName = zo_strformat(
        "<<1>>",
        GetZoneNameByIndex(GetCurrentMapZoneIndex())
    )

    if self.currentZoneName == nil then
        self.currentZoneName = ""
    else
        self.currentZoneName = self.currentZoneName:lower()
    end
end

--[[
-- Escape string to use it in pattern
-- Find at https://stackoverflow.com/a/6707799
--
-- @param String str The string to escape
--
-- @return String
--]]
function SurveyZone.ItemSort:espaceLuaStr(str)
    local matches = {
        ["^"] = "%^";
        ["$"] = "%$";
        ["("] = "%(";
        [")"] = "%)";
        ["%"] = "%%";
        ["."] = "%.";
        ["["] = "%[";
        ["]"] = "%]";
        ["*"] = "%*";
        ["+"] = "%+";
        ["-"] = "%-";
        ["?"] = "%?";
    }

    return str:gsub(".", matches)
end

function SurveyZone.ItemSort:exec()
    table.sort(SurveyZone.Collect.orderedList, self.sortZoneList)
end

function SurveyZone.ItemSort.sortZoneList(left, right)
    local sortOrder = SurveyZone.ItemSort.savedVars.order

    if SurveyZone.ItemSort:isKeepCurrentZoneFirst() == true then
        local currentName = SurveyZone.ItemSort.currentZoneName

        if string.find(currentName, left.nameEscaped) then
            return true
        elseif string.find(currentName, right.nameEscaped) then
            return false
        end
    end

    local orderType = sortOrder[1]

    if orderType == "nbUnique" and left.nbUnique == right.nbUnique then
        orderType = sortOrder[2]
    elseif orderType == "nbSurvey" and left.nbSurvey == right.nbSurvey then
        orderType = sortOrder[2]
    end
    if orderType == "nbUnique" and left.nbUnique == right.nbUnique then
        orderType = sortOrder[3]
    elseif orderType == "nbSurvey" and left.nbSurvey == right.nbSurvey then
        orderType = sortOrder[3]
    end
    
    if orderType == "zoneName" then
        return left.name < right.name
    elseif orderType == "nbUnique" then
        return left.nbUnique > right.nbUnique
    elseif orderType == "nbSurvey" then
        return left.nbSurvey > right.nbSurvey
    end
end