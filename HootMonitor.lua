-- HootMonitor Code File
-- Hateduck / Olgruff fun addons for fun
-- 30 MAR 2020 (COVID-19 Boredom)

-- Moonkin Name to track
moonkinName = "momokiki"
hootz = {5357, 5358, 5360}

-- Function for loading addon. Fired from HootMonitor.xml
function HootMonitor_OnLoad()
	-- Slash Command Registry Variables
	SLASH_HOOTMONITORTOG1, SLASH_HOOTMONITORSET1 = '/hoot', '/hootset';
	
	-- Register functions to slash command
	local function hoot_mon_toggle_local(msg)
		HootMonitor_Toggle(msg)
	end

	local function hoot_mon_set_local(msg)
		HootMonitor_SetMoonkin(msg)
	end

	-- Add to blizzard built /command table
    SlashCmdList["HOOTMONITORTOG"] = hoot_mon_toggle_local
    SlashCmdList["HOOTMONITORSET"] = hoot_mon_set_local

    -- Register Event By default to start
	HMMain:RegisterEvent("CHAT_MSG_EMOTE");
	HMMain:Hide();

	-- Print a happy little message that things loaded ok
	printcolor(cORANGEY, "Hoot Monitor loaded successfully!")
	HootMonitor_PrintUsage()
end

-- slash command callback to disable hooting
function HootMonitor_Toggle(msg)
	if (msg == "disable") then
		HMMain:UnregisterEvent("CHAT_MSG_EMOTE")
		print("HootMonitor: Disabled")
	elseif (msg == "enable") then
		HMMain:RegisterEvent("CHAT_MSG_EMOTE")
		print("HootMonitor: Enabled")
	else
		HootMonitor_PrintUsage()
	end
end

-- slash command callback to set target who is allowed to trigger hoots
function HootMonitor_SetMoonkin(msg)
	print("Setting Moonkin to receive hoots from to : "..msg)
	moonkinName = msg
end

-- Event handler fired by frame created in HootMonitor
function HootMonitor_Respond(self, event, ...)
	if event == "CHAT_MSG_EMOTE" then
		-- Save varargs ... first 2 returns that we care about
		local text, playerName = ...

		-- Make lower case for string comparison
		lowerText = string.lower(text)
		lowerPlayerName = string.lower(playerName)

		-- If desired moonkin name is emoter and emote says "hoot" at all, play sound
		if (string.find(lowerPlayerName, moonkinName) and string.find(lowerText, "hoot")) then
			hootToPlay=math.random(1, 100.0/33)
			PlaySound(hootz[hootToPlay])
		end
	end	
end

-- Print out the slash command usage
function HootMonitor_PrintUsage()
	printcolor(cSEXHOTPINK, "=== Hoot Monitor Usage ===")
	printcolor(cSEXHOTPINK, "/hoot enable - enables hoot sounds")
	printcolor(cSEXHOTPINK, "/hoot disable - disables hoot sounds")
	printcolor(cSEXHOTPINK, "/hootset <moonkin name> - sets <moonkin name> to your moonkin of choice.")
end
--=================== UTILITY ====================


function printcolor(hex, guts)
    DEFAULT_CHAT_FRAME:AddMessage("|"..hex..guts);  
end

--======================= Color Codes for print color ==============================================

cLIGHTRED               =   "cffff6060"
cLIGHTBLUE              =   "cff00ccff"
cTORQUISEBLUE           =   "cff00C78C"
cSPRINGGREEN            =   "cff00FF7F"
cGREENYELLOW            =   "cffADFF2F"
cBLUE                   =   "cff0000ff"
cPURPLE                 =   "cffDA70D6"
cGREEN                  =   "cff00ff00"
cRED                    =   "cffff0000"
cGOLD                   =   "cffffcc00"
cGOLD2                  =   "cffFFC125"
cGREY                   =   "cff888888"
cWHITE                  =   "cffffffff"
cSUBWHITE               =   "cffbbbbbb"
cMAGENTA                =   "cffff00ff"
cYELLOW                 =   "cffffff00"
cORANGEY                =   "cffFF4500"
cCHOCOLATE              =   "cffCD661D"
cCYAN                   =   "cff00ffff"
cIVORY                  =   "cff8B8B83"
cLIGHTYELLOW            =   "cffFFFFE0"
cSEXGREEN               =   "cff71C671"
cSEXTEAL                =   "cff388E8E"
cSEXPINK                =   "cffC67171"
cSEXBLUE                =   "cff00E5EE"
cSEXHOTPINK             =   "cffFF6EB4"