-- FRENCH LANGUAGE LOCALIZATION

-- GUI
-- First item, title
ZO_CreateStringId("SI_SURVEYZONELIST_LIST_TITLE",  "Survey Zone List")

-- Keybinds
-- Toggle GUI
ZO_CreateStringId("SI_BINDING_NAME_SURVEYZONELIST_TOGGLE", "Afficher/Cacher la fenêtre")

-- Settings
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_LOCKUI", "Verrouiller l'interface")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_DISPLAYED_WITH_WM", "Afficher avec la map")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_DISPLAY_SURVEY", "Afficher la zone lorsqu'il n'y a que des repérages")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_DISPLAY_TREASURE", "Afficher la zone lorsqu'il n'y a que des cartes aux trésors")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_CURRENT_ZONE_FIRST", "Garder la zone actuelle en premier")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_ITEM_TEXT_FORMAT", "Format du texte pour chaque zone")
ZO_CreateStringId(
    "SI_SURVEYZONELIST_SETTINGS_ITEM_TEXT_FORMAT_DESC",
    "Vous pouvez utiliser les raccourcis suivant dans le format du texte, ils seront remplacé par la valeur correspondante :\n"
    .."<<1>> Le nom de la zone\n"
    .."<<2>> Le nombre de répérage unique dans la zone\n"
    .."<<3>> Le nombre total de repérage dans la zone\n"
    .."<<4>> Le nombre de cartes aux trésors dans la zone\n\n"
    .."La valeur par défaut est <<1>> : <<2>> - <<3>> / <<4>>"
)
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_TITLE", "tri")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_DESC", "Vous pouvez définir l'ordre de priorité utilisé pour le tri de la liste des zones.")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_ZONE_NAME", "Nom de la zone")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_SURVEY_NB_UNIQUE", "Nombre unique de repérage")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_SURVEY_NB_TOTAL", "Nombre total de répérage")
ZO_CreateStringId("SI_SURVEYZONELIST_SETTINGS_SORT_TREASURE_NB_UNIQUE", "Nombre de carte aux trésors")

-- Collect
SurveyZoneList.lang.collectFindName = {
    "carte au trésor d'",
    "carte au trésor de ",
    "carte au trésor des ",
    "carte au trésor du ",
    ".*: ",
}
