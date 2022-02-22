﻿
&НаСервере
Процедура РЗ_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	Перем ТекстЗапросаПроверка, ТекстЗапросаНовый;
	
	ТекстЗапросаПроверка = "ВЫБРАТЬ
	|	СправочникНоменклатура.Ссылка КАК Номенклатура,
	|	ЕСТЬNULL(ХозрасчетныйОстатки.КоличествоОстаток, 0) КАК КоличествоОстаток,
	|	ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Валюта, ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка)) КАК Валюта,
	|	ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Цена, 0) КАК Цена,
	|	ХозрасчетныйОстатки.Счет КАК СчетУчета
	|ИЗ
	|	Справочник.Номенклатура КАК СправочникНоменклатура
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних({(&ДатаЦены)}, {(Номенклатура).* КАК Ссылка, (ТипЦен) КАК ТипЦен, (Валюта) КАК Валюта}) КАК ЦеныНоменклатурыСрезПоследних
	|		ПО СправочникНоменклатура.Ссылка = ЦеныНоменклатурыСрезПоследних.Номенклатура}
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрБухгалтерии.Хозрасчетный.Остатки({(&ДатаОстатки)}, {(Счет).* КАК Счет}, {(&ВидыСубконто)}, {(ВЫРАЗИТЬ(Субконто1 КАК Справочник.Номенклатура)).* КАК Номенклатура, (Субконто2)}) КАК ХозрасчетныйОстатки
	|		ПО СправочникНоменклатура.Ссылка = ХозрасчетныйОстатки.Субконто1
	|			И (ХозрасчетныйОстатки.КоличествоОстаток > 0)}
	|ГДЕ
	|	НЕ СправочникНоменклатура.ЭтоГруппа
	|	И ВЫБОР
	|			КОГДА &ПоказыватьТолькоОстатки
	|				ТОГДА ЕСТЬNULL(ХозрасчетныйОстатки.КоличествоОстаток, 0) > 0
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|{ГДЕ
	|	СправочникНоменклатура.Ссылка.* КАК Номенклатура}";
	
	ТекстЗапросаНовый = "ВЫБРАТЬ
	|	СправочникНоменклатура.Ссылка КАК Номенклатура,
	|	ЕСТЬNULL(ХозрасчетныйОстатки.КоличествоОстаток, 0) КАК КоличествоОстаток,
	|	ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Валюта, ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка)) КАК Валюта,
	|	ЕСТЬNULL(ЦеныНоменклатурыСрезПоследних.Цена, 0) КАК Цена,
	|	ХозрасчетныйОстатки.Счет КАК СчетУчета,
	|	ЕСТЬNULL(ЗарезервированныеТовары.КоличествоОстаток, 0) КАК КоличествоЗарезервировано,
	|	ЕСТЬNULL(ПотребностьВТоварах.КоличествоОстаток, 0) КАК КоличествоПотребность
	|ИЗ
	|	Справочник.Номенклатура КАК СправочникНоменклатура
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних({(&ДатаЦены)}, {(Номенклатура).* КАК Ссылка, (ТипЦен) КАК ТипЦен, (Валюта) КАК Валюта}) КАК ЦеныНоменклатурыСрезПоследних
	|		ПО СправочникНоменклатура.Ссылка = ЦеныНоменклатурыСрезПоследних.Номенклатура}
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрБухгалтерии.Хозрасчетный.Остатки({(&ДатаОстатки)}, {(Счет).* КАК Счет}, {(&ВидыСубконто)}, {(ВЫРАЗИТЬ(Субконто1 КАК Справочник.Номенклатура)).* КАК Номенклатура, (Субконто2)}) КАК ХозрасчетныйОстатки
	|		ПО СправочникНоменклатура.Ссылка = ХозрасчетныйОстатки.Субконто1
	|			И (ХозрасчетныйОстатки.КоличествоОстаток > 0)}
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.РЗ_ЗарезервированныеТовары.Остатки({(&ДатаОстатки)}, ) КАК ЗарезервированныеТовары
	|		ПО СправочникНоменклатура.Ссылка = ЗарезервированныеТовары.Номенклатура
	|			И (ВЫБОР
	|				КОГДА &СчетНаОплатуПокупателю = НЕОПРЕДЕЛЕНО
	|					ТОГДА ИСТИНА
	|				ИНАЧЕ ЗарезервированныеТовары.СчетПокупателю <> &СчетНаОплатуПокупателю
	|			КОНЕЦ)}
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.РЗ_ПотребностьВТоварах.Остатки({(&ДатаОстатки)}, ) КАК ПотребностьВТоварах
	|		ПО СправочникНоменклатура.Ссылка = ПотребностьВТоварах.Номенклатура
	|			И (ВЫБОР
	|				КОГДА &СчетНаОплатуПокупателю = НЕОПРЕДЕЛЕНО
	|					ТОГДА ЛОЖЬ
	|				ИНАЧЕ ПотребностьВТоварах.СчетПокупателю = &СчетНаОплатуПокупателю
	|			КОНЕЦ)}
	|ГДЕ
	|	НЕ СправочникНоменклатура.ЭтоГруппа
	|	И ВЫБОР
	|			КОГДА &ПоказыватьТолькоОстатки
	|				ТОГДА ЕСТЬNULL(ХозрасчетныйОстатки.КоличествоОстаток, 0) > 0
	|			ИНАЧЕ ИСТИНА
	|		КОНЕЦ
	|{ГДЕ
	|	СправочникНоменклатура.Ссылка.* КАК Номенклатура}";
	
	Если Не ПустаяСтрока(СтрЗаменить(СписокНоменклатуры.ТекстЗапроса, ТекстЗапросаПроверка, "")) Тогда
		ТекстОшибки = НСтр("ru='Текст запроса выборки номенклатуры изменился';");
		Сообщить(ТекстОшибки);
		ЗаписьЖурналаРегистрации("Обслуживание.Совместимость расширения", УровеньЖурналаРегистрации.Ошибка, Метаданные.Обработки.ПодборНоменклатуры,, ТекстОшибки); 
	КонецЕсли;
	
	СписокНоменклатуры.ТекстЗапроса = ТекстЗапросаНовый;

	МассивДобавляемыхРеквиизтов = Новый Массив;
	МассивДобавляемыхРеквиизтов.Добавить(Новый РеквизитФормы("СчетНаОплатуПокупателю", Новый ОписаниеТипов("ДокументСсылка.СчетНаОплатуПокупателю"),,, Ложь));
	
	ИзменитьРеквизиты(МассивДобавляемыхРеквиизтов);
	
	Если Параметры.Свойство("СчетНаОплатуПокупателю", ЭтаФорма.СчетНаОплатуПокупателю) Тогда
		СписокНоменклатуры.Параметры.УстановитьЗначениеПараметра("СчетНаОплатуПокупателю", ЭтаФорма.СчетНаОплатуПокупателю);
	Иначе
		СписокНоменклатуры.Параметры.УстановитьЗначениеПараметра("СчетНаОплатуПокупателю", Неопределено);
	КонецЕсли;
	
	ЭлементРезерв = Элементы.Добавить("Зарезервировано", Тип("ПолеФормы"), Элементы.СписокНоменклатуры);
	ЭлементРезерв.ПутьКДанным = "СписокНоменклатуры.КоличествоЗарезервировано";
	ЭлементРезерв.Заголовок = НСтр("ru='Зарезервировано';");
	
	ЭлементПотребность = Элементы.Добавить("Потребность", Тип("ПолеФормы"), Элементы.СписокНоменклатуры);
	ЭлементПотребность.ПутьКДанным = "СписокНоменклатуры.КоличествоПотребность";
	ЭлементПотребность.Заголовок = НСтр("ru='Потребность';");
	ЭлементПотребность.Видимость = ЗначениеЗаполнено(ЭтаФорма.СчетНаОплатуПокупателю);
	
КонецПроцедуры
