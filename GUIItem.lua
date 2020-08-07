SurveyZone.GUIItem = {}
SurveyZone.GUIItem.__index = SurveyZone.GUIItem

SurveyZone.GUIItem.uiIdx = 0

function SurveyZone.GUIItem:new()
    local guiItem = {
        ui       = nil,
        uiLabel  = nil,
        parentUI = SurveyZone.GUI.ui,
        used     = false,
        zoneName = nil,
        zoneInfo = nil
    }

    setmetatable(guiItem, self)
    self.uiIdx = self.uiIdx + 1

    guiItem:initUI()
    return guiItem
end

function SurveyZone.GUIItem:initUI()
    local WindowManager = GetWindowManager()
    local uiName        = "SurveyZoneUIItem"..self.uiIdx
    local uiLabelName   = uiName.."_Label"

    self.ui = WindowManager:CreateControl(uiName, self.parentUI, CT_BACKDROP)
    self.ui:SetDimensions(self.parentUI:GetWidth(), 30)
	self.ui:SetCenterColor(0, 0, 0, .25)
	self.ui:SetEdgeColor(0, 0, 0, .25)
    self.ui:SetEdgeTexture(nil, 1, 1, 0, 0)
    
    self.uiLabel = WindowManager:CreateControl(uiLabelName, self.ui, CT_LABEL)
    self.uiLabel:SetAnchor(TOPLEFT, self.ui, TOPLEFT, 5, 3)
    self.uiLabel:SetFont("ZoFontGame")
end

function SurveyZone.GUIItem:display(isHidden)
    if isHidden == true then
        self:hide()
    else
        self:show()
    end
end

function SurveyZone.GUIItem:hide()
    self.ui:SetHidden(true)
end

function SurveyZone.GUIItem:show()
    self.ui:SetHidden(false)
end

function SurveyZone.GUIItem:definePosition(index)
    self.ui:SetAnchor(TOPLEFT, self.parentUI, TOPLEFT, 0, index*30)
end

function SurveyZone.GUIItem:updateText()
    self.uiLabel:SetText(zo_strformat(
        "<<1>> : <<2>> - <<3>>",
        self.zoneName,
        self.zoneInfo.nbUnique,
        self.zoneInfo.nbSurvey
    ))
end
