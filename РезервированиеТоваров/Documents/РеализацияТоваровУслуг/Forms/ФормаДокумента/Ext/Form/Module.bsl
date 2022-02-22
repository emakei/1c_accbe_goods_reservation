﻿
&ИзменениеИКонтроль("ПолучитьПараметрыПодбора")
&НаКлиенте
Функция РЗ_ПолучитьПараметрыПодбора(ИмяТаблицы)

	ПараметрыФормы = Новый Структура;

	ДатаРасчетов 	 = ?(НачалоДня(Объект.Дата) = НачалоДня(ТекущаяДата()), Неопределено, Объект.Дата);
	ЗаголовокПодбора = НСтр("ru = 'Подбор номенклатуры в %1 (%2)'");

	Валюта = Объект.ВалютаДокумента;

	Если ЗначениеЗаполнено(Объект.ТипЦен) Тогда
		Параметрыформы.Вставить("ПоказыватьЦены", Истина);
	КонецЕсли;

	Если ИмяТаблицы = "Товары" Тогда
		ПредставлениеТаблицы = НСтр("ru = 'Товары'");

		ПараметрыФормы.Вставить("ПоказыватьОстатки"  , Истина);
		ПараметрыФормы.Вставить("ПоказыватьПартии",    Истина);    //1С-Минск 
		ПараметрыФормы.Вставить("ДатаДокумента",       Объект.Дата);    //1С-Минск 
		ПараметрыФормы.Вставить("ПоказыватьСчетУчета", Истина);
		#Вставка
		ПараметрыФормы.Вставить("СчетНаОплатуПокупателю", Объект.СчетНаОплатуПокупателю);
		#КонецВставки
	ИначеЕсли ИмяТаблицы = "ВозвратнаяТара" Тогда
		ПредставлениеТаблицы = НСтр("ru = 'Возвратная тара'");

		//Отказ = Ложь;     //1С-Минск
		//ОчиститьСообщения();
		//Если ЗначениеЗаполнено(Объект.ДоговорКонтрагента) Тогда
		//	Валюта = ВалютаВзаиморасчетов;
		//	Если НЕ ЗначениеЗаполнено(Валюта) Тогда
		//		ТекстСообщения = ОбщегоНазначенияБПКлиентСервер.ПолучитьТекстСообщения(,, НСтр("ru = 'Валюта расчетов'"));
		//		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "ДоговорКонтрагента", "Объект", Отказ);
		//	КонецЕсли;
		//Иначе
		//	ТекстСообщения = ОбщегоНазначенияБПКлиентСервер.ПолучитьТекстСообщения(,, НСтр("ru = 'Договор'"));
		//	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "ДоговорКонтрагента", "Объект", Отказ);
		//КонецЕсли;
		//
		//Если Отказ Тогда
		//	Возврат Неопределено;
		//КонецЕсли;

		ПараметрыФормы.Вставить("ПоказыватьОстатки"  , Истина);
		ПараметрыФормы.Вставить("ПоказыватьПартии",    Истина);  //1С-Минск 
		ПараметрыФормы.Вставить("ДатаДокумента",       Объект.Дата);  //1С-Минск 
		ПараметрыФормы.Вставить("ПоказыватьСчетУчета", Истина);
	ИначеЕсли ИмяТаблицы = "Услуги" Тогда
		ПредставлениеТаблицы = НСтр("ru = 'Услуги'");
	КонецЕсли;
	ЗаголовокПодбора = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ЗаголовокПодбора, Объект.Ссылка, ПредставлениеТаблицы);

	ПараметрыФормы.Вставить("ЕстьЦена"          , Истина);
	ПараметрыФормы.Вставить("ДатаРасчетов"      , ДатаРасчетов);
	ПараметрыФормы.Вставить("ТипЦен"            , Объект.ТипЦен);
	ПараметрыФормы.Вставить("Валюта"            , Валюта);
	ПараметрыФормы.Вставить("ДоговорКонтрагента", Объект.ДоговорКонтрагента);
	ПараметрыФормы.Вставить("Контрагент"        , Объект.Контрагент);
	ПараметрыФормы.Вставить("Организация"       , Объект.Организация);
	ПараметрыФормы.Вставить("Склад"             , Объект.Склад);
	ПараметрыФормы.Вставить("Заголовок"         , ЗаголовокПодбора);
	ПараметрыФормы.Вставить("ВидПодбора"        , ПолучитьВидПодбора(ИмяТаблицы));
	ПараметрыФормы.Вставить("ИмяТаблицы"        , ИмяТаблицы);
	ПараметрыФормы.Вставить("Услуги"            , ИмяТаблицы = "Услуги");

	Возврат ПараметрыФормы;

КонецФункции
