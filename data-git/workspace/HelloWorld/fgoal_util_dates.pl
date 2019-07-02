:- module(fgoal_util_dates,[getCurrentDateTime/1]).

:- use_module(library(julian)).

month('Jan',1,31).
month('Feb',2,29).
month('Mar',3,31).
month('Apr',4,30).
month('May',5,31).
month('Jun',6,30).
month('Jul',7,31).
month('Aug',8,31).
month('Sep',9,30).
month('Oct',10,31).
month('Nov',11,30).
month('Dec',12,31).

dayOfWeek('monday','Mon').
dayOfWeek('tuesday','Tue').
dayOfWeek('wednesday','Wed').
dayOfWeek('thursday','Thu').
dayOfWeek('friday','Fri').
dayOfWeek('saturday','Sat').
dayOfWeek('sunday','Sun').

number_addendum(1,'st').
number_addendum(2,'nd').
number_addendum(3,'rd').
number_addendum(4,'th').
number_addendum(5,'th').
number_addendum(6,'th').
number_addendum(7,'th').
number_addendum(8,'th').
number_addendum(9,'th').
number_addendum(10,'th').
number_addendum(11,'th').
number_addendum(12,'th').
number_addendum(12,'th').
number_addendum(13,'th').
number_addendum(14,'th').
number_addendum(15,'th').
number_addendum(16,'th').
number_addendum(17,'th').
number_addendum(18,'th').
number_addendum(19,'th').
number_addendum(20,'th').
number_addendum(21,'st').
number_addendum(22,'nd').
number_addendum(23,'rd').
number_addendum(24,'th').
number_addendum(25,'th').
number_addendum(26,'th').
number_addendum(27,'th').
number_addendum(28,'th').
number_addendum(29,'th').
number_addendum(30,'th').
number_addendum(31,'st').

long_to_short_day_of_month(L,S) :-
	number_addendum(S,Ext),
	atomic_list_concat([S,Ext],'',L).

generateGlossFor([Y-M-D,H:Mi:_S],Gloss) :-
	form_time([dow(DayOfWeek),Y-M-D]),
	dayOfWeek(DayOfWeek,DOW),
	month(Month,M,_),
	long_to_short_day_of_month(DayOfMonth,D),
	(H > 12 -> (H12 is H - 12, AmPm = 'PM') ;
	 (H = 12 -> (H12 is 12, AmPm = 'PM') ;
	  (H = 0 -> (H12 is 12, AmPm = 'AM') ;
	   (H < 12 -> (H12 is H, AmPm = 'AM'))))),
	format(atom(Mi0),'~|~`0t~w~2|', Mi),
	atomic_list_concat([DOW,' ',Month,' ',DayOfMonth,' ',Y,' at ',H12,':',Mi0,' ',AmPm],Gloss),!.

englishDescriptionOfTimeUntil(From,To,EnglishDescription) :-
	julian_daysUntilDate_precise(From,To,_,DaysEstimated),
	%% view([daysEstimated,DaysEstimated]),
	Abs is abs(DaysEstimated),
	%% view([abs,Abs]),
	((DaysEstimated < 0) ->
	 (%% view(1),
	  FloorDays is floor(Abs),
	  (Abs > 1.0) -> ((Abs < 2.0) -> (Template = ['1 day ago',[]]) ; (Template = ['~d days ago',[FloorDays]])) ;
	  (%% view(2),
	   %% view([abs,Abs]),
	   Hours is Abs * 24.0,
	   %% view(2.5),
	   FloorHours is floor(Hours),
	   %% view([hours,Hours]),
	   %% view(3),
	   ((Hours > 1.0) -> ((Hours < 2.0) -> (Template = ['1 hour ago',[]]) ; (Template = ['~d hours ago',[FloorHours]])) ;
	   (%% view(4),
	    %% view([hours,Hours]),
	    Minutes is Hours * 60.0,
	    %% view(5),
	    FloorMinutes is floor(Minutes),
	    %% view([minutes,Minutes,floorMinutes,FloorMinutes]),
	    (Minutes > 1.0) -> ((Minutes < 2.0) -> (Template = ['1 minute ago',[]]) ; (Template = ['~d minutes ago',[FloorMinutes]])) ;
	    (Template = ['less than a minute ago',[]]))))) ;
	 (%% view(1),
	  FloorDays is floor(Abs),
	  (Abs > 1.0) -> ((Abs < 2.0) -> (Template = ['in 1 day',[]]) ; (Template = ['in ~d days',[FloorDays]])) ;
	  (%% view(2),
	   %% view([hours,Abs]),
	   Hours is Abs * 24.0,
	   %% view(2.5),
	   FloorHours is floor(Hours),
	   %% view([hours,Hours]),
	   %% view(3),
	   ((Hours > 1.0) -> ((Hours < 2.0) -> (Template = ['in 1 hour',[]]) ; (Template = ['in ~d hours',[FloorHours]])) ;
	   (%% view(4),
	    %% view([hours,Hours]),
	    Minutes is Hours * 60.0,
	    %% view(5),
	    FloorMinutes is floor(Minutes),
	    %% view([minutes,Minutes,floorMinutes,FloorMinutes]),
	    (Minutes > 1.0) -> ((Minutes < 2.0) -> (Template = ['in 1 minute',[]]) ; (Template = ['in ~d minutes',[FloorMinutes]])) ;
	    (Template = ['less than in a minute',[]])))))
	),
	append([atom(EnglishDescription)],Template,Appended),
	Call =.. [format|Appended],
	call(Call).

printDateTime([Y-M-D,H:Mi:S],PrintedDateTime) :-
	%% view([Y,M,D,H,Mi,S]),
	format(atom(PrintedDateTime),'~d-~d-~d,~d:~d:~d',[Y,M,D,H,Mi,S]).

getCurrentDateTime(DateTime) :-
	currentTimeZone(TimeZone),
	getCurrentDateTimeForTimeZone(TimeZone,DateTime).

getCurrentDate([TmpDate]) :-
	currentTimeZone(TimeZone),
	getCurrentDateTimeForTimeZone(TimeZone,[TmpDate,_]).

getCurrentTime([TmpTime]) :-
	currentTimeZone(TimeZone),
	getCurrentDateTimeForTimeZone(TimeZone,[_,TmpTime]).

%% :- julian:form_time(now,Start),julian:form_time([Start,[Y-M-D,H:Mi:S]]),view([Y-M-D,H:Mi:S]),julian:form_time([2016-4-29,5:30:00],Finish),englishDescriptionOfTimeUntil(Start,Finish,EnglishDescription),view(EnglishDescription).

hasUTCOffset(utc,0).
hasUTCOffset(easternDaylightTime,4).
hasUTCOffset(easternStandardTime,5).
hasUTCOffset(centralDaylightTime,5).
hasUTCOffset(centralStandardTime,6).

currentTimeZone(easternDaylightTime).

convertUTCDateTimeToTimeZoneDateTime(UTCDateTime,TimeZone,[Y-M-D,H:Mi:S]) :-
	hasUTCOffset(TimeZone,Offset),
	DTs is Offset * 60 * 60,
	delta_time([Y-M-D,H:Mi:S], s(DTs), UTCDateTime).

getCurrentDateTimeForTimeZone(TimeZone,[Y-M-D,H:Mi:S]) :-
	getCurrentUTCDateTime(UTCDateTime),
	convertUTCDateTimeToTimeZoneDateTime(UTCDateTime,TimeZone,[Y-M-D,H:Mi:S]).

getCurrentUTCDateTime([Y-M-D,H:Mi:S]) :-
	julian:form_time([now,[Y-M-D,H:Mi:S]]).

non_empty_list(List) :-
	length(List,Length),
	Length > 0.

dateTimeP([_Y-_M-_D,_H:_Mi:_S]) :-
	true.
