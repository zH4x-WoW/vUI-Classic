local vUI, GUI, Language, Media, Settings = select(2, ...):get()

Media.Fonts = {}
Media.Textures = {}
Media.Highlights = {}
Media.Templates = {}
Media.Colors = {}

local TemplateList = {}
local HighlightList = {}
local TextureList = {}
local FontList = {}

function Media:SetFont(name, path, silent)
	if self.Fonts[name] then
		return
	end
	
	self.Fonts[name] = path
	
	if (not silent) then
		FontList[name] = path
	end
end

function Media:GetFont(name)
	if self.Fonts[name] then
		return self.Fonts[name]
	else
		return self.Fonts["PT Sans"]
	end
end

function Media:GetFontList()
	return FontList
end

function Media:SetTexture(name, path, silent)
	if self.Textures[name] then
		return
	end
	
	self.Textures[name] = path
	
	if (not silent) then
		TextureList[name] = path
	end
end

function Media:GetTexture(name)
	if self.Textures[name] then
		return self.Textures[name]
	else
		return self.Textures["Blank"]
	end
end

function Media:GetTextureList()
	return TextureList
end

function Media:SetHighlight(name, path, silent)
	if self.Highlights[name] then
		return
	end
	
	self.Highlights[name] = path
	
	if (not silent) then
		HighlightList[name] = path
	end
end

function Media:GetHighlight(name)
	if self.Highlights[name] then
		return self.Highlights[name]
	else
		return self.Highlights["Blank"]
	end
end

function Media:GetHighlightList()
	return HighlightList
end

function Media:SetTemplate(name, info, silent)
	if self.Templates[name] then
		return
	end
	
	local Key = name
	
	-- Just sprinkling on some flavor. Really rub it in.
	if info["ui-widget-color"] then
		Key = format("|cFF%s%s|r", info["ui-widget-color"], name)
	end
	
	self.Templates[name] = info
	
	if (not silent) then
		TemplateList[Key] = name
	end
end

function Media:GetTemplate(name)
	if self.Templates[name] then
		return self.Templates[name]
	else
		return self.Templates["|cFFFFD54FvUI|r"]
	end
end

function Media:GetTemplateList()
	return TemplateList
end

function Media:ApplyTemplate(name)
	if (not self.Templates[name]) then
		return vUI:print(format('No template exists with the name "%s"', name))
	end
	
	for id, value in pairs(self.Templates[name]) do
		vUISettings[id] = value
		Settings[id] = value
	end
end

-- Some pre-loaded goodness.

-- Textures
Media:SetTexture("Blank", "Interface\\AddOns\\vUI\\Media\\Textures\\Blank.tga")
Media:SetTexture("Bettina", "Interface\\AddOns\\vUI\\Media\\Textures\\Bettina.tga", true)
Media:SetTexture("Ferous", "Interface\\AddOns\\vUI\\Media\\Textures\\Ferous.tga")
Media:SetTexture("Halycon", "Interface\\AddOns\\vUI\\Media\\Textures\\Halycon.tga")
Media:SetTexture("Kola", "Interface\\AddOns\\vUI\\Media\\Textures\\Kola.tga")
Media:SetTexture("noInterrupt", "Interface\\AddOns\\vUI\\Media\\Textures\\noInterrupt.tga", true)
Media:SetTexture("RenHorizonUp", "Interface\\AddOns\\vUI\\Media\\Textures\\RenHorizonUp.tga", true)
Media:SetTexture("RenaitreTunnel", "Interface\\AddOns\\vUI\\Media\\Textures\\RenaitreTunnel.tga", true)
Media:SetTexture("Ferous 4", "Interface\\AddOns\\vUI\\Media\\Textures\\fer4.tga", true)
Media:SetTexture("Ferous 8", "Interface\\AddOns\\vUI\\Media\\Textures\\fer8.tga", true)
Media:SetTexture("Ferous 14", "Interface\\AddOns\\vUI\\Media\\Textures\\fer14.tga", true)
Media:SetTexture("Ferous 16", "Interface\\AddOns\\vUI\\Media\\Textures\\fer16.tga", true)
Media:SetTexture("Ferous 27", "Interface\\AddOns\\vUI\\Media\\Textures\\fer27.tga")
Media:SetTexture("Ferous 35", "Interface\\AddOns\\vUI\\Media\\Textures\\fer35.tga", true)
Media:SetTexture("Mail", "Interface\\AddOns\\vUI\\Media\\Textures\\Mail.tga", true)
Media:SetTexture("MailLight", "Interface\\AddOns\\vUI\\Media\\Textures\\MailLight.tga", true)
Media:SetTexture("pHishTex5", "Interface\\AddOns\\vUI\\Media\\Textures\\pHishTex5.tga")
Media:SetTexture("pHishTex6", "Interface\\AddOns\\vUI\\Media\\Textures\\pHishTex6.tga")
Media:SetTexture("pHishTex7", "Interface\\AddOns\\vUI\\Media\\Textures\\pHishTex7.tga")
Media:SetTexture("pHishTex11", "Interface\\AddOns\\vUI\\Media\\Textures\\pHishTex11.tga")
Media:SetTexture("pHishTex12", "Interface\\AddOns\\vUI\\Media\\Textures\\pHishTex12.tga")
Media:SetTexture("pHishTex28", "Interface\\AddOns\\vUI\\Media\\Textures\\pHishTex28.tga", true)

-- Highlights
Media:SetHighlight("Blank", "Interface\\AddOns\\vUI\\Media\\Textures\\Blank.tga")
Media:SetHighlight("RenHorizonUp", "Interface\\AddOns\\vUI\\Media\\Textures\\RenHorizonUp.tga")
Media:SetHighlight("RenaitreTunnel", "Interface\\AddOns\\vUI\\Media\\Textures\\RenaitreTunnel.tga")
Media:SetHighlight("Ferous 14", "Interface\\AddOns\\vUI\\Media\\Textures\\fer14.tga")

-- Fonts
Media:SetFont("PT Sans", "Interface\\Addons\\vUI\\Media\\Fonts\\PTSans.ttf")
Media:SetFont("Roboto", "Interface\\Addons\\vUI\\Media\\Fonts\\Roboto.ttf")
Media:SetFont("Prototype", "Interface\\Addons\\vUI\\Media\\Fonts\\Prototype.ttf")
Media:SetFont("Mosk Bold", "Interface\\Addons\\vUI\\Media\\Fonts\\MoskBold.ttf")
Media:SetFont("SW Crawl Body", "Interface\\Addons\\vUI\\Media\\Fonts\\SWCrawlBody.ttf")
Media:SetFont("Matthan", "Interface\\Addons\\vUI\\Media\\Fonts\\MatthanSans.ttf", true)
Media:SetFont("Swansea", "Interface\\Addons\\vUI\\Media\\Fonts\\Swansea.ttf")
Media:SetFont("Expressway Bold", "Interface\\Addons\\vUI\\Media\\Fonts\\Expressway.ttf")
Media:SetFont("FranKlein Bold", "Interface\\Addons\\vUI\\Media\\Fonts\\FranKleinBoldRegular.ttf")

-- Colors
Media.Colors[1] = {"FFEBEE", "FCE4EC", "F3E5F5", "EDE7F6", "E8EAF6", "E3F2FD", "E1F5FE", "E0F7FA", "E0F2F1", "E8F5E9", "F1F8E9", "F9FBE7", "FFFDE7", "FFF8E1", "FFF3E0", "FBE9E7", "EFEBE9", "FAFAFA", "ECEFF1"}
Media.Colors[2] = {"FFCDD2", "F8BBD0", "E1BEE7", "D1C4E9", "C5CAE9", "BBDEFB", "B3E5FC", "B2EBF2", "B2DFDB", "C8E6C9", "DCEDC8", "F0F4C3", "FFF9C4", "FFECB3", "FFE0B2", "FFCCBC", "D7CCC8", "F5F5F5", "CFD8DC"}
Media.Colors[3] = {"EF9A9A", "F48FB1", "CE93D8", "B39DDB", "9FA8DA", "90CAF9", "81D4FA", "80DEEA", "80CBC4", "A5D6A7", "C5E1A5", "E6EE9C", "FFF59D", "FFE082", "FFCC80", "FFAB91", "BCAAA4", "EEEEEE", "B0BEC5"}
Media.Colors[4] = {"E57373", "F06292", "BA68C8", "9575CD", "7986CB", "64B5F6", "4FC3F7", "4DD0E1", "4DB6AC", "81C784", "AED581", "DCE775", "FFF176", "FFD54F", "FFB74D", "FF8A65", "A1887F", "E0E0E0", "90A4AE"}
Media.Colors[5] = {"EF5350", "EC407A", "AB47BC", "7E57C2", "5C6BC0", "42A5F5", "29B6F6", "26C6DA", "26A69A", "66BB6A", "9CCC65", "D4E157", "FFEE58", "FFCA28", "FFA726", "FF7043", "8D6E63", "BDBDBD", "78909C"}
Media.Colors[6] = {"F44336", "E91E63", "9C27B0", "673AB7", "3F51B5", "2196F3", "03A9F4", "00BCD4", "009688", "4CAF50", "8BC34A", "CDDC39", "FFEB3B", "FFC107", "FF9800", "FF5722", "795548", "9E9E9E", "607D8B"}
Media.Colors[7] = {"E53935", "D81B60", "8E24AA", "5E35B1", "3949AB", "1E88E5", "039BE5", "00ACC1", "00897B", "43A047", "7CB342", "C0CA33", "FDD835", "FFB300", "FB8C00", "F4511E", "6D4C41", "757575", "546E7A"}
Media.Colors[8] = {"D32F2F", "C2185B", "7B1FA2", "512DA8", "303F9F", "1976D2", "0288D1", "0097A7", "00796B", "388E3C", "689F38", "AFB42B", "FBC02D", "FFA000", "F57C00", "E64A19", "5D4037", "616161", "455A64"}
Media.Colors[9] = {"C62828", "AD1457", "6A1B9A", "4527A0", "283593", "1565C0", "0277BD", "00838F", "00695C", "2E7D32", "558B2F", "9E9D24", "F9A825", "FF8F00", "EF6C00", "D84315", "4E342E", "424242", "37474F"}
Media.Colors[10] = {"B71C1C", "880E4F", "4A148C", "311B92", "1A237E", "0D47A1", "01579B", "006064", "004D40", "1B5E20", "33691E", "827717", "F57F17", "FF6F00", "E65100", "BF360C", "3E2723", "212121", "263238"}

--[[
Media.Colors[1] = {"f17171", "ffa071", "ffd071", "a2d471", "71e2d0", "71d0ff", "7ea9ff", "b38dff", "ff71b7", "a2adb8"}
Media.Colors[2] = {"ee4d4d", "ff884d", "ffc44d", "8bc94d", "4ddbc4", "4dc4ff", "5e94ff", "ad71ff", "ff4da5", "8b98a6"}
Media.Colors[3] = {"d64545", "e57a45", "e5b045", "7db545", "45c5b0", "45b0e5", "5485e5", "9065e5", "e54594", "7d8995"}
]]

-- Templates

-- vUI Default
Media:SetTemplate("vUI", {
	["ui-widget-font"] = "Roboto",
	["ui-header-font"] = "Roboto",
	["ui-button-font"] = "Roboto",
	
	["ui-header-texture"] = "Ferous",
	["ui-widget-texture"] = "Ferous",
	["ui-button-texture"] = "Ferous",
	
	["ui-header-font-color"] = "FFE6C0",
	["ui-header-texture-color"] = "616161",
	["ui-window-bg-color"] = "424242",
	["ui-window-main-color"] = "2B2B2B",
	["ui-widget-color"] = "FFCE54",
	["ui-widget-bright-color"] = "8E8E8E",
	["ui-widget-bg-color"] = "424242",
	["ui-widget-font-color"] = "FFFFFF",
	["ui-button-font-color"] = "FFCE54",
	["ui-button-texture-color"] = "616161",
})

-- Midnight
Media:SetTemplate("Midnight", {
	["ui-widget-font"] = "Prototype",
	["ui-header-font"] = "Prototype",
	["ui-button-font"] = "Prototype",
	
	["ui-header-texture"] = "pHishTex12",
	["ui-widget-texture"] = "pHishTex12",
	["ui-button-texture"] = "pHishTex12",
	
	["ui-header-font-color"] = "EFEBE9",
	["ui-header-texture-color"] = "37474F",
	["ui-window-bg-color"] = "424242",
	["ui-window-main-color"] = "263238",
	["ui-widget-color"] = "81D4FA",
	["ui-widget-bright-color"] = "8E8E8E",
	["ui-widget-bg-color"] = "263238",
	["ui-widget-font-color"] = "FAFAFA",
	["ui-button-font-color"] = "81D4FA",
	["ui-button-texture-color"] = "757575",
})

-- Slate
Media:SetTemplate("Slate", {
	["ui-widget-font"] = "PT Sans",
	["ui-header-font"] = "PT Sans",
	["ui-button-font"] = "PT Sans",
	
	["ui-header-texture"] = "Kola",
	["ui-widget-texture"] = "Kola",
	["ui-button-texture"] = "Ferous 27",
	
	["ui-header-font-color"] = "FAFAFA",
	["ui-header-texture-color"] = "78909C",
	["ui-window-bg-color"] = "37474F",
	["ui-window-main-color"] = "263238",
	["ui-widget-color"] = "BBDEFB",
	["ui-widget-bright-color"] = "263238",
	["ui-widget-bg-color"] = "37474F",
	["ui-widget-font-color"] = "FFFFFF",
	["ui-button-font-color"] = "FAFAFA",
	["ui-button-texture-color"] = "78909C",
})

--Gui.Template = "template"
 -- system where "template" options are available, so that you can use the overall theme, or a custom return value
-- Chaos
Media:SetTemplate("Chaos", {
	["ui-widget-font"] = "Roboto",
	["ui-header-font"] = "Roboto",
	["ui-button-font"] = "Roboto",
	
	["ui-header-texture"] = "pHishTex12",
	["ui-widget-texture"] = "pHishTex12",
	["ui-button-texture"] = "pHishTex12",
	
	["ui-header-font-color"] = "EEEEEE",
	["ui-header-texture-color"] = "3C3C3C",
	["ui-window-bg-color"] = "3C3C3C",
	["ui-window-main-color"] = "2C2C2C",
	["ui-widget-color"] = "9FA8DA",
	["ui-widget-bright-color"] = "757575",
	["ui-widget-bg-color"] = "424242",
	["ui-widget-font-color"] = "EEEEEE",
	["ui-button-font-color"] = "9FA8DA",
	["ui-button-texture-color"] = "616161",
})

-- Unnamed
Media:SetTemplate("Unnamed", {
	["ui-widget-font"] = "Roboto",
	["ui-header-font"] = "Expressway Bold",
	["ui-button-font"] = "Expressway Bold",
	
	["ui-header-texture"] = "Ferous 27",
	["ui-widget-texture"] = "Ferous 27",
	["ui-button-texture"] = "Ferous",
	
	["ui-header-font-color"] = "FAFAFA",
	["ui-header-texture-color"] = "414141",
	["ui-window-bg-color"] = "414141",
	["ui-window-main-color"] = "2B2B2B",
	["ui-widget-color"] = "FF8A65",
	["ui-widget-bright-color"] = "8E8E8E",
	["ui-widget-bg-color"] = "414141",
	["ui-widget-font-color"] = "FAFAFA",
	["ui-button-font-color"] = "FF8A65",
	["ui-button-texture-color"] = "414141",
})