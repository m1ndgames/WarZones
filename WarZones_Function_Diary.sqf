/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Diary.sqf
/  Description: Creates initial Diary entries.
/
*/

player createDiaryRecord["Diary",
	["WarZones - Credits",
		"
			- Arma 3 Forums + Wiki and the IRC Chat<br/>
			- Code34 for the helpful tips<br/>
			- KK's Blog for the Briefing-Skip function<br/>
		"
	]
];

player createDiaryRecord["Diary",
	["WarZones - Unit Roles",
		"
		Private:<br/>
			- TBA<br/>
			<br/>
			<br/>

		Corporal:<br/>
			- TBA<br/>
			<br/>
			<br/>

		Sergeant:<br/>
			- TBA<br/>
			<br/>
			<br/>

		Lieutenant:<br/>
			- TBA<br/>
			<br/>
			<br/>

		Captain:<br/>
			- TBA<br/>
			<br/>
			<br/>

		Major:<br/>
			- TBA<br/>
			<br/>
			<br/>

		Colonel:<br/>
			- TBA<br/>
			<br/>
			<br/>

		General:<br/>
			- TBA<br/>
			<br/>
			<br/>
		"
	]
];

player createDiaryRecord["Diary",
	["WarZones - About",
		"
		WarZones is a dynamic Battle between three Factions.<br/>
		<br/>
		<marker name='respawn_west'>NATO</marker> and <marker name='respawn_east'>CSAT</marker> forces are controlled by the Players, while<br/>
		<marker name='respawn_guerrila'>Independent</marker> forces are controlled by Ai.<br/>
		<br/>
		The Goal is to deplete the opposing player teams Tickets,<br/>
		either by killing Players or gaining control over the sectors.<br/>
		If you hold more then 33% of the Sectors (e.g: the Ai<br/>
		controlled AAF Sector), the enemy faction looses Tickets.<br/>
		<br/>
		The starting Positions and even the Bases are dynamic and<br/>
		change with each Round, so every Game in WarZones is<br/>
		unique!<br/>
		<br/>
		The player Rank is given by a players score, which is<br/>
		saved to a Database to make the Player persistent on<br/>
		the Servers.<br/>
		<br/>
		A higher Rank unlocks more gear loudouts and allows to<br/>
		give orders to subordinates on the Battlefield.<br/>
		<br/>
		The WarZones Map is written under GPL, so everyone can<br/>
		contribute or fork the Mission.<br/>
		<br/>
		See https://github.com/m1ndgames/WarZones/ for details.<br/>
		"
	]
];