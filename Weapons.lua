--[[
    Grinnelli Designs F-22A Raptor
    Copyright (C) 2024, Joseph Grinnelli
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses.
--]]


--F-22A CUSTOM WEAPON DATA
dofile("Scripts/Database/Weapons/warheads.lua")

local AIM_120D = {
		
	category     	= CAT_AIR_TO_AIR,
	Name         	= AIM_120D,
	user_name	 	= _("AIM-120D"),
	display_name 	= _('AIM-120D'),
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
	Escort 			= 0,
    Head_Type 		= 2,
	sigma 			= {5, 5, 5},
    M 				= 161.5,
    H_max  			= 26000.0,
    H_min  			= 1.0,
    Diam   			= 160.0,
    Cx_pil 			= 0,
    D_max 			= 16000.0,
    D_min 			= 700.0,
    Head_Form 		= 1,
    Life_Time 		= 90.0, 
    Nr_max 			= 40,
    v_min  			= 140.0,
    v_mid  			= 700.0,
    Mach_max  		= 4.0, 
    t_b       		= 0.0,
    t_acc     		= 3.0,
    t_marsh   		= 6.0,
    Range_max 		= 61000.0,
    H_min_t 		= 1.0,
    Fi_start		= 0.5,
    Fi_rak 			= 3.14152,
    Fi_excort 		= 1.05,
    Fi_search 		= 1.05,
    OmViz_max 		= 0.52,
    warhead 		= warheads["AIM_120C"],
    exhaust 		= {0.8, 0.8, 0.8, 0.05 };
    X_back 			= -1.61,
    Y_back 			= -0.089,
    Z_back 		    = 0.0,
    Reflection      = 0.0329,
    KillDistance    = 15.0,
	loft 			= 1,
	hoj  			= 1,

	shape_table_data =
	{
		{
			name	 = "AIM-120D",
			file	 = "AIM-120D",
			life	 = 1,
			fire	 = { 0, 1},
			username = "AIM-120D",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	PN_coeffs = {3, 				-- Number of Entries	
					5000.0 ,1.0,		-- Less 5 km to target Pn = 1
					10000.0, 0.5,		-- Between 10 and 5 km  to target, Pn smoothly changes from 0.5 to 1.0. 
					15000.0, 0.2};		-- Between 15 and 10 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 15 km Pn = 0.2.
		
	
	ModelData = {   58 ,  -- model params count
						0.4 ,   -- characteristic square (характеристическая площадь)
						
						-- параметры зависимости Сx
						0.045 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
						0.09 , -- Cx_k1 высота пика волнового кризиса
						0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
						0.016, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
						1.2 , -- Cx_k4 крутизна спада за волновым кризисом 
						1.5 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
						
						-- параметры зависимости Cy
						0.7 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
						0.8	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
						1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
						
						0.29 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.0, --угловая скорость создаваймая моментом газовых рулей
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,		-1.0,	8.0,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	6.41,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						 0.0,		0.0,	16325.0,	0.0,		0.0,			0.0,		0.0,           -- thrust, newtons
					
						 1.0e9, -- таймер самоликвидации, сек
						 100.0, -- время работы энергосистемы, сек
						 0, -- абсолютная высота самоликвидации, м
						 1.0, -- время задержки включения управления (маневр отлета, безопасности), сек
						 40000, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
						 40000, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
						 0.17,  -- синус угла возвышения траектории набора горки
						 50.0, -- продольное ускорения взведения взрывателя
						 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
						 25200.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
						 3.92, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
						 3.2,
						 0.75, -- безразмерный коэф. эффективности САУ ракеты
						 70.0, -- расчет времени полета
						  -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						 63000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						 25000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
						 22000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч
						 0.2, 
						 0.6,
						 1.4,
						-3.0,
						0.5,
					},
}


declare_weapon(AIM_120D) 

declare_loadout({
category		=	CAT_AIR_TO_AIR,
CLSID			= 	"{AIM-120D}",
Picture			=	"AIM-120D.png",
wsTypeOfWeapon	=	AIM_120D.wsTypeOfWeapon,
displayName	=	_("AIM-120D"),
attribute	=	{4,	4,	32,	102,	WSTYPE_PLACEHOLDER},
Count			=	1,
Weight			=	152,
Elements	=	
{
	{
	
		ShapeName	=	"AIM-120D",
		Position	=	{0,	0,	0}
	},
}, -- end of Elements
})

--------------------------------------------------------------------------------------------------AIM-9X
local AIM_9XX = {
		
		category     	= CAT_AIR_TO_AIR,
		Name         	= AIM_9XX,
		user_name	 	= _("AIM-9XX"),
		display_name 	= _('AIM-9XX'),
		wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},
		Escort = 0,
		Head_Type = 1,
		sigma = {2, 2, 2},
		M = 85.5,
		H_max = 18000.0,
		H_min = -1,
		Diam = 127.0,
		Cx_pil = 0,
		D_max = 11000.0,
		D_min = 200.0,
		Head_Form = 0,
		Life_Time = 60.0,
		Nr_max = 55,
		v_min = 140.0,
		v_mid = 350.0,
		Mach_max = 2.7,
		t_b = 0.0,
		t_acc = 5.0,
		t_marsh = 0.0,
		Range_max = 14000.0,
		H_min_t = 1.0,
		Fi_start = 1.57,
		Fi_rak = 3.14152,
		Fi_excort = 1.57,
		Fi_search = 0.09,
		OmViz_max = 1.10,
		warhead = warheads["AIM_9X"],
		exhaust = { 0.7, 0.7, 0.7, 0.08 };
		X_back = -1.92,
		Y_back = 0.0,
		Z_back = 0.0,
		Reflection = 0.0182,
		KillDistance = 6.0,
--seeker sensivity params
		SeekerSensivityDistance = 25000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		ccm_k0 = 0.2,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		SeekerCooled	= true, -- True is cooled seeker and false is not cooled seeker

	shape_table_data =
	{
		{
			name	 = "AIM-9XX",
			file	 = "AIM-9XX",
			life	 = 1,
			fire	 = { 0, 1},
			username = "AIM-9XX",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	PN_coeffs = {3, 				-- Number of Entries	
					3000.0 ,1.0,		-- Less 3 km to target Pn = 1
					5000.0, 0.5,		-- Between 5 and 3 km  to target, Pn smoothly changes from 0.5 to 1.0. 
					10000.0, 0.2};		-- Between 10 and 5 km  to target, Pn smoothly changes from 0.2 to 0.5. Longer then 10 km Pn = 0.2.

	
	ModelData = {   58 ,  -- model params count
					0.35 ,   -- characteristic square (характеристическая площадь)
					
					-- параметры зависимости Сx
					0.04 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1)
					0.08 , -- Cx_k1 высота пика волнового кризиса
					0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису
					0.05, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1)
					1.2 , -- Cx_k4 крутизна спада за волновым кризисом 
					1.0 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))
					
					-- параметры зависимости Cy
					0.9 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)
					0.8	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)
					1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  
					
					0.7 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
					10.0, -- Extra G by trust vector
					
				-- Engine data. Time, fuel flow, thrust.	
				--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
					-1.0,		-1.0,	5.0,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
					 0.0,		0.0,	5.44,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
					 0.0,		0.0,	12802.0,	0.0,	0.0,			0.0,		0.0,           -- thrust, newtons
				
					 1.0e9, -- таймер самоликвидации, сек
					 60.0, -- время работы энергосистемы, сек
					 0, -- абсолютная высота самоликвидации, м
					 0.3, -- время задержки включения управления (маневр отлета, безопасности), сек
					 1.0e9, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м
					 1.0e9, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 
					 0.0,  -- синус угла возвышения траектории набора горки
					 30.0, -- продольное ускорения взведения взрывателя
					 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
					 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
					 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
					 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
					 0.0,
					 0.0,
					 0.0,
					 0.0,
					 0.0,
					 -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
					 11000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
					 5000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч, м
					 5000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч, м
					 0.2, -- Уменьшение разрешенной дальности пуска при отклонении вектора скорости носителя от линии визирования цели.
					 1.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
					 1.4, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
					-3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
					0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
				},
}
declare_weapon(AIM_9XX) 

declare_loadout({
category		=	CAT_AIR_TO_AIR,
CLSID			= 	"{AIM-9XX}",
Picture			=	"AIM-9XX.png",
wsTypeOfWeapon	=	AIM_9XX.wsTypeOfWeapon,
displayName	=	_("AIM-9XX"),
attribute	=	{4,	4,	32,	103, WSTYPE_PLACEHOLDER},
Count			=	1,
Weight			=	85,
Elements	=	
{
	{
	
		ShapeName	=	"AIM-9XX",
		Position	=	{0,	0,	0}
	},
}, -- end of Elements
})
