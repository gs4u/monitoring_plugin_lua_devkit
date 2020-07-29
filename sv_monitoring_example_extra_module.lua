hook.Add("GS4u_PreSendDataEx", "Module_JobsListDescription", function()
	local TableJobs = {}									-- Локальная таблица
	TableJobs["name"] = "jobs" 								-- Название дополнительной вкладки
	TableJobs["data"] = {}									-- Общая таблица для хранения информации о всех профессиях
	for k,v in pairs(RPExtraTeams) do
		local TJ 	= {}									-- Локальная таблица
		TJ["data"] 	= {}									-- Таблица для хранения информации о профессий
		TJ["name"] 					= v.category			-- Категория которая входит данная профессия
		TJ["data"]["name"] 			= v.name				-- Название профессий
		TJ["data"]["description"] 	= v.description 		-- Описание профессии
		TJ["data"]["salary"] 		= v.salary				-- Зарплата профессии
		table.insert(TableJobs["data"], TJ)					-- Добавление в общую таблицу хранения о всех профессиях
		TJ = nil											-- Очистка таблицы во избежание утечки памяти
	end
	GS4u_AddExTable(TableJobs, "tabs")						-- Добавление таблицы на отправку GS4u_SendPostDataEx()
	TableJobs = nil											-- Очистка таблицы во избежание утечки памяти
	return true												-- Возвращайте true чтобы скрипт смог отправить все данные, если false, не какие данные не смогут отправиться!
end)