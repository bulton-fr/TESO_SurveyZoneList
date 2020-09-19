SurveyZone.Collect = {}

SurveyZone.Collect.zoneList = {}
SurveyZone.Collect.slotList = {}
SurveyZone.Collect.orderedList = {}

function SurveyZone.Collect:search()
    self.zoneList    = {}
    self.slotList    = {}
    self.orderedList = {}

    local bagItems = GetBagSize(BAG_BACKPACK)
    local itemZoneName = ""

    for slotIdx=0, bagItems, 1 do
        itemZoneName = self:readItem(slotIdx)
        self:updateItemToList(itemZoneName, slotIdx)
    end
end

function SurveyZone.Collect:readItem(slotIdx)
    local itemLink      = GetItemLink(BAG_BACKPACK, slotIdx)
    local type, subType = GetItemLinkItemType(itemLink)

    if type ~= ITEMTYPE_TROPHY then
        return nil
    end

    if subType ~= SPECIALIZED_ITEMTYPE_TROPHY_SURVEY_REPORT then
        return nil
    end

    local itemName     = zo_strformat("<<1>>", GetItemName(BAG_BACKPACK, slotIdx))
    local itemZoneName = itemName:match(".*: (.*)")

    -- Some survey map name not corresponding to the pattern, so a security to
    -- avoid error.
    if itemZoneName == nil then
        return nil
    end

    if itemZoneName:find("I$") ~= nil or itemZoneName:find("V$") ~= nil or itemZoneName:find("X$") ~= nil then
        itemZoneName = itemZoneName:match("(.*) %a+")
    end

    return itemZoneName
end

function obtainNewZoneInfo(itemZoneName)
    return {
        name        = itemZoneName,
        nameEscaped = SurveyZone.ItemSort:espaceLuaStr(itemZoneName:lower()),
        nbUnique    = 0,
        nbSurvey    = 0,
        list        = {}
    }
end

function SurveyZone.Collect:updateItemToList(itemZoneName, slotIdx)
    if itemZoneName == nil then
        return
    end

    local itemLink = GetItemLink(BAG_BACKPACK, slotIdx)
    local quantity = GetItemTotalCount(BAG_BACKPACK, slotIdx)

    if self.zoneList[itemZoneName] == nil then
        self.zoneList[itemZoneName] = obtainNewZoneInfo(itemZoneName)
        table.insert(self.orderedList, self.zoneList[itemZoneName])
    end

    local oldQuantity = 0
    if self.zoneList[itemZoneName].list[itemLink] == nil then
        self.zoneList[itemZoneName].nbUnique = self.zoneList[itemZoneName].nbUnique + 1
    else
        oldQuantity = self.zoneList[itemZoneName].list[itemLink]
    end

    self.zoneList[itemZoneName].list[itemLink] = quantity

    self.zoneList[itemZoneName].nbSurvey = self.zoneList[itemZoneName].nbSurvey + (quantity - oldQuantity)

    self.slotList[slotIdx] = {
        zoneName = itemZoneName,
        itemLink = itemLink
    }
end

function SurveyZone.Collect:removeItemFromList(itemInfo, slotIdx)
    if itemInfo == nil then
        return
    end

    local itemZoneName = itemInfo.zoneName
    local itemLink     = itemInfo.itemLink

    if self.zoneList[itemZoneName] == nil then
        self.zoneList[itemZoneName] = obtainNewZoneInfo(itemZoneName)
        table.insert(self.orderedList, self.zoneList[itemZoneName])
    end

    self.zoneList[itemZoneName].nbUnique = self.zoneList[itemZoneName].nbUnique - 1
    if self.zoneList[itemZoneName].nbUnique < 0 then
        self.zoneList[itemZoneName].nbUnique = 0
    end

    if self.zoneList[itemZoneName].list[itemLink] ~= nil then
        local oldQuantity =  self.zoneList[itemZoneName].list[itemLink]

        self.zoneList[itemZoneName].nbSurvey = self.zoneList[itemZoneName].nbSurvey - oldQuantity
        if self.zoneList[itemZoneName].nbSurvey < 0 then
            self.zoneList[itemZoneName].nbSurvey = 0
        end

        self.zoneList[itemZoneName].list[itemLink] = nil
    end

    self.slotList[slotIdx] = nil
end

function SurveyZone.Collect:findForSlotIdx(slotIdx)
    return self.slotList[slotIdx]
end
