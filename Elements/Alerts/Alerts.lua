local vUI, GUI, Language, Media, Settings = select(2, ...):get()

local Alerts = CreateFrame("Frame")

local ALERT_WIDTH = 170
local HEADER_HEIGHT = 22
local LINE_HEIGHT = 18
local HOLD_TIME = 4
local FADE_IN_TIME = 0.3
local FADE_OUT_TIME = 1

local ActiveAlerts = {}
local UnusedAlerts = {}

local tinsert = table.insert
local tremove = table.remove

local SortAlerts = function()
	for i = 1, #ActiveAlerts do
		ActiveAlerts[i]:ClearAllPoints()
		
		if (i == 1) then
			ActiveAlerts[i]:SetScaledPoint("BOTTOMLEFT", vUIChatFrameTop, "TOPLEFT", -3, 5)
		else
			ActiveAlerts[i]:SetScaledPoint("BOTTOM", ActiveAlerts[i-1], "TOP", 0, 2)
		end
	end
end

local OnEnter = function(self)
	if self.Hold:IsPlaying() then
		self.Hold:Stop()
	end
	
	if self.FadeOut:IsPlaying() then
		self.FadeOut:Stop()
		self.FadeIn:Play()
	end
end

local OnLeave = function(self)
	if (not self.Hold:IsPlaying()) then
		self.Hold:Play()
	end
end

local HoldOnFinished = function(self)
	self:GetParent().FadeOut:Play()
end

local FadeInOnPlay = function(self)
	self:GetParent():Show()
end

local FadeInOnFinished = function(self)
	self:GetParent().Hold:Play()
end

local FadeOutOnFinished = function(self)
	local Alert = self:GetParent()
	
	for i = 1, #ActiveAlerts do
		if (ActiveAlerts[i] == Alert) then
			tinsert(UnusedAlerts, tremove(ActiveAlerts, i))
			
			break
		end
	end
	
	SortAlerts()
	Alert:Hide()
end

local CloseOnMouseUp = function(self)
	local Alert = self:GetParent():GetParent()
	
	Alert:Hide()
	Alert:SetAlpha(0)
	
	for i = 1, #ActiveAlerts do
		if (ActiveAlerts[i] == Alert) then
			tinsert(UnusedAlerts, tremove(ActiveAlerts, i))
			
			break
		end
	end
	
	SortAlerts()
end

local CreateAlertFrame = function()
	local AlertFrame = CreateFrame("Frame", nil, UIParent)
	AlertFrame:SetScaledSize(ALERT_WIDTH, (HEADER_HEIGHT + (LINE_HEIGHT * 2)))
	AlertFrame:SetBackdrop(vUI.BackdropAndBorder)
	AlertFrame:SetBackdropColor(vUI:HexToRGB(Settings["ui-window-bg-color"]))
	AlertFrame:SetBackdropBorderColor(0, 0, 0)
	AlertFrame:EnableMouse(true)
	AlertFrame:SetAlpha(0)
	AlertFrame:Hide()
	AlertFrame:SetScript("OnEnter", OnEnter)
	AlertFrame:SetScript("OnLeave", OnLeave)
	
	AlertFrame.Hold = CreateAnimationGroup(AlertFrame):CreateAnimation("Sleep")
	AlertFrame.Hold:SetDuration(HOLD_TIME)
	AlertFrame.Hold:SetScript("OnFinished", HoldOnFinished)
	
	AlertFrame.Fade = CreateAnimationGroup(AlertFrame)
	
	AlertFrame.FadeIn = AlertFrame.Fade:CreateAnimation("Fade")
	AlertFrame.FadeIn:SetEasing("in")
	AlertFrame.FadeIn:SetDuration(FADE_IN_TIME)
	AlertFrame.FadeIn:SetChange(1)
	AlertFrame.FadeIn:SetScript("OnPlay", FadeInOnPlay)
	
	AlertFrame.FadeOut = AlertFrame.Fade:CreateAnimation("Fade")
	AlertFrame.FadeOut:SetEasing("out")
	AlertFrame.FadeOut:SetDuration(FADE_OUT_TIME)
	AlertFrame.FadeOut:SetChange(0)
	AlertFrame.FadeOut:SetScript("OnFinished", FadeOutOnFinished)
	
	-- Header
	AlertFrame.Header = CreateFrame("Frame", nil, AlertFrame)
	AlertFrame.Header:SetScaledSize(ALERT_WIDTH, HEADER_HEIGHT)
	AlertFrame.Header:SetScaledPoint("TOP", AlertFrame, 0, 0)
	AlertFrame.Header:SetBackdrop(vUI.BackdropAndBorder)
	AlertFrame.Header:SetBackdropColor(0, 0, 0, 0)
	AlertFrame.Header:SetBackdropBorderColor(0, 0, 0)
	
	AlertFrame.Header.Texture = AlertFrame.Header:CreateTexture(nil, "ARTWORK")
	AlertFrame.Header.Texture:SetScaledPoint("TOPLEFT", AlertFrame.Header, 1, -1)
	AlertFrame.Header.Texture:SetScaledPoint("BOTTOMRIGHT", AlertFrame.Header, -1, 1)
	AlertFrame.Header.Texture:SetTexture(Media:GetTexture(Settings["ui-header-texture"]))
	AlertFrame.Header.Texture:SetVertexColor(vUI:HexToRGB(Settings["ui-header-texture-color"]))
	
	AlertFrame.Header.Text = AlertFrame.Header:CreateFontString(nil, "OVERLAY")
	AlertFrame.Header.Text:SetScaledPoint("LEFT", AlertFrame.Header, 5, 0)
	AlertFrame.Header.Text:SetFont(Media:GetFont(Settings["ui-header-font"]), 12)
	AlertFrame.Header.Text:SetJustifyH("LEFT")
	AlertFrame.Header.Text:SetShadowColor(0, 0, 0)
	AlertFrame.Header.Text:SetShadowOffset(1, -1)
	--AlertFrame.Header.Text:SetTextColor(vUI:HexToRGB(Settings["ui-header-font-color"]))
	AlertFrame.Header.Text:SetTextColor(vUI:HexToRGB(Settings["ui-widget-color"]))
	
	-- Line 1
	AlertFrame.Line1 = CreateFrame("Frame", nil, AlertFrame)
	AlertFrame.Line1:SetScaledSize(ALERT_WIDTH - 2, LINE_HEIGHT)
	AlertFrame.Line1:SetScaledPoint("TOP", AlertFrame.Header, "BOTTOM", 0, 0)
	--AlertFrame.Line1:SetBackdrop(vUI.Backdrop)
	--AlertFrame.Line1:SetBackdropColor(vUI:HexToRGB(Settings["ui-widget-bright-color"]))
	
	AlertFrame.Line1.Text = AlertFrame.Line1:CreateFontString(nil, "OVERLAY")
	AlertFrame.Line1.Text:SetScaledPoint("LEFT", AlertFrame.Line1, 3, 0)
	AlertFrame.Line1.Text:SetFont(Media:GetFont(Settings["ui-widget-font"]), 12)
	AlertFrame.Line1.Text:SetJustifyH("LEFT")
	AlertFrame.Line1.Text:SetShadowColor(0, 0, 0)
	AlertFrame.Line1.Text:SetShadowOffset(1, -1)
	AlertFrame.Line1.Text:SetTextColor(vUI:HexToRGB(Settings["ui-widget-font-color"]))
	
	-- Line 2
	AlertFrame.Line2 = CreateFrame("Frame", nil, AlertFrame)
	AlertFrame.Line2:SetScaledSize(ALERT_WIDTH - 2, LINE_HEIGHT)
	AlertFrame.Line2:SetScaledPoint("TOP", AlertFrame.Line1, "BOTTOM", 0, 1)
	--AlertFrame.Line2:SetBackdrop(vUI.Backdrop)
	--AlertFrame.Line2:SetBackdropColor(vUI:HexToRGB(Settings["ui-widget-bright-color"]))
	
	AlertFrame.Line2.Text = AlertFrame.Line2:CreateFontString(nil, "OVERLAY")
	AlertFrame.Line2.Text:SetScaledPoint("LEFT", AlertFrame.Line2, 3, 0)
	AlertFrame.Line2.Text:SetFont(Media:GetFont(Settings["ui-widget-font"]), 12)
	AlertFrame.Line2.Text:SetJustifyH("LEFT")
	AlertFrame.Line2.Text:SetShadowColor(0, 0, 0)
	AlertFrame.Line2.Text:SetShadowOffset(1, -1)
	AlertFrame.Line2.Text:SetTextColor(vUI:HexToRGB(Settings["ui-widget-font-color"]))
	
	-- Close button
	AlertFrame.CloseButton = CreateFrame("Frame", nil, AlertFrame.Header)
	AlertFrame.CloseButton:SetScaledSize(HEADER_HEIGHT - 2, HEADER_HEIGHT - 2)
	AlertFrame.CloseButton:SetScaledPoint("RIGHT", AlertFrame.Header, -1, 0)
	AlertFrame.CloseButton:SetBackdrop(vUI.Backdrop)
	AlertFrame.CloseButton:SetBackdropColor(0, 0, 0, 0)
	AlertFrame.CloseButton:SetScript("OnEnter", function(self) self.Text:SetTextColor(1, 0, 0) end)
	AlertFrame.CloseButton:SetScript("OnLeave", function(self) self.Text:SetTextColor(1, 1, 1) end)
	AlertFrame.CloseButton:SetScript("OnMouseUp", CloseOnMouseUp)
	
	AlertFrame.CloseButton.Text = AlertFrame.CloseButton:CreateFontString(nil, "OVERLAY")
	AlertFrame.CloseButton.Text:SetScaledPoint("CENTER", AlertFrame.CloseButton, 0, 0)
	AlertFrame.CloseButton.Text:SetFont(Media:GetFont("PT Sans"), 18)
	AlertFrame.CloseButton.Text:SetJustifyH("CENTER")
	AlertFrame.CloseButton.Text:SetShadowColor(0, 0, 0)
	AlertFrame.CloseButton.Text:SetShadowOffset(1, -1)
	AlertFrame.CloseButton.Text:SetText("×")
	
	return AlertFrame
end

local GetAlertFrame = function()
	local AlertFrame
	
	if UnusedAlerts[1] then
		AlertFrame = tremove(UnusedAlerts, 1)
	else
		AlertFrame = CreateAlertFrame()
	end
	
	tinsert(ActiveAlerts, AlertFrame)
	
	return AlertFrame
end

local SendAlert = function(header, line1, line2, func, nofade)
	local AlertFrame = GetAlertFrame()
	print(func, nofade)
	if nofade then
		AlertFrame.FadeIn:SetScript("OnFinished", nil)
	else
		AlertFrame.FadeIn:SetScript("OnFinished", FadeInOnFinished)
	end
	
	if (func and (type(func) == "function")) then
		AlertFrame:SetScript("OnMouseUp", func)
	else
		AlertFrame:SetScript("OnMouseUp", nil) -- Clear old functions
	end
	
	SortAlerts()
	
	AlertFrame.Header.Text:SetText(header)
	AlertFrame.Line1.Text:SetText(line1)
	AlertFrame.Line2.Text:SetText(line2)
	AlertFrame.FadeIn:Play()
end

function vUI:SendAlert(header, line1, line2, func, nofade)
	SendAlert(header, line1, line2, func, nofade)
end