SurveyZoneList.Recolt = {}

SurveyZoneList.Recolt.maxNode = 6
SurveyZoneList.Recolt.counter = 0
SurveyZoneList.Recolt.type    = nil

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

    --local type, subType = GetItemLinkItemType(itemLink)
    --d(zo_strformat("<<1>> : <<2>> / <<3>>", itemLink, type, subType))

    --[[
    Alchimie => ITEMTYPE_REAGENT
    [15:10] [15:10] [Nirnrave] : 31 / 150
    [15:11] [15:11] [Jacinthe d'eau] : 31 / 150
    [15:18] [15:18] [Bleuet] : 31 / 150
    [15:18] [15:18] [Résine alchimique] : 62 / 1460
    [15:20] [15:20] [Entoloma bleue] : 31 / 151
    [15:20] [15:20] [Résine alchimique] : 62 / 1460
    [15:22] [15:22] [Entoloma bleue] : 31 / 151
    [15:22] [15:22] [Résine alchimique] : 62 / 1460

    Couture => ITEMTYPE_CLOTHIER_RAW_MATERIAL
    [15:09] [15:09] [Soie ancestrale brute] : 39 / 1700
    [15:21] [15:21] [Soie ancestrale brute] : 39 / 1700

    Enchantement => ITEMTYPE_ENCHANTING_RUNE_ASPECT, ITEMTYPE_ENCHANTING_RUNE_ESSENCE, ITEMTYPE_ENCHANTING_RUNE_POTENCY
    [15:08] [15:08] [Dekeïpa] : 53 / 2400
    [15:08] [15:08] [Denata] : 52 / 2350
    [15:08] [15:08] [Rune profane] : 62 / 2410
    [15:10] [15:10] [Oko] : 53 / 2400
    [15:10] [15:10] [Oru] : 53 / 2400
    [15:10] [15:10] [Ta] : 52 / 2350
    [15:15] [15:15] [Denima] : 53 / 2400
    [15:15] [15:15] [Denata] : 52 / 2350

    Forge => ITEMTYPE_BLACKSMITHING_RAW_MATERIAL
    [15:18] [15:18] [Minerai de cuprite] : 35 / 1500
    [15:18] [15:18] [Regulus] : 62 / 1560
    [15:18] [15:18] [Poussière de platine] : 63 / 2800
    [15:19] [15:19] [Minerai de cuprite] : 35 / 1500
    [15:19] [15:19] [Poussière de platine] : 63 / 2800

    Joaillerie => ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL
    [15:11] [15:11] [Poussière de platine] : 63 / 2800

    Travail du bois => ITEMTYPE_WOODWORKING_RAW_MATERIAL
    [15:10] [15:10] [Frêne roux brut] : 37 / 1600
    [15:14] [15:14] [Frêne roux brut] : 37 / 1600
    [15:14] [15:14] [Duramen] : 62 / 1660
    [15:22] [15:22] [Frêne roux brut] : 37 / 1600
    --]]
end
