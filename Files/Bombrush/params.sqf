// Day and Weather script by Moerderhoschi
	class EmtpyLine1 //0
		{
		title = ":: Time & Weather settings";
		values[]={0,0};
		texts[]={ "",""};
		default = 0;
		};
	class DayTime //select 1
		{
		title = "Time Of Day";
		values[] = {60,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
		texts[] = {"Random", "00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00","08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"};
		default = 10;
		};
	class initialWeather //select 2
		{
		title = "Starting Weather";
		values[] = {1,2,3,4,5,6,7};
        texts[] = {"Clear","Overcast","Light Rain","Heavy Rain","Light Fog","Heavy Fog","Random"};
        default = 7;
		};
	class EmtpyLine2 //3
		{
		title = ":: Game Settings";
		values[]={0,0};
		texts[]={ "",""};
		default = 0;
		};
	class AmountBombs //select 4v
		{
		title = "Amount of bombs";
		values[] = {15, 20, 30, 50};
		texts[] = {"A few", "Several", "A lot", "A shitload"};
		default = 20;
		};
	class AmountofBombsexploded //select 5v
		{
		title = "Amount of bombs allowed to explode";
		values[] = {5, 3, 2, 1};
		texts[] = {"To easy...", "Forgiving", "You can fail once", "No margin of error"};
		default = 3;
		};
	class EnemySkill //select 6v
		{
		title = "Enemy Skill";
		values[] = {0, 1, 2, 3, 4};
		texts[] = {"Easiest", "Easy", "Medium", "Hard", "Very hard"};
		default = 2;
		};
	class Bombtime //select 7v
		{
		title = "Bombtimer time";
		values[] = {1, 1800, 1200, 600};
		texts[] = {"Random", "30 Minutes (Normal)", "20  Minutes (Medium)", "10 Minutes (Hard)"};
		default = 1;
		};
	class Readytime //select 8v
		{
		title = "Ready time";
		values[] = {0, 300, 600};
		texts[] = {"None", "5 Minutes", "10 Minutes"};
		default = 0;
		};
	class AmbientCivies //select 9v
		{
		title = "Ambient Civilians";
		values[] = {false, true};
		texts[] = {"Off", "On"};
		default = true;
		};
	class MoneyAmount //select 10v
		{
		title = "Money";
		values[] = {10, 20, 30, 50};
		texts[] = {"$ 100.000", "$ 200.000", "$ 300.000", "$ 500.000"};
		default = 30;
		};
	class Defusers //select11v
		{
		title = "Who can defuse the bomb?";
		values[] = {0, 1};
		texts[] = {"Everyone", "Only explosive experts"};
		default = 1;
		};
	class AmntEnemies // select12v
		{
		title = "How many resitance will be in the zone protecting the bomb?";
		values[] = {2, 3, 5, 7, 9};
		texts[] = {"Some", "Normal", "Doable", "A lot", "Impossible"};
		default = 3;
		};	