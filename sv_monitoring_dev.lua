include("sha1.lua")

GS4uData = {}
local CoolDown 	= 0
local Version 	= "0"

function SystemOS()
	if (system.IsLinux()) then return "Linux" elseif (system.IsWindows()) then return "Windows" elseif (system.IsOSX()) then return "OSX" end
end

function GS4u_UpdateInfo(APIUrl)
	http.Fetch(APIUrl.."?cmd=getCoolDown&data={\"cmd\":\"updateServer\"}", function(CallBack)
		CoolDown = tonumber(CallBack)
	end)
	http.Fetch(APIUrl.."?cmd=getVersion", function(CallBack)
		Version = CallBack
	end)
end

function GS4u_GetCoolDown()
	return CoolDown
end

function GS4u_GetVersion()
	return Version
end

function GS4u_AddExTable(Table, NTable)
	if (GS4uData[NTable]) then table.insert(GS4uData[NTable], Table) 
	else GS4uData[NTable] = {} table.insert(GS4uData[NTable], Table) end
end

function GS4u_ClearExTable()
	GS4uData = {}
end

function GS4u_SendPostDataEx(APIUrl, Token, HashCode)
	local Table = {}
	if not (hook.Run("GS4u_PreSendDataEx")) then return end
	timer.Simple(2, function()
		local D = string.Replace(util.TableToJSON(GS4uData), "\t", "") D = string.Replace(D, "\n", "[br]") D = string.Replace(D, "\"", "") D = string.Replace(D, "\\", "")
		Table["cmd"] = "updateServer" Table["data"] = D Table["s"] = GS4u_HashCode_SHA1(GS4uData, Token, false) Table["hash"] = HashCode
		http.Post(APIUrl, Table, function(CallBack_Code)
			if (CallBack_Code ~= "0" or CallBack_Code == "") then print(CallBack_Code) end
		end, 
		function(F)
			print(F)
		end)

		print(util.TableToJSON(GS4uData))

		GS4uData = {}
	end)
end

function GS4u_SendPostData(APIUrl, Data, Token, HashCode)
	local Table = {}
	Data = string.Replace(util.TableToJSON(Data), "\t", "") Data = string.Replace(Data, "\n", "[br]") Data = string.Replace(Data, "\"", "") Data = string.Replace(Data, "\\", "")
	Table["cmd"] = "updateServer" Table["data"] = util.TableToJSON(Data) Table["s"] = GS4u_HashCode_SHA1(Data, Token, false) Table["hash"] = HashCode
	http.Post(APIUrl, Table, function(CallBack_Code)
		if (CallBack_Code ~= "0" or CallBack_Code == "") then print(CallBack_Code) end
	end, 
	function(F)
		print(F)
	end)
end

function GS4u_HashCode_SHA1(Data, Token, JSON)
	if not (JSON) then return sha1(util.TableToJSON(Data)..Token)
	else return sha1(Data) end
end