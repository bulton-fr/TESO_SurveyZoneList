-- ENGLISH LANGUAGE LOCALIZATION

-- GUI
-- First item, title
ZO_CreateStringId("SI_SURVEYZONELIST_LIST_TITLE",  "Survey Zone List")

-- Keybinds
-- Toggle GUI
ZO_CreateStringId("SI_BINDING_NAME_SURVEYZONELIST_TOGGLE", "Toggle window")

-- Settings
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_LOCKUI", "Lock UI")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_DISPLAYED_WITH_WM", "Displayed with the world map")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_CURRENT_ZONE_FIRST", "Keep the current zone first")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_ITEM_TEXT_FORMAT", "Text format used for each zone")
ZO_CreateStringId(
    "SI_SURVEYZONELIST_SETTINGS_ITEM_TEXT_FORMAT_DESC",
    "You can use the following placeholders in the text format, which will be replaced with the value information :\n"
    .."<<1>> Zone's name\n"
    .."<<2>> Number of unique survey in the zone\n"
    .."<<3>> Total number of survey in the zone\n\n"
    .."Default value is <<1>> : <<2>> - <<3>>"
)
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_ZONE_NAME", "zone name")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_NB_UNIQUE", "number of unique survey")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_NB_SURVEY", "total number of survey")
