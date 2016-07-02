-- German localization file for deDE
local AceLocale = LibStub:GetLibrary('AceLocale-3.0');
local L = AceLocale:NewLocale('ElvUI', 'deDE');
if not L then return; end

-- Core
L[' is loaded.'] = " ist geladen."

-- General Options
L['Plugin for |cff1784d1ElvUI|r by\nMerathilis.'] = "Plugin für |cff1784d1ElvUI|r von\nMerathilis."
L['by Merathilis (EU-Shattrath)'] = "von Merathilis (EU-Shattrath)"
L['MerathilisUI is an external ElvUI mod. Mostly it changes the Look of your UI. It is high recommended that you download |cff00c0faElvUI BenikUI|r to get the whole Style.\n\nNew Function are marked with:'] = "MerathilisUI ist ein externer ElvUI Mod. Es ändert hauptsächlich nur den Look von eurem UI. Um den kompletten Style zu erreichen wird empfohlen |cff00c0faElvUI BenikUI|r herrunter zu laden.\n\nNeue Funktionen sind gekennzeichnet mit:"
L['AFK'] = true
L['Enable/Disable the MUI AFK Screen'] = "Aktiviert/Deaktiviert den MUI AFK Bildschirm"
L['SplashScreen'] = "Startbildschirm"
L['Enable/Disable the Splash Screen on Login.'] = "Aktiviert/Deaktiviert den Startbildschirm beim Login."
L['Options'] = "Einstellungen"
-- LoginMessage
L['Enable/Disable the Login Message in Chat'] = "Aktiviert/Deaktiviert die Login Nachricht im Chat"

-- Chat
L['CHAT_AFK'] = "[AFK]"
L['CHAT_DND'] = "[DND]"
L["has come |cff298F00online|r."] = "ist jetzt |cff298F00online|r."
L["has gone |cffff0000offline|r."] = "ist jetzt |cffff0000offline|r."
L["Unknown"] = "Unbekannt"

-- Information
L['Information'] = true
L['Support & Downloads'] = true
L['Tukui.org'] = true
L['Git Ticket tracker'] = true
L['Curse.com'] = true
L['Coding'] = true
L['Testing & Inspiration'] = "Tester & Inspiration"
L['My other Addon'] = "Mein anderes Addon"
L['ElvUI Tooltip Icon'] = true
L['Adds an Icon for Spells, Items and Achievements (only GameTooltip) to the Tooltip.'] = "Zeigt ein Symbol für Zauber, Gegenstände und Erfolge (nur Spieltooltip) am Tooltip an."

-- GameMenu
L['GameMenu'] = "Spielmenü"
L['Enable/Disable the MerathilisUI Style from the Blizzard GameMenu.'] = "Aktiviert/Deaktiviert den MerathilisUI Style aus dem Blizzard Spielmenü."

-- FlightMode
L['FlightMode'] = "Flugmodus"
L['Enable/Disable the MerathilisUI FlightMode.\nTo completely disable the FlightMode go into the |cff00c0faBenikUI|r Options.'] = "Aktiviert/Deaktiviert den MerathilisUI Flugmodus.\nUm den Flugmodus komplett zu deaktivieren gehe bitte in die |cff00c0faBenikUI|r Optionen."

-- moveBlizz
L['moveBlizz'] = true
L['Make some Blizzard Frames movable.'] = "Erlaubt das Verschieben einiger Blizzardfenster."

-- MasterPlan
L['MasterPlan'] = true
L['Skins the additional Tabs from MasterPlan.'] = "Skint die zusätzlichen Tabs von MasterPlan."
L['Misc'] = "Verschiedenes"

-- TooltipIcon
L['Tooltip Icon'] = true
L['Adds an Icon for Items/Spells/Achievement on the Tooltip'] = "Fügt ein Symbol für Gegenstände/Zauber/Erfolge am Tooltip hinzu"

-- GarrisonAlertFrame
L['Garrison Alert Frame'] = "Garnision Alarm Fenster"
L['Hides the Garrison Alert Frame while in combat.'] = "Versteckt das Garnision Alarm Fenster während des Kampfes."

-- MailInputBox
L['Mail Inputbox Resize'] = "Post Eingabefeld"
L['Resize the Mail Inputbox and move the shipping cost to the Bottom'] = "Verändert die Größe des Post Eingabefeldes und verschiebt die Versandkosten."

-- Friend Alert
L['Battle.net Alert'] = "Battle.net Alarm"
L['Shows a Chat notification if a Battle.net Friend switch Games or goes offline.'] = "Zeigt eine Chatbenachrichtigung wenn ein Battle.net Freund ein Spiel wechselt oder offline geht."
L["%s stopped playing (%sIn Battle.net)."] = "%s spielt nicht mehr (%sIn Battle.net)."
L["%s is now playing (%s%s)."] = "%s spielt jetzt (%s%s)"

-- System Datatext
L["(Hold Shift) Memory Usage"] = "(Halte Shift) Speichernutzung"
L["Announce Freed"] = "Freigegeben ankündigen "
L["Announce how much memory was freed by the garbage collection."] = "Kündige an, wieviel Spreicher bei der Bereinigung freigegeben wurde."
L["Bandwidth"] = "Bandbreite"
L["Display world or home latency on the datatext. Home latency refers to your realm server. World latency refers to the current world server."] = "Zeige die Welt- oder Heimlatenz im Infotext. Heimlatenz bezieht sich auf die Realm Server. Weltlatenz bezieht sich auf die Welt Server."
L["Download"] = ""
L["FPS"] = true
L["Garbage Collect"] = "Müll aufräumen"
L["Garbage Collection Freed"] = "Müll gesäubert"
L["Home"] = "Heim"
L["Home Latency:"] = "Heimlatenz:"
L["Latency Type"] = "Latenztyp"
L["Left Click:"] = "Links Klick:"
L["Loaded Addons:"] = "Geladene Addons:"
L["MS"] = true
L["Max Addons"] = true
L["Maximum number of addons to show in the tooltip."] = "Maximale Addons die im Tooltip angezeigt werden."
L["Reload UI"] = "UI neuladen"
L["Right Click:"] = "Rechts Klick:"
L["Show FPS"] = "Zeige FPS"
L["Show FPS on the datatext."] = "Zeige FPS auf dem Infotext."
L["Show Latency"] = "Zeige Latenz"
L["Show Memory"] = "Zeige Speicher"
L["Show latency on the datatext."] = "Zeige Latenz auf dem Infotext."
L["Show total addon memory on the datatext."] = "Zeige Addonspeichernutzung auf dem Infotext."
L["System Datatext"] = "System Infotext"
L["Total Addons:"] = "Gesamte Addons:"
L["Total CPU:"] = "Gesamte CPU:"
L["Total Memory:"] = "Gesamter Speicher:"
L["World"] = "Welt"
L["World Latency:"] = "Weltlatenz"

-- Unitframes
L["Default"] = "Standard"
L["Red Icon"] = "Rotes Symbol"

-- Install
L['Welcome'] = "Willkommen"
L['MerathilisUI Set'] = "MerathilisUI gesetzt"
L[' - %s profile created!'] = " - %s Profil erstellt!"
L['Actionbars Set'] = "Aktionsleisten gesetzt"
L['Addons Set'] = "Addons gesetzt"
L['DataTexts Set'] = "Infotexte gesetzt"
L['Unitframes Set'] = "Einheitenfenster gesetzt"
L['Welcome to MerathilisUI |cff00c0faVersion|r %s, for ElvUI %s.'] = "Willkommen zu MerathilisUI |cff00c0faVersion|r %s für ElvUI %s."
L["By pressing the Continue button, MerathilisUI will be applied in your current ElvUI installation.\r|cffff8000 TIP: It would be nice if you apply the changes in a new profile, just in case you don't like the result.|r"] = "Durch drücken der Weiter-Taste werden die MerathilisUI Änderungen in der vorhandenen ElvUI Installation angewand.\r|cffff8000 TIP: Es wäre gut, wenn Du die Änderungen in einem neuen Profil erstellst. Nur für den Fall dass Du mit den Änderungen nicht zufrieden bist.|r"
L['Layout'] = true
L['Buttons must be clicked twice'] = "Bitte zweimal anklicken"
L['This part of the installation process sets up your chat fonts and colors.'] = "Dieser Teil des Installationsprozesses ändert die Chatschrifart und -farbe."
L['This part of the installation changes the default ElvUI look.'] = "Dieser Teil der Installation ändert das standard Aussehen von ElvUI."
L["This part of the installation process will fill MerathilisUI datatexts.\r|cffff8000This doesn't touch ElvUI datatexts|r"] = "Diese Einstellungen füllt die Infotexte.\r|cffff8000Die Einstellungen der Infotexte von ElvUI wird nicht verändert|r"
L['This part of the installation process will reposition your Actionbars and will enable backdrops'] = "Dieser Teil des Installationsprozesses wird die Aktionsleisten neu positionieren und wird den Hintergrund einschalten"
L["This part of the installation process will reposition your Unitframes."] = "Dieser Teil der Installation positioniert die Einheitenfenster."
L['This part of the installation process will apply changes to Skada and ElvUI plugins'] = "Dieser Abschnitt wird Änderungen an den Addons vornehmen, wie Skada und ElvUI Plugins"
L['Please click the button below to apply the new layout.'] = "Bitte drücke die Taste unten, um das neue Layout anzuwenden."
L['Please click the button below to setup your chat windows.'] = "Bitte klick auf die Taste unten, um das Chatfenster einzustellen."
L['Please click the button below to setup your actionbars.'] = "Bitte klick auf die Taste unten, um die Aktionsleisten einzustellen."
L['Please click the button below to setup your datatexts.'] = "Bitte drücke die Taste unten, um die Infotexte einzustellen."
L['Please click the button below to setup your Unitframes.'] = "Bitte drücke die Taste unten, um die Einheitenfenster einzustellen."
L['Please click the button below to setup your addons.'] = "Bitte drücke die Taste unten, um die Addons einzustellen."
L['Setup ActionBars'] = "Aktionsleisten einstellen"
L['Setup Unitframes'] = "Einheitenfenster einstellen"
L['DataTexts'] = "Infotexte"
L['Setup Addons'] = "Addons einstellen"
L['Finish'] = "Fertig"
L['Installed'] = "Installiert"

-- Staticpopup
L["To get the whole MerathilisUI functionality and look it's recommended that you download |cff00c0faElvUI_BenikUI|r!"] = "Um alle Funktionen und das Aussehen von MerathilisUI zu erlangen, lade dir bitte |cff00c0faElvUI_BenikUI|r herrunter!"
L["MSG_MER_ELV_OUTDATED"] = "Deine Version von ElvUI ist älter wie die empfohlene Version um |cffff7d0aMerathilisUI|r zu nutzen. Deine Version ist |cff00c0fa%.2f|r (empfohlen ist |cff00c0fa%.2f|r). MerathilisUI ist nicht geladen! Bitte aktuallisiere dein ElvUI."

-- Addons
L["BigWigs"] = true
L["MasterPlan"] = true
L["Shadow & Light"] = true
