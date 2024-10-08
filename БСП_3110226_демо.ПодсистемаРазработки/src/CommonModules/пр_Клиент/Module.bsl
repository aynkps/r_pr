// ОМ.пр_Клиент
//ИмяМодуля - заполняется Объект_ИмяФормы (СБИС_ФормаПросмотрДокумента), 
//              - либо Метаданны_Объект_ИмяФормы (Справочники.Пользователи.ФормаЭлемента)
//ИмяФормы = "" - Когда имя формы не возможно идентифицировать (СБИС_СопоставлениеНоменклатуры_СуммовойУчет) 
&НаКлиенте
Функция ИсполняемыйМодуль(ИмяМодуля, ИмяФормы = "", Пользователь = Неопределено, ФормаВладелец = Неопределено)   Экспорт 
	
	Попытка
		
		Если ИмяФормы = "" Тогда  
			//МасИмяФормы = СтрРазделить(ИмяМодуля, "_");
			//ИмяВнешенйФормы = МасИмяФормы[МасИмяФормы.ВГраница()]; 
			ИмяВнешенйФормы = "Форма";	
		Иначе	
			ИмяВнешенйФормы = ИмяФормы;	
		КонецЕсли;
		
		//НастройкиИсполняемогоМодуля = пр_НастройкиПовтИсп.НастройкиИсполняемогоМодуля(ИмяМодуля, Пользователь);
		НастройкиИсполняемогоМодуля = пр_Общий.НастройкиИсполняемогоМодуля(ИмяМодуля, Пользователь);
		Если НастройкиИсполняемогоМодуля = Неопределено Тогда
			Возврат Неопределено;		
		КонецЕсли; 
		
		ПарамФормы = Новый Структура("АвтоТест"); 
		Если НастройкиИсполняемогоМодуля.ИспользоватьОбработкуБСП И ЗначениеЗаполнено(НастройкиИсполняемогоМодуля.ОбработкаОтладкиБСП)  Тогда
			ФормаОбработки = ПолучитьФормуВнешнейОбработкиБСП( , НастройкиИсполняемогоМодуля.ОбработкаОтладкиБСП, ИмяВнешенйФормы, ПарамФормы);
		ИначеЕсли ЗначениеЗаполнено(НастройкиИсполняемогоМодуля.ПутьКОбработкеОтладки)	Тогда
			ФормаОбработки = ПолучитьФормуПоПути(НастройкиИсполняемогоМодуля.ПутьКОбработкеОтладки,, ИмяВнешенйФормы, ПарамФормы);		
		Иначе
			//ОткрытьФорму(ПутьКФорме, ПараметрыОткрытия, ФормаВладелец, Уникальность, Окно, НавигСсылка, ОписОповещФормы, РежимОткрытияОкна);
			Возврат Неопределено;		
		КонецЕсли;
		
		Если ФормаВладелец <> Неопределено Тогда
			//КопироватьДанныеФормы(ФормаВладелец, ФормаОбработки);
		КонецЕсли; 
		Возврат ФормаОбработки;	
		
	Исключение
		Сообщение = Новый СообщениеПользователю;
		Ошибка = ОписаниеОшибки();
		Сообщение.Текст = Ошибка;
		Сообщение.Сообщить();
		Возврат Неопределено;		
	КонецПопытки;		
	
КонецФункции 

//ИмяМодуля - заполняется Объект_ИмяФормы (СБИС_ФормаПросмотрДокумента), 
//              - либо Метаданны_Объект_ИмяФормы (Справочники.Пользователи.ФормаЭлемента)
//ИмяФормы = "" - Когда имя формы не возможно идентифицировать (СБИС_СопоставлениеНоменклатуры_СуммовойУчет) 
&НаКлиенте
Функция ОткрытьИсполняемуюФорму(ИмяМодуля, ИмяВнешенйФормы = "", Пользователь = Неопределено, ПараметрыОткрытия = Неопределено, ФормаВладелец = Неопределено, Уникальность = Неопределено, 
								Окно = Неопределено, НавигацСсылка = Неопределено, СтруктураОповещенияОЗакрытии = Неопределено, РежимОткрытия = Неопределено, ИмяОбработки = "")   Экспорт 
	
	Попытка
		
		Если ИмяВнешенйФормы = "" Тогда  
			МасИмяФормы = СтрРазделить(ИмяМодуля, "_");
			ИмяВнешенйФормы = МасИмяФормы[МасИмяФормы.ВГраница()]; 	
		Иначе	
			ИмяВнешенйФормы = ИмяВнешенйФормы;	
		КонецЕсли;
		
		//НастройкиИсполняемогоМодуля = пр_НастройкиПовтИсп.НастройкиИсполняемогоМодуля(ИмяМодуля, Пользователь);
		НастройкиИсполняемогоМодуля = пр_Общий.НастройкиИсполняемогоМодуля(ИмяМодуля, Пользователь);
		Если НастройкиИсполняемогоМодуля = Неопределено Тогда
			Возврат Неопределено;		
		КонецЕсли; 
		
		Если НастройкиИсполняемогоМодуля.ИспользоватьОбработкуБСП И ЗначениеЗаполнено(НастройкиИсполняемогоМодуля.ОбработкаОтладкиБСП)  Тогда
			//ФормаОбработки = пр_Клиент.ВнешняяОбработкаБСП(,НастройкиИсполняемогоМодуля.ОбработкаОтладкиБСП);
			ОткрытьФормуВнешнююОбработкиБСП(ИмяОбработки, ИмяВнешенйФормы, ПараметрыОткрытия, ФормаВладелец, Уникальность, Окно, НавигацСсылка, СтруктураОповещенияОЗакрытии, РежимОткрытия, Истина);	
		ИначеЕсли ЗначениеЗаполнено(НастройкиИсполняемогоМодуля.ПутьКОбработкеОтладки)	Тогда
			//ФормаОбработки = ПолучитьФормуПоПути(НастройкиИсполняемогоМодуля.ПутьКОбработкеОтладки,, ИмяВнешенйФормы);
			ОткрытьФормуВнешнейОбработки(НастройкиИсполняемогоМодуля.ПутьКОбработкеОтладки, ИмяВнешенйФормы, ПараметрыОткрытия, ФормаВладелец, Уникальность, Окно, НавигацСсылка, 
										СтруктураОповещенияОЗакрытии, РежимОткрытия, ИмяОбработки, , Истина);	
		Иначе
			//ОткрытьФорму(ПутьКФорме, ПараметрыОткрытия, ФормаВладелец, Уникальность, Окно, НавигСсылка, ОписОповещФормы, РежимОткрытияОкна);
			Возврат Неопределено;		
		КонецЕсли;
		
		Возврат Истина;	
		
	Исключение
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ОписаниеОшибки();
		Сообщение.Сообщить();
		Возврат Неопределено;		
	КонецПопытки;		
	
КонецФункции 

&НаКлиенте
Процедура ОткрытьФормуВнешнююОбработкиБСП(ИмяОбработки, ОбработкаБСП = Неопределено, ИмяВнешенйФормы = "Форма", ПараметрыОткрытия = Неопределено, ФормаВладелец = Неопределено, Уникальность = Неопределено, 
								Окно = Неопределено, НавигацСсылка = Неопределено, СтруктураОповещенияОЗакрытии = Неопределено, РежимОткрытия = Неопределено, ЭтоОбработка = Истина)	Экспорт
	ОткрытьФормуВнешнейОбработки(, ИмяВнешенйФормы, ПараметрыОткрытия, ФормаВладелец, Уникальность, Окно, НавигацСсылка, СтруктураОповещенияОЗакрытии, РежимОткрытия, ИмяОбработки, Истина, ЭтоОбработка, ОбработкаБСП)	
КонецПроцедуры

// Открывает форму внешней обработки
//
// Параметры:
//  ПолныйПуть  - Строка - Полный путь к внешней обработке, пример:
//                	ПолныйПуть = "\\Кпс_Разработка\Задачи\УТАП\ОбработкиРазработки\НоменклатурныйСоставПланаПродаж.epf"; 
//  ИмяВнешенйФормы  - Строка - Имя открываемой внешней формы, если не задана то стандартно "Форма" 
//					пример: "ФормаЭлемента", "ФормаЗаписи"
//	ПараметрыОткрытия - Структура  - Параметров открытия формы
//  ФормаВладелец - Форма - из под которой происходит открытие формы
//	СтруктураОповещенияОЗакрытии - Структура -  с ключами "ИмяПроцедурыПослеЗакрытияФормы", "Модуль"
//									ИмяПроцедуры - Строка - Имя процедцры в описании оповещении
//									Модуль - Программный модуль, процедура которого будет вызвана. 
//  ИмяОбработки - Строка - Если имя обработки отличается от имени сохраненной в полном пути.
//
&НаКлиенте
Процедура ОткрытьФормуВнешнейОбработки(ПолныйПуть = "", ИмяВнешенйФормы = "Форма", ПараметрыОткрытия = Неопределено, ФормаВладелец = Неопределено, Уникальность = Неопределено, 
								Окно = Неопределено, НавигацСсылка = Неопределено, СтруктураОповещенияОЗакрытии = Неопределено, РежимОткрытия = Неопределено, ИмяОбработки = "", ЭтоБСП = Ложь, ЭтоОбработка = Истина, ОбработкаБСП = Неопределено)  Экспорт
	
	Если ЭтоБСП Тогда
		ИмяОбработки = пр_Общий.ПодключитьВнешнююОбработкуБСП(ИмяОбработки, ОбработкаБСП);
		Если ИмяОбработки = Неопределено Тогда
			Возврат;
		КонецЕсли; 
	Иначе 
		
		Если ИмяОбработки = "" Тогда
			ИмяОбработки = ИмяОбработкиИзПолногоПутиКФайлу(ПолныйПуть);
		КонецЕсли; 
		
		Если ПолныйПуть <> "" Тогда
			пр_Общий.СоздатьВнешнююОбработкуПоПути(ПолныйПуть);
		КонецЕсли; 
		
	КонецЕсли; 
	
	Если СтруктураОповещенияОЗакрытии = Неопределено Тогда
		ОписОповещФормы = Неопределено;
	ИначеЕсли ТипЗнч(СтруктураОповещенияОЗакрытии) = Тип("ОписаниеОповещения") Тогда
		ОписОповещФормы = СтруктураОповещенияОЗакрытии;
	Иначе
		ОписОповещФормы = Новый ОписаниеОповещения(СтруктураОповещенияОЗакрытии.ИмяПроцедуры, СтруктураОповещенияОЗакрытии.Модуль);
	КонецЕсли; 

	ТипВнешнего = ?(ЭтоОбработка = Истина, "ВнешняяОбработка.", "ВнешнийОтчет.");
	ОткрытьФорму(ТипВнешнего + ИмяОбработки + ".Форма." + ИмяВнешенйФормы, ПараметрыОткрытия, ФормаВладелец, Уникальность, Окно, НавигацСсылка, ОписОповещФормы, РежимОткрытия);
	
КонецПроцедуры

//ПолныйПуть, "НавигаторОбщий", "Форма"
&НаКлиенте
Функция ПолучитьФормуПоПути(ПолныйПуть = "", ИмяОбработки = "", ИмяВнешенйФормы, ПараметрыОбработки = Неопределено, ВладелецФормы = Неопределено, Уникальность = Неопределено, 
							Окно = Неопределено, НавигационнаяСсылка= Неопределено, ЭтоОбработка = Истина, ЭтоБСП = Ложь, ОбработкаБСП = Неопределено) Экспорт
	
	Если ЭтоБСП Тогда
		ИмяОбработки = пр_Общий.ПодключитьВнешнююОбработкуБСП(ИмяОбработки, ОбработкаБСП);
		Если ИмяОбработки = Неопределено Тогда
			Возврат Неопределено;
		КонецЕсли; 
	Иначе 
		пр_Общий.СоздатьВнешнююОбработкуПоПути(ПолныйПуть,,, ЭтоОбработка);
		
		Если ИмяОбработки = "" Тогда
			ИмяОбработки = ИмяОбработкиИзПолногоПутиКФайлу(ПолныйПуть);
		КонецЕсли; 
	КонецЕсли; 
	
	ТипВнешнего = ?(ЭтоОбработка = Истина, "ВнешняяОбработка.", "ВнешнийОтчет.");
	ВнешняяФорма = ПолучитьФорму(ТипВнешнего +  ИмяОбработки + ".Форма." + ИмяВнешенйФормы, ПараметрыОбработки, ВладелецФормы, Уникальность, Окно, НавигационнаяСсылка);
	Возврат ВнешняяФорма;
	
КонецФункции

&НаКлиенте
Функция ПолучитьФормуВнешнейОбработкиБСП(ИмяОбработки = "" ,ОбработкаБСП = Неопределено, ИмяВнешенйФормы = "Форма", ПараметрыОбработки = Неопределено, ВладелецФормы = Неопределено, Уникальность = Неопределено, 
							Окно = Неопределено, НавигационнаяСсылка= Неопределено, ЭтоОбработка = Истина) Экспорт
							
	ВнешняяФорма = ПолучитьФормуПоПути(, ИмяОбработки, ИмяВнешенйФормы, ПараметрыОбработки, ВладелецФормы, Уникальность, 
							Окно, НавигационнаяСсылка, ЭтоОбработка, Истина, ОбработкаБСП);
	Возврат ВнешняяФорма;
	
КонецФункции 


&НаКлиенте
Функция ИмяОбработкиИзПолногоПутиКФайлу(ПолныйПуть)
	МассивРазделенияСтроки = СтрРазделить(ПолныйПуть, "\");
	ИмяОбработки = СтрРазделить(МассивРазделенияСтроки[МассивРазделенияСтроки.ВГраница()], ".")[0];
	Возврат ИмяОбработки;
КонецФункции 


#Область  СобытияФормы 
 
// В поле ввода можно вводить ссылку, ГУИД Ссылки или Навигационную ссылку 
//
// Параметры:
//  Объект1С  					- ЛюбаяСсылка - На форме
//  Текст 	  					- Строка - параметр обработки
//  СтандартнаяОбработка 	  	- Булево - параметр обработки
//  ИмяТипа 	  				- Строка - "CatalogRef.Номенклатура"
//									Для поиска по id: 69296291-5208-11ee-843e-ac1f6b8732b0 
&НаКлиенте
Процедура Объект1СОкончаниеВводаТекста(Объект1С, Текст, СтандартнаяОбработка)   Экспорт
	
	Попытка
		Если СтрНайти(Текст, "e1cib/data/") Тогда
			СтандартнаяОбработка = Ложь;
			Объект1С = пр_Общий.ПолучитьСсылкуИзНавигационной(Текст);
		//ИначеЕсли ИмяТипа <> "" Тогда
		Иначе
			СсылкаПоИД = пр_Общий.СсылкаПоТипXML(пр_Общий.ИмяТипаXMLПоСсылке(Объект1С), Текст);
			Если СсылкаПоИД <> Неопределено Тогда
				СтандартнаяОбработка = Ложь;
				Объект1С = СсылкаПоИД;
			КонецЕсли; 
		КонецЕсли; 
	Исключение
		пр_Ошибка = ОписаниеОшибки();
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = пр_Ошибка;
		Сообщение.Сообщить(); 
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура Объект1СОчистка(Объект1С, СтандартнаяОбработка) Экспорт
	СтандартнаяОбработка = Ложь;
	ОписаниеТипа = Новый ОписаниеТипов("Строка");
	Объект1С = ОписаниеТипа.ПривестиЗначение();
	Объект1С = "Введите ссылку";
КонецПроцедуры

&НаКлиенте
Функция ВыборКаталогаФайлаНачалоВыбора(ВыборФайла = Истина, КаталогПоУмолчанию = "", МножественныйВыбор = Ложь)	Экспорт
	
	Режим = ?(ВыборФайла = Истина, РежимДиалогаВыбораФайла.Открытие, РежимДиалогаВыбораФайла.ВыборКаталога); 
	ДиалогОткрытия = Новый ДиалогВыбораФайла(Режим); 
	ДиалогОткрытия.Каталог = КаталогПоУмолчанию; 
	ДиалогОткрытия.МножественныйВыбор = МножественныйВыбор; 
	ДиалогОткрытия.Заголовок = ?(ВыборФайла = Истина, "Выберите Файл", "Выберите каталог"); 
	
	Если ДиалогОткрытия.Выбрать() Тогда 
		Возврат ?(ВыборФайла = Истина, ДиалогОткрытия.ПолноеИмяФайла, ДиалогОткрытия.Каталог); 
	КонецЕсли; 
	
	Возврат Неопределено; 
	
КонецФункции    

&НаКлиенте
Процедура ОткрытьКаталогФайла(Знач ПутьКФайлу, СтандартнаяОбработка)  Экспорт
	
	Если НЕ ЗначениеЗаполнено(ПутьКФайлу)  Тогда
		Возврат;	
	КонецЕсли; 
	
	ПутьККаталогуФайла = пр_КлиентСервер.КаталогФайла(ПутьКФайлу);
	ОткрытьПриложение(ПутьККаталогуФайла, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура УточнитьКаталогПоУмолчанию(Форма, ИмяРеквизита, КаталогПоУмолчанию) 
	
	ТекЗначениеРеквизита = Форма[ИмяРеквизита];
	Если НЕ ЗначениеЗаполнено(КаталогПоУмолчанию) И ЗначениеЗаполнено(ТекЗначениеРеквизита) Тогда
		КаталогПоУмолчанию = пр_КлиентСервер.КаталогФайла(ТекЗначениеРеквизита);	
	КонецЕсли;
	
КонецПроцедуры

//пр_Клиент.УстановкаКаталогаФайлаНачалоВыбора(ЭтаФорма, "ПутьККаталогуФайла", Ложь, ПутьККаталогуФайла);
&НаКлиенте
Процедура УстановкаКаталогаФайлаНачалоВыбора(Форма, ИмяРеквизита, ВыборФайла = Истина, КаталогПоУмолчанию = "", МножественныйВыбор = Ложь)	Экспорт
	РезультатУстановкиКаталогаФайлаНачалоВыбора(Форма, ИмяРеквизита, ВыборФайла, КаталогПоУмолчанию, МножественныйВыбор);	
КонецПроцедуры 

//пр_Клиент.РезультатУстановкиКаталогаФайлаНачалоВыбора(ЭтаФорма, "ПутьККаталогуФайла", Ложь, ПутьККаталогуФайла);
&НаКлиенте
Функция РезультатУстановкиКаталогаФайлаНачалоВыбора(Форма, ИмяРеквизита, ВыборФайла = Истина, КаталогПоУмолчанию = "", МножественныйВыбор = Ложь)	Экспорт
	
	Попытка
		
		УточнитьКаталогПоУмолчанию(Форма, ИмяРеквизита, КаталогПоУмолчанию);	
		Каталог = ВыборКаталогаФайлаНачалоВыбора(ВыборФайла, КаталогПоУмолчанию, МножественныйВыбор);
		Если ЗначениеЗаполнено(Каталог)  Тогда
			Форма[ИмяРеквизита] = Каталог; 
		КонецЕсли;
		
		Возврат Истина;
		
	Исключение
		Возврат Ложь;
	КонецПопытки; 
	
КонецФункции 

&НаКлиенте
Функция ФормаОтрыта(ЗаголовокФормы = "", ПутьКФомре = "", ИДФормы = Неопределено, НавигационнаяСсылка = Неопределено)  Экспорт
	
	Если ЗаголовокФормы <> "" Тогда
		
		ОкнаПриложения = ПолучитьОкна();
		Для каждого ОкноПриложения Из ОкнаПриложения Цикл
			Если Найти(ОкноПриложения.Заголовок, ЗаголовокФормы) > 0 Тогда
				Возврат Истина;
			КонецЕсли; 	
		КонецЦикла;	
		
		Возврат Ложь;
	ИначеЕсли ПутьКФомре <> "" Тогда
		Форма = ПолучитьФорму(ПутьКФомре);
		Если Форма = Неопределено Тогда
			Возврат Ложь;
		КонецЕсли; 
		Возврат Форма.Открыта();
		
	КонецЕсли; 
	
КонецФункции 


#Область  Запуск_Приложения

&НаКлиенте
Процедура ОткрытьПриложение(СтрокаКоманды, СтандартнаяОбработка = Ложь, Асинхронно = Истина) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если СтрокаКоманды = "" Тогда
		Возврат;
	КонецЕсли; 
	
	Если Асинхронно = Истина Тогда
		//ОписОповещФормы = Новый ОписаниеОповещения("ЗапускПриложения", ЭтотОбъект); //ЭтаФорма, ЭтотОбъект
		//НачатьЗапускПриложения(ОписОповещФормы, СтрокаКоманды);
		ЗапуститьПриложениеАсинх(СтрокаКоманды);
	Иначе	
		ЗапуститьПриложение(СтрокаКоманды);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
//Какие параметры могут передаваться:
//ПараметрыЗакрытия, СтандартныеРеквизиты, ФормаРедактированияСтроки, СтруктураПараметров, ВыполняемоеОповещение, Результат, ИсточникВыбора 
Процедура ЗапускПриложения(ПараметрыВыбора, Параметры) Экспорт 
	
КонецПроцедуры 
 
#КонецОбласти


#Область  БСП

// Возвращает значения реквизитов, прочитанные из информационной базы
// для нескольких объектов.
// 
//  Если доступа к одному из реквизитов нет, возникнет исключение прав доступа.
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
//
// Функция не предназначена для получения значений реквизитов пустых ссылок.
// 
// Параметры:
//  МассивСсылок - массив ссылок на объекты одного типа.
//				ВАЖНО! значения массива должны быть ссылками на 
//				объекты одного типа!
//  ИменаРеквизитов - Строка, имена реквизитов перечисленные через запятую,
//				в формате требований к свойствам структуры.
//				Например, "Код, Наименование, Родитель".
// 
// Возвращаемое значение:
//  Соответствие - где ключ - ссылка на объект, а Значение - структура, которая 
//		   		содержит список свойств, как список имен в строке.
//				ИменаРеквизитов, со значениям реквизитов, прочитанными из информационной базы.
// 
&НаКлиенте
Функция ЗначенияРеквизитовОбъектов(МассивСсылок, ИменаРеквизитов) Экспорт
	Возврат пр_Общий.ЗначенияРеквизитовОбъектов(МассивСсылок, ИменаРеквизитов);
КонецФункции 


// Возвращает структуру, содержащую значения реквизитов прочитанные из информационной базы
// по ссылке на объект.
// 
//  Если доступа к одному из реквизитов нет, возникнет исключение прав доступа.
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
// 
// Функция не предназначена для получения значений реквизитов пустых ссылок.
//
// Параметры:
//  Ссылка    - ЛюбаяСсылка - объект, значения реквизитов которого необходимо получить.
//
//  Реквизиты - Строка - имена реквизитов, перечисленные через запятую, в формате
//              требований к свойствам структуры.
//              Например, "Код, Наименование, Родитель".
//            - Структура, ФиксированнаяСтруктура - в качестве ключа передается
//              псевдоним поля для возвращаемой структуры с результатом, а в качестве
//              значения (опционально) фактическое имя поля в таблице.
//              Если значение не определено, то имя поля берется из ключа.
//            - Массив, ФиксированныйМассив - имена реквизитов в формате требований
//              к свойствам структуры.
//
// Возвращаемое значение:
//  Структура - содержит имена (ключи) и значения затребованных реквизитов.
//              Если строка затребованных реквизитов пуста, то возвращается пустая структура.
//              Если в качестве объекта передана пустая ссылка, то все реквизиты вернутся со значением Неопределено.
//
&НаКлиенте
Функция ЗначенияРеквизитовОбъекта(Ссылка, Знач Реквизиты) Экспорт
	Возврат пр_Общий.ЗначенияРеквизитовОбъекта(Ссылка, Реквизиты);
КонецФункции 

#КонецОбласти
 

// ОМ.пр_Клиент