local vUI, GUI, Language, Assets, Settings = select(2, ...):get()

local Taxi = vUI:NewModule("Taxi")

function Taxi:OnEnter()
	local R, G, B = vUI:HexToRGB(Settings["ui-widget-font-color"])
	
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, -6)
	GameTooltip:AddLine(TAXI_CANCEL_DESCRIPTION, R, G, B)
	GameTooltip:Show()
end

function Taxi:OnLeave()
	GameTooltip:Hide()
end

function Taxi:OnMouseUp()
    if UnitOnTaxi("player") then
        TaxiRequestEarlyLanding()
		self:Hide()
    end
end

function Taxi:OnEvent()
    if UnitOnTaxi("player") then
        self:Show()
    else
		self:Hide()
    end
end

function Taxi:Load()
	self:SetSize(Settings["minimap-size"] + 8, 22)
	self:SetPoint("TOP", _G["vUI Minimap"], "BOTTOM", 0, -2)
	self:SetBackdrop(vUI.BackdropAndBorder)
	self:SetBackdropColor(vUI:HexToRGB(Settings["ui-window-bg-color"]))
	self:SetBackdropBorderColor(0, 0, 0)
	self:SetFrameStrata("HIGH")
	self:SetFrameLevel(10)
	self:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	self:SetScript("OnMouseUp", self.OnMouseUp)
	self:SetScript("OnEnter", self.OnEnter)
	self:SetScript("OnLeave", self.OnLeave)
	self:SetScript("OnEvent", self.OnEvent)
	
    if UnitOnTaxi("player") then
        self:Show()
    else
		self:Hide()
    end
	
	self.Texture = self:CreateTexture(nil, "ARTWORK")
	self.Texture:SetPoint("TOPLEFT", self, 1, -1)
	self.Texture:SetPoint("BOTTOMRIGHT", self, -1, 1)
	self.Texture:SetTexture(Assets:GetTexture(Settings["ui-header-texture"]))
	self.Texture:SetVertexColor(vUI:HexToRGB(Settings["ui-header-texture-color"]))
	
	self.Text = self:CreateFontString(nil, "OVERLAY", 7)
	self.Text:SetPoint("CENTER", self, 0, -1)
	vUI:SetFontInfo(self.Text, Settings["ui-header-font"], Settings["ui-font-size"])
	self.Text:SetSize(self:GetWidth() - 12, 20)
	self.Text:SetText(Language["Land Early"])
	
	vUI:CreateMover(self)
end