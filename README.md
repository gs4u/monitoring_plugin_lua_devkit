Разберем все функции:
• Все функции:
1 - function GS4u_SendPostData(string APIUrl, table Data, string Token, string HashCode) - Отправка данных на сайт
2 - string SystemOS() - Вернет название ОС на котором используется аддон
3 - function GS4u_UpdateInfo(string APIUrl) - Обновление инфромации с сайта. Вызывайте его при старте сервера
4 - int GS4u_GetCoolDown() - Вернет CoolDown Отправки информации на сайт, вызывайте после GS4u_UpdateInfo(string APIUrl)
5 - string GS4u_GetVersion() - Вернет версию/ии сайта
6 - string GS4u_HashCode_SHA1(table/JSON Data, string Token, bool JSON) - Вернет хешированный SHA1 строку
7 - string sha1(string String) - Вернет хешированный текст

• Все функции для работы с другими аддонами:
1 - function GS4u_SendPostDataEx(string APIUrl, string Token, string HashCode) - Запуск хука, и отправка данных на сайт
2 - function GS4u_AddExTable(table Table, string NTable) - Добавление в глобальную таблицу, таблицу с названием NTable
3 - function GS4u_ClearExTable() - Очистка глобальной таблицы

• Все хуки:
1 - GS4u_PreSendDataEx - Запускается при использовании GS4u_SendPostDataEx, за 2 секунды до отправки данных,
Возвращайте true чтобы функция смогла отправить данные, в случае false отправка данных отменится.

• Пример использования функции с другими аддонами:
sv_monitoring_example_extra_core.lua - Ядро аддона который будет принимать и отправлять данные
sv_monitoring_example_extra_module.lua - Модуль, который добавляет в Ядро данные, за 2 секунды перед отправкой
