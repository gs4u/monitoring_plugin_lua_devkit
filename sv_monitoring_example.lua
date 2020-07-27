local APIUrl 	= "https://api.gs4u.net/" 	-- Адресс API
local Token 	= ""						-- Токен вашего сервера
local IDServer	= ""						-- ID Вашего сервера
GS4u_UpdateInfo(APIUrl)						-- Обновить данные. CoolDown Version - Вызывайте один раз, допустим при старте сервера
											-- Вызывайте его перед получением данных о версии или CoolDown
timer.Simple(1, function()
	print("CoolDown: "..GS4u_GetCoolDown()) -- Получение CoolDown на отправку данных, можно сделать обычный таймер с беск.циклом
	local T = {} 	-- Общая таблица
	T["p"] 	= {} 	-- Таблица списка игроков
	T["e"] 	= {} 	-- Данные сервера, переменные и прочее
	T["e"]["id"] = IDServer -- IP Вашего сервера
	T["e"]["os"] = SystemOS()

	for i, v in ipairs(player.GetAll()) do 		-- Цикл по игрокам с добавлением: Nick, SteamID64, IPAddress
		if (v:IsValid() and v:IsPlayer()) then 	-- Проверка игрока что он является действительным и является игроком, а не ботом
			local PT = {}					-- Локальная таблица для добавлении информации
			PT["name"] = v:Nick()			-- Ник игрока
			PT["steamid"] = v:SteamID64()	-- SteamID64 игрока
			PT["ipaddress"] = v:IPAddress()	-- IP игрока
			table.insert(T["p"], PT) 		-- Добавление информации в общую таблицу
			PT = nil						-- Очистка таблицы во избежании утечек памяти
		end
	end
	GS4u_SendPostData(APIUrl, T, Token, "sha1")	-- Отправка данных на API без Debug
	T = nil
end)