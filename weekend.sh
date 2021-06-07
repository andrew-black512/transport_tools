OPTIONS='--no-weekend --format=d --time=12:00 -n21'
#./train_times.rb EDW:TUH  EDW:LBG  $OPTIONS  | tee 	 extract/weekend_edw.txt
./train_times.rb PMR:BFR PMR:VIC PMR:BMS  PMR:ZCW PMR:CLJ  $OPTIONS  | tee 	 extract/weekend_pmr.txt
