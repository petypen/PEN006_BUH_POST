
&НаСервере
Процедура PEN006_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	PEN006_ОбщийМодульВызовСервера.PEN006_ИзменитьЗапросСписка(ЭтотОбъект);
	PEN006_МодификацияИнтерфейсаСервер.PEN006_ТаблицаФормыДобавитьЭлемент(ЭтотОбъект, "КартинкаПочта");
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура PEN006_СписокПриПолученииДанныхНаСервереПеред(ИмяЭлемента, Настройки, Строки)
	Перем соСвойства;
	
	соСвойства = Новый Соответствие();
	соСвойства.Вставить("2", "PEN006_Дата_отправки_email_Счет");
	
	PEN006_ОбщийМодульВызовСервера.PEN006_МодификацияСпискаПриПолученииДанныхНаСервере(Строки, соСвойства);
	
КонецПроцедуры
