﻿
#Область Дополнительные_сведения

Процедура PEN006_ИнициализироватьДополнительныеСведения() Экспорт
	Перем стДанныеПВХ, рефНаборСвойств;
	
	стДанныеПВХ = Новый Структура();
	сИмя = PEN006_ДополнительныеСведенияИмя()[0]; // PEN006_Дата_печати_конверта_РТУ
	стДанныеПВХ.Вставить("Имя", сИмя);
	стДанныеПВХ.Вставить("Наименование", PEN006_ДополнительноеСведениеНаименование(сИмя));
	стДанныеПВХ.Вставить("ТипЗначения", Новый ОписаниеТипов("Дата",,,Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
	рефНаборСвойств = Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_РеализацияТоваровУслуг;
	PEN006_ИнициализироватьДополнительноеСведение(рефНаборСвойств, стДанныеПВХ);
	
	стДанныеПВХ = Новый Структура();
	сИмя = PEN006_ДополнительныеСведенияИмя()[1]; // PEN006_Дата_отправки_e-mail_РТУ
	стДанныеПВХ.Вставить("Имя", сИмя);
	стДанныеПВХ.Вставить("Наименование", PEN006_ДополнительноеСведениеНаименование(сИмя));
	стДанныеПВХ.Вставить("ТипЗначения", Новый ОписаниеТипов("Дата",,,Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
	рефНаборСвойств = Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_РеализацияТоваровУслуг;
	PEN006_ИнициализироватьДополнительноеСведение(рефНаборСвойств, стДанныеПВХ);
	
	стДанныеПВХ = Новый Структура();
	сИмя = PEN006_ДополнительныеСведенияИмя()[2]; // PEN006_Дата_отправки_e-mail_Счет
	стДанныеПВХ.Вставить("Имя", сИмя);
	стДанныеПВХ.Вставить("Наименование", PEN006_ДополнительноеСведениеНаименование(сИмя));
	стДанныеПВХ.Вставить("ТипЗначения", Новый ОписаниеТипов("Дата",,,Новый КвалификаторыДаты(ЧастиДаты.ДатаВремя)));
	рефНаборСвойств = Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_СчетНаОплатуПокупателю;
	PEN006_ИнициализироватьДополнительноеСведение(рефНаборСвойств, стДанныеПВХ);
	
КонецПроцедуры

Функция PEN006_ЕстьДополнительныеСведения() Экспорт
	Перем бЕстьДополнительныеСведения, рефПВХ;
	
	бЕстьДополнительныеСведения = Истина;
	
	Для каждого сИмяСведения Из PEN006_ДополнительныеСведенияИмя() Цикл
		рефПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", сИмяСведения);
		Если рефПВХ.Пустая() Тогда
			бЕстьДополнительныеСведения = Ложь;
			Возврат бЕстьДополнительныеСведения;
		КонецЕсли;
	КонецЦикла;
	
	Возврат бЕстьДополнительныеСведения;
КонецФункции

Процедура PEN006_ЗаполнитьДополнительноеСведение(Знач рефДокумент, Знач рефПВХ, Знач Значение) Экспорт
	Перем МенеджерЗаписи;
	
	МенеджерЗаписи = РегистрыСведений.ДополнительныеСведения.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Объект = рефДокумент;
	МенеджерЗаписи.Свойство = рефПВХ;
	МенеджерЗаписи.Значение = Значение;
	МенеджерЗаписи.Записать(Истина);
	
КонецПроцедуры

// Начальная инициализация дополнительного сведения
//
// Параметры:
//  рефНаборСвойств	 - СправочникСсылка - ссылка на предопределенный элемент (набор свойств)
//    справочника НаборыДополнительныхРеквизитовИСведений.
//    Например: Справочники.НаборыДополнительныхРеквизитовИСведений.Документ_РеализацияТоваровУслуг
//  стДанныеПВХ	 - Структура - структура с данными для создания нового элемента в
//    плане видов характеристик ДополнительныеРеквизитыИСведения. Поля структуры:
//    * Имя - Строка - имя дополнительного сведения (для разработчика)
//    * Наименование - Строка - наименование дополнительного сведения
//    * ТипЗначения - ОписаниеТипа - описание типа, которое должно быть у нового дополнительного сведения
//
Процедура PEN006_ИнициализироватьДополнительноеСведение(рефНаборСвойств, стДанныеПВХ)
	Перем оНаборСвойств, рефПВХ, оПВХ, ТабличнаяЧасть;
	
	// Новое дополнительное сведение.
	рефПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", стДанныеПВХ.Имя);
	Если рефПВХ.Пустая() Тогда
		оПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.СоздатьЭлемент();
		оПВХ.Имя = стДанныеПВХ.Имя;
		оПВХ.Наименование = стДанныеПВХ.Наименование;
		оПВХ.Заголовок = стДанныеПВХ.Наименование;
		оПВХ.ТипЗначения = стДанныеПВХ.ТипЗначения;
		оПВХ.НаборСвойств = рефНаборСвойств;
		
		оПВХ.ЭтоДополнительноеСведение = Истина;
		оПВХ.Доступен = Истина;
		оПВХ.Виден = Истина;
		оПВХ.Записать();
		
		рефПВХ = оПВХ.Ссылка;
	КонецЕсли;
	
	// Подключение дополнительного сведения к набору дополнительных реквизитов и свойств
	оНаборСвойств = рефНаборСвойств.ПолучитьОбъект();
	ТабличнаяЧасть = оНаборСвойств.ДополнительныеСведения;
	НайденнаяСтрока = ТабличнаяЧасть.Найти(рефПВХ, "Свойство");
	Если НайденнаяСтрока = Неопределено Тогда
		НоваяСтрока = ТабличнаяЧасть.Добавить();
		НоваяСтрока.Свойство = рефПВХ;
		оНаборСвойств.Записать();
	КонецЕсли;
	
КонецПроцедуры

Функция PEN006_ДополнительныеСведенияИмя() Экспорт
	Перем мИмена;
	
	// { PEN 03.06.2021 # $ Не менять. Используется литерал в
	// Документ РТУ модуль формы списка - PEN006_СписокПриПолученииДанныхНаСервереПеред
	// Документ Счет покупателю модуль формы списка - PEN006_СписокПриПолученииДанныхНаСервереПеред
	
	мИмена = Новый Массив();
	мИмена.Добавить("PEN006_Дата_печати_конверта_РТУ");
	мИмена.Добавить("PEN006_Дата_отправки_e-mail_РТУ");
	мИмена.Добавить("PEN006_Дата_отправки_e-mail_Счет");
	
	Возврат мИмена;
КонецФункции

Функция PEN006_ДополнительноеСведениеНаименование(сИмя)
	Перем сНаименование, мИмя;
	
	мИмя = СтрРазделить(сИмя, "_");
	мИмя.Удалить(мИмя.Количество() - 1);
	мИмя.Удалить(0);
	сНаименование = СтрСоединить(мИмя, " ");
	
	Возврат сНаименование;
КонецФункции

#КонецОбласти

#Область Заполнить_Документы

Процедура PEN006_ЗаполнитьДатаПечатиКонверта_РТУ(мДокументы) Экспорт
	
	Если НЕ PEN006_ЕстьДополнительныеСведения() Тогда
		PEN006_ИнициализироватьДополнительныеСведения();
	КонецЕсли;
	
	рефПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", PEN006_ДополнительныеСведенияИмя()[0]);
	Значение = ТекущаяДата();
	
	Для каждого рефДокумент Из мДокументы Цикл
		PEN006_ЗаполнитьДополнительноеСведение(рефДокумент, рефПВХ, Значение);
	КонецЦикла;
	
КонецПроцедуры

Процедура PEN006_ЗаполнитьДатаОтправкиEMail(мДокументы) Экспорт
	
	Если НЕ PEN006_ЕстьДополнительныеСведения() Тогда
		PEN006_ИнициализироватьДополнительныеСведения();
	КонецЕсли;
	
	Значение = ТекущаяДата();
	
	Для каждого рефДокумент Из мДокументы Цикл
		Если ТипЗнч(рефДокумент) = Тип("ДокументСсылка.РеализацияТоваровУслуг") Тогда
			рефПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", PEN006_ДополнительныеСведенияИмя()[1]);
		ИначеЕсли ТипЗнч(рефДокумент) = Тип("ДокументСсылка.СчетНаОплатуПокупателю") Тогда
			рефПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", PEN006_ДополнительныеСведенияИмя()[2]);
		Иначе
			Продолжить;
		КонецЕсли;
		
		PEN006_ЗаполнитьДополнительноеСведение(рефДокумент, рефПВХ, Значение);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Модификация_динамического_списка

// Добавить в динамический список поле "КартинкаПочта"
//
// Параметры:
//  оФорма	 - Форма клиентского приложения - форма в которой модифицируется
//    динамический список
//
Процедура PEN006_ИзменитьЗапросСписка(Знач оФорма) Экспорт
	Перем сТекстЗапроса, СхемаЗапроса, ЗапросВыбора, ВыбираемыеПоля;
	
	// исходный текст запроса динамического списка
	сТекстЗапроса = оФорма.Список.ТекстЗапроса;
	
	СхемаЗапроса = Новый СхемаЗапроса();
	СхемаЗапроса.УстановитьТекстЗапроса(сТекстЗапроса);
	ЗапросВыбора = СхемаЗапроса.ПакетЗапросов[0];
	ВыбираемыеПоля = ЗапросВыбора.Операторы[0].ВыбираемыеПоля;
	ВыбираемыеПоля.Добавить("0");
	ЗапросВыбора.Колонки.Найти("Поле1").Псевдоним = "КартинкаПочта";
	сТекстЗапроса = СхемаЗапроса.ПолучитьТекстЗапроса();
	
	// модифицированный запрос загружается в динамический список
	оФорма.Список.ТекстЗапроса = сТекстЗапроса;
	оФорма.Список.УстановитьОбязательноеИспользование("КартинкаПочта", Истина);
	
КонецПроцедуры

// Заполнить поле списка "КартинкаПочта" индексами при получении очередной
//  порции не сервере
//
// Параметры:
//  Строки		 - СтрокиДинамическогоСписка - коллекция строк динамического списка
//    в текущей порции данных
//  соСвойства	 - Соответствие - соответствие с наименованием дополнительного сведения и
//    соответствующего ему индекса иконки
//
Процедура PEN006_МодификацияСпискаПриПолученииДанныхНаСервере(Строки, соСвойства) Экспорт
	Перем Запрос, Выборка, СтрокаСписка, мСвойства, сШаблонЗапрос, сШаблонКогда, сСтрокаКогда, оПВХ;
	
	// Подготовка данных для дозаполнения динамического списка
	
	сШаблонЗапрос = "ВЫБРАТЬ
	|	ДополнительныеСведения.Объект КАК рефДокумент,
	|	СУММА(ВЫБОР
	|			%1
	|		КОНЕЦ) КАК КартинкаПочта
	|ИЗ
	|	РегистрСведений.ДополнительныеСведения КАК ДополнительныеСведения
	|ГДЕ
	|	ДополнительныеСведения.Объект В(&Объекты)
	|	И ДополнительныеСведения.Свойство В(&Свойства)
	|
	|СГРУППИРОВАТЬ ПО
	|	ДополнительныеСведения.Объект";
	
	сШаблонКогда = "КОГДА ДополнительныеСведения.Свойство.Имя = ""%1""
	|	ТОГДА %2
	|";
	
	мСвойства = Новый Массив();
	сСтрокаКогда = "";
	оПВХ = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения;
	
	Для каждого Свойство Из соСвойства Цикл
		мСвойства.Добавить(оПВХ.НайтиПоРеквизиту("Имя", Свойство.Значение));
		сСтрокаКогда = сСтрокаКогда + СтрШаблон(сШаблонКогда, Свойство.Значение, Свойство.Ключ);
	КонецЦикла;
	
	Запрос = Новый Запрос();
	Запрос.Текст = СтрШаблон(сШаблонЗапрос, сСтрокаКогда);
	Запрос.УстановитьПараметр("Объекты", Строки.ПолучитьКлючи());
	Запрос.УстановитьПараметр("Свойства", мСвойства);
	
	// Дозаполнение динамического списка данными
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СтрокаСписка = Строки[Выборка.рефДокумент];
		СтрокаСписка.Данные.КартинкаПочта = Выборка.КартинкаПочта;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
