
EVENT_MANAGER:RegisterForEvent("SurveyZoneListLoad", EVENT_ADD_ON_LOADED, SurveyZoneList.Events.onLoaded)

EVENT_MANAGER:RegisterForEvent("SurveyZoneListLoadScreen", EVENT_PLAYER_ACTIVATED, SurveyZoneList.Events.onLoadScreen)

EVENT_MANAGER:RegisterForEvent("SurveyZoneListMoveItem", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, SurveyZoneList.Events.onMoveItem)
EVENT_MANAGER:AddFilterForEvent("SurveyZoneListMoveItem", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
EVENT_MANAGER:AddFilterForEvent("SurveyZoneListMoveItem", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)

EVENT_MANAGER:RegisterForEvent("SurveyZoneListLootClosed", EVENT_LOOT_CLOSED, SurveyZoneList.Events.onLootClosed)
EVENT_MANAGER:RegisterForEvent("SurveyZoneListLootReceived", EVENT_LOOT_RECEIVED, SurveyZoneList.Events.onLootReceived)

ZO_PostHook(RETICLE, "TryHandlingInteraction", SurveyZoneList.Events.reticleTryHandlingInteraction)
