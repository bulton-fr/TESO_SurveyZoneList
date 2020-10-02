# Survey Zone List

It's an addon for [The Elder Scroll Online](https://www.elderscrollsonline.com) which track all surveys you have in you bag and display all zone where you have a surve, the survey's unique number and the total number.

## Dependencies

One library : [`LibAddonMenu-2.0`](https://esoui.com/downloads/info7-LibAddonMenu.html).

## Install it

Into the addon folder (`Elder Scrolls Online\live\AddOns` in your document folder), you need to have a folder `SurveyZoneList` and copy all files into it.

So you can :

* Clone the repository in the AddOns folder and name it `SurveyZoneList`.
* Or download the zip file started by `esoui-` of the last release in github, and extract it in the AddOns folder.

## In game

You will have a new "widget" which will be displayed in the screen. 
The system will search in you bag all surveys, parse it to know the zone name and will add the zone name in the widget.

For example, I have this :  
*I'm currently in Rimmen when the screen has been taken, so I have the Northern Elsweyr in top of the list (you can configure it)*  
![Screen with the list](https://projects.bulton.fr/teso/SurveyZoneList/list.jpg)

You can configure how the sort is done and the text format :  
![Settings screen](https://projects.bulton.fr/teso/SurveyZoneList/settings.jpg)

Also you can configure a keybind to show/hide the GuI

## About lua files

There are loaded in order :

* Initialise.lua
* Collect.lua
* Events.lua
* GUI.lua
* GUIItem.lua
* ItemSort.lua
* Settings.lua
* Run.lua

### Initialise.lua

Declare all variables and the initialise function.

Declared variables :

* `SurveyZoneList` : The global table for all addon's properties and methods.
* `SurveyZoneList.name` : The addon name
* `SurveyZoneList.savedVariables` : The `ZO_SavedVars` table which contains saved variable for this addon.
* `SurveyZoneList.ready` : If the addon is ready to be used
* `SurveyZoneList.LAM` : The library LibAddonMenu2

Methods :

* `SurveyZoneList:Initialise` : Module initialiser  
Intiialise savedVariables, settings panel, GUI and the sort system

### Collect.lua

Table : `SurveyZoneList.Collect`

Contain the bag reader system

Properties :

* `zoneList` : It's a table where keys are the zone name (from survey item name), and the value is a table which contain all info about the zone like number of survey, etc
* `slotList` : It's a table where Keys are the slot index, and the value a table with info about the survey at the specific slot index; the table contain the zone name and the itemlink
* `orderedList` : Same as zoneList but with numerical keys (like an array), so we don't care about keys on this table. Values are reference to values in zoneList.

Methods :

* `SurveyZoneList.Collect:search` : Read all items in the character bag to find all surveys
* `SurveyZoneList.Collect:readItem` : Read a specific item in the character bag to know if it's a survey, and parse the item name to know the zone name of the survey
* `SurveyZoneList.Collect:obtainNewZoneInfo` : Obtain the table skeleton used to save data about a zone
* `SurveyZoneList.Collect:updateItemToList` : Update all lists for the item at slot slotIdx in the character bag
* `SurveyZoneList.Collect:removeItemFromList` : Remove an item from all list
* `SurveyZoneList.Collect:findForSlotIdx` : Return saved info about the item at a specific slot index in character bag

### Events.lua

Table : `SurveyZoneList.Events`

Contain all functions called when a listened event is triggered.

Methods :

* `SurveyZoneList.Events.onLoaded` : Called when the addon is loaded
* `SurveyZoneList.Events.onLoadScreen` : Called after each load screen
* `SurveyZoneList.Events.onMoveItem` : Called when a item move in the character bag (filter on event)
* `SurveyZoneList.Events.onGuiMoveStop` : Called when the user stop to move the GUI
* `SurveyZoneList.Events.keybindingsToggle` : Called when the user trigger the keybinds for "toggle GUI"

### GUI.lua

Table : `SurveyZoneList.GUI`

Contains all functions to define the GUI container and save GUIItems instances.

Properties :

* `ui` : The ui TolLevelWindow
* `backUI` : The ui backdrop
* `title` : The first item of the list which display list title
* `fragment` : The fragment used to link the ui to a scene
* `itemList` :  A list of all GUIItems created. We cannot remove an ui item from memory, so we keep it all created items here to reuse it when the list is refreshed.
* `savedVars` : All saved variables dedicated to the gui.

Methods :

* `SurveyZoneList.GUI:init` : Initialise the GUI
* `SurveyZoneList.GUI:initSavedVarsValues` : Initialise with a default value all saved variables dedicated to the gui
* `SurveyZoneList.GUI:build` : Build the GUI
* `SurveyZoneList.GUI:restorePosition` : Restore the GUI's position from saved variables
* `SurveyZoneList.GUI:isLocked` : Return info about if the GUI position is locked or not
* `SurveyZoneList.GUI:defineLocked` : Define if the GUI is locked or not.
* `SurveyZoneList.GUI:isDisplayWithWMap` : Return info about if the GUI should be displayed when the world map is open or not
* `SurveyZoneList.GUI:defineDisplayWithWMap` : Define if the GUI should be displayed when the world map is open or not
* `SurveyZoneList.GUI:obtainDisplayItemText` : Return the text format used for each item
* `SurveyZoneList.GUI:defineDisplayItemText` : Define a new text format for items
* `SurveyZoneList.GUI:savePosition` : Save the GUI's position to savedVariables
* `SurveyZoneList.GUI:defineFragment` : Define GUI as a fragment linked to scenes. With that, the GUI is hidden when we open a menu (like inventory or map)
* `SurveyZoneList.GUI:toggle` : Show or hide the GUI  
If the GUI is currently hidden, it will be shown.  
If the GUI is currently shown, it will be hidden.
* `SurveyZoneList.GUI:refreshAll` : Refresh all items displayed
* `SurveyZoneList.GUI:resetAllItems` : Reset each item values an hide it
* `SurveyZoneList.GUI:hideAllItems` : Hide all items
* `SurveyZoneList.GUI:showAllItems` : Show all used items

### GUIItems.lua

Table : `SurveyZoneList.GUIItem`

Contain all info about a row/zoneName in the gui. It's a POO like with one instance of GUIItem by row/zoneName (called item).

Properties :

* `uiIdx` : (static property) The current uiItem index which represents the number of item already created
* `ui` : The item's ui BACKDROP
* `uiLabel` : The item's ui label
* `parentUI` : The TopLevelWindow in GUI table
* `used` : If the current item is used or not (cannot be destroyed)
* `zoneName` : The zone name to display
* `zoneInfo` : Info about the zone, value in SurveyZoneList.Collect.orderedList 

Methods :

* `SurveyZoneList.GUIItem:new` : Instanciate a new GUIItem "object"
* `SurveyZoneList.GUIItem:initUI` : Create ui elements used by the item
* `SurveyZoneList.GUIItem:display` : To display or not the gui
* `SurveyZoneList.GUIItem:hide` : To hide the item's ui
* `SurveyZoneList.GUIItem:show` : To show the item's ui
* `SurveyZoneList.GUIItem:definePosition` : Define the item's ui position from the index
* `SurveyZoneList.GUIItem:updateText` : Update the text to display

### ItemSort.lua

Table : `SurveyZoneList.ItemSort`

Contain all function to manage the sort system

Constants :

* `ORDER_TYPE_NB_UNIQUE` : The value for an order by number of unique survey point
* `ORDER_TYPE_NB_SURVEY` : The value for an order by the total number of survey in a zone
* `ORDER_TYPE_ZONE_NAME` : The value for an order by zone name

Properties :

* `savedVars` : All saved variables dedicated to the sort system.
* `currentZoneName` : The current zone name

Methods :

* `SurveyZoneList.ItemSort:init` : Initialise data used by the sort system
* `SurveyZoneList.ItemSort:initSavedVarsValues` : Initialise with a default value all saved variables dedicated to the sort system
* `SurveyZoneList.ItemSort:obtainOrder` : Obtain the current order to use
* `SurveyZoneList.ItemSort:defineOrder` : Define a new order to use
* `SurveyZoneList.ItemSort:isKeepCurrentZoneFirst` : Obtain info about if the current zone must always be the first item or not
* `SurveyZoneList.ItemSort:defineKeepCurrentZoneFirst` : Define if the current zone must always be the first item or not
* `SurveyZoneList.ItemSort:updateCurrentZone` : Update the current zone name
* `SurveyZoneList.ItemSort:espaceLuaStr` : Escape string to use it in pattern
* `SurveyZoneList.ItemSort:exec` : Execute the table's sort on SurveyZoneList.Collect.orderedList
* `SurveyZoneList.ItemSort.sortZoneList` : Callback function used by table.sort.  
It's called each time an item in the sorted table is compared to another.

### Settings.lua

Table : `SurveyZoneList.Settings`

Contain all function used to build the settings panel

Properties :

* `panelName` : The name of the settings panel

Methods :

* `SurveyZoneList.Settings:init` : Initialise the settings panel
* `SurveyZoneList.Settings:build` : Build the settings panel
* `SurveyZoneList.Settings:buildGUILocked` : Return info to build the setting panel for "lock ui"
* `SurveyZoneList.Settings:buildDisplayedWithWorldMap` : Return info to build the setting panel for "display with world map"
* `SurveyZoneList.Settings:buildCurrentZoneFirst` : Return info to build the setting panel for "keep the current zone first"
* `SurveyZoneList.Settings:buildDisplayItemText` : Return info to build the setting panel for "item text format"
* `SurveyZoneList.Settings:buildSort` : Return info to build the setting panel for a "sort" order

### Run.lua

Define a listener to all used events.
