OPTIONS='--no-weekdays --format=g -n15'  
./get_eng.rb EDW:TUH  EDW:LBG  $OPTIONS  | tee 	 extract/weekend_edw.txt
./get_eng.rb PMR:BFR PMR:VIC PMR:BMS  PMR:ZCW PMR:CLJ  $OPTIONS  | tee 	 extract/weekend_pmr.txt

# a feature -  CLJ:WWO only gives you half the story becuase of "the train will divide"
./get_eng.rb HHE:WWO BTN:WWO WWO:BAA $OPTIONS  | tee 	 extract/weekend_worthing.txt
exit





