package OAStat;

public class SqlCondition {
	static StringBuffer condition = new StringBuffer();
	static public String getCreditCondition(String item,int type){
		clear(condition);
		if(type == 0){
			if(item.equals("FishermanCombo")){
				condition.append("Callback : Add crewTypeId = 21,%");
			}else if(item.equals("PirateCombo")){
				condition.append("Callback : Add crewTypeId = 22,%");
			}else if(item.equals("MissileCombo")){
				condition.append("Callback Credit: weaponType = 101,%");
			}else if(item.equals("BigMissileCombo")){
				condition.append("Callback Credit: weaponType = 102,%");
			}else if(item.equals("BigToolboxCombo")){
				condition.append("Callback Credit: weaponType = 104,%");
			}else if(item.equals("5_missile_combo")){
				condition.append("Callback Credit: weaponType = 111,%");
			}else if(item.equals("5_big_missile_combo")){
				condition.append("Callback Credit: weaponType = 112,%");
			}else if(item.equals("5_bigtoolbox_combo")){
				condition.append("Callback Credit: weaponType = 114,%");
			}else if(item.equals("10_missile_combo")){
				condition.append("Callback Credit: weaponType = 115,%");
			}else if(item.equals("10_big_missile_combo")){
				condition.append("Callback Credit: weaponType = 116,%");
			}else if(item.equals("10_bigtoolbox_combo")){
				condition.append("Callback Credit: weaponType = 118,%");
			}else if(item.equals("AbombLucky")){
				condition.append("Callback : ComboItem=3,from=hotShop,flag=combo%");
			}
			
		}else if(item.equals("avatar")){
			condition.append("Callback : add avatarType = ");
			condition.append(type);
			condition.append("[^0-9]%");
		}else if(item.equals("crew")){
			if(type==9){
				condition.append("Callback : Add crewTypeId = 9,from=hotShop,flag=New%");
			}else{
				condition.append("Callback : Add crewTypeId = ");
				condition.append(type);
				condition.append("[^0-9]%");
			}
		}else if(item.equals("weapon")){	
			condition.append("Callback Credit: weaponType = ");
			condition.append(type);
			if(type>4&&type<9){
				condition.append("%");
			}
			condition.append("[^0-9]%");
		}else if(item.equals("system")){
			condition.append("Callback Credit: weaponYardType = ");
			condition.append(type);
			condition.append("%");
		}else if(item.equals("warehouse")){
			condition.append("Callback Credit: warehouseTypeId = ");
			condition.append(type);
			condition.append("%");
		}else if(item.contains("Rent Ship")){
			condition.append("Callback Credit: rentShipType = ");
			condition.append(type);
			condition.append("%");
		}else if(item.contains("ABomb Combo") && type==1){
			condition.append("Callback Credit: weaponType = 105,%");
		}else if(item.contains("ABomb Combo") && type==2){
			condition.append("Callback Credit: weaponType = 106,%");
		}else if(item.contains("ABomb Combo") && type==3){
			condition.append("Callback Credit: weaponType = 123,%");
		}
		//big-bomb
		else if(item.contains("Big-Bomb") && type==15){
			condition.append("Callback Credit: weaponType = 15%");
		}else if(item.contains("Big-Bomb") && type==2){
			condition.append("Callback Credit: weaponType = 109,%");
		}else if(item.contains("Big-Bomb") && type==3){
			condition.append("Callback Credit: weaponType = 110,%");
		}
		//Whirlwind
		else if(item.contains("Whirlwind") && type==17){
			condition.append("Callback : Add Weapon = 17,from=hotShop,flag=Hot,r%");
		}else if(item.contains("Whirlwind") && type==2){
			condition.append("Callback Credit: weaponType = 124,%");
		}else if(item.contains("Whirlwind") && type==3){
			condition.append("Callback Credit: weaponType = 127,%");
		}
		//Fireball
		else if(item.contains("Fireball") && type==18){
			condition.append("Callback : Add Weapon = 18,from=hotShop,flag=Hot,r%");
		}else if(item.contains("Fireball") && type==2){
			condition.append("Callback Credit: weaponType = 125,%");
		}else if(item.contains("Fireball") && type==3){
			condition.append("Callback Credit: weaponType = 128,%");
		}
		//Thunderbolt
		else if(item.contains("Thunderbolt") && type==19){
			condition.append("Callback : Add Weapon = 19,from=hotShop,flag=Hot,r%");
		}else if(item.contains("Thunderbolt") && type==2){
			condition.append("Callback Credit: weaponType = 126,%");
		}else if(item.contains("Thunderbolt") && type==3){
			condition.append("Callback Credit: weaponType = 129,%");
		}
		//super-toolbox
		else if(item.contains("Super-toolbox") && type==16){
			condition.append("Callback Credit: weaponType = 16%");
		}else if(item.contains("Super-toolbox") && type==2){
			condition.append("Callback Credit: weaponType = 107,%");
		}else if(item.contains("Super-toolbox") && type==3){
			condition.append("Callback Credit: weaponType = 108,%");
		}else if(item.contains("Super-toolbox") && type==4){
			condition.append("Callback Credit: weaponType = 120,%");
		}
		//anti abomb
		else if(item.contains("anti abomb") && type==2){
			condition.append("Callback Credit: weaponType = 122,%");
		}
		//anti missile
		else if(item.contains("anti missile") && type==2){
			condition.append("Callback Credit: weaponType = 121,%");
		}
		//icon
		else if(item.contains("icon")){
			condition.append("reiconbycredit,iconId=0");
			condition.append(type);
			condition.append("%");
		}else if(item.contains("hot")){
			if(type==1){
				condition.append("Callback : Add crewTypeId = 1,from=hotShop,flag=Hot,num=10%");
			}else if(type==2){
				condition.append("Callback : Add crewTypeId = 4,from=hotShop,flag=Hot,num=10%");
			}else if(type==3){
				condition.append("Callback : Add crewTypeId = 8,from=hotShop,flag=Hot,num=10%");
			}else if(type==4){
				condition.append("Callback : CrewCombo FishermanCombo,from=hotShop,flag=Hot,num=10%");
			}else if(type==5){
				condition.append("Callback Credit:100 A-Bomb,from=hotShop,flag=Hot,%");
			}else if(type==6){
				condition.append("Callback Credit:100 super toolbox,from=hotShop,flag=Hot,%");
			}else if(type==7){
				condition.append("Callback Credit:10_bigtoolbox_combo,from=hotshop,flag=Hot,%");
			}else if(type==8){
				condition.append("Callback Credit:10_big_missile_combo,from=hotShop,flag=Hot,%");
			}
		}else if(item.contains("card_AbombLucky")){
			condition.append("Callback : ComboItem="+type+",from=hotShop,flag=combo,r%");
		}else if(item.equals("card")){
			condition.append("Callback : Add FishTackleId = "+type+"%");
		}
		return condition.toString();
	}

	static public String getUsedCondition(String item,int type){
		clear(condition);
		if(item.equals("avatar")){
			condition.append("Use avatarTypeId = ");
			condition.append(type);
			condition.append("%");
			
		}else if(item.equals("crew")){
			condition.append("Use crewTypeId = ");
			condition.append(type);
			condition.append("%");
			
		}else if(item.equals("weapon")){
			if(type == 8){
				condition.append("0 Use weaponTypeId = A-bomb");
				condition.append("%");			
			}else if((type<8 && type>3) || (type == 16)){
				condition.append("Use weaponTypeId = ");
				condition.append(type);
				condition.append("%");	
			}else if((type<4 && type>0) || (type == 15)){
				condition.append("1 Use weaponTypeId = ");
				condition.append(type);
				condition.append("%");	
			}else if(type == 9)
			{
				condition.append("Callback Credit:TBox=%"); 
			}else if(type == 10){
				condition.append("defenseSystem ,missile");
				condition.append("%");
			}else if(type == 11)
			{
				condition.append("defenseSystem ,A-bomb");
				condition.append("%");
			}

		}
		return condition.toString();
	}

	static public String getGoldCondition(String item,int type){
		clear(condition);
		if(type == 0){
			if(item.equals("FishermanCombo")){
				condition.append("Gold : Add Combo FishermanCombo");
			}else if(item.equals("PirateCombo")){
				condition.append("Gold : Add Combo PirateCombo");
			}else if(item.equals("MissileCombo")){
				condition.append("Gold:MissileCombo");
			}else if(item.equals("BigMissileCombo")){
				condition.append("Gold:BigMissileCombo");
			}else if(item.equals("BigToolboxCombo")){
				condition.append("Gold:BigToolboxCombo");
			}
			
		}else if(item.equals("avatar")){
			condition.append("Gold : add avatarType = ");
			condition.append(type);
			
		}else if(item.equals("crew")){
			condition.append("Gold : Add crewType=");
			condition.append(type);
			
		}else if(item.equals("rent ship")){
			condition.append("Gold : Add rentshipType=");
			condition.append(type);
		}else{
			
			condition.append("Gold:");
			condition.append(item);
		}
		
		
		return condition.toString();
	}
	
	static public String getToolBoxCondition(int toolbox,int type){
		clear(condition);
		
		condition.append("Use toolBox = ");
		condition.append(toolbox);
		condition.append("%");
		condition.append("ship type = ");
		condition.append(type);
		condition.append("[^0-9]%");
		
		return condition.toString();
	}
	
	static public void clear(StringBuffer sb){
		int a=sb.length();
		sb.delete(0,a);
	}

}
