CONF_FILE=../../conf/setup-micro.conf
NODE_1=cdc-hpcblx033-17.bfd.walmart.com
NODE_2=cdc-hpcblx033-18.bfd.walmart.com
NODE_3=cdc-hpcblx033-19.bfd.walmart.com
NODE_4=cdc-hpcblx033-20.bfd.walmart.com

echo "$CONF_FILE"
source $CONF_FILE
# 100 dirs
wget -O "Real-100-1-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/display.db/daily_customer_signup&server=$NODE_2"
sleep 5
wget -O "Real-100-2-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/vmktg_low.db/btc_to_rfid&server=$NODE_2" 
sleep 5
wget -O "Real-100-3-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/user/agupta&server=$NODE_2" 
sleep 5

# 1000 dirs
wget -O "Real-1000-1-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/cia.db/pinterest_data.old&server=$NODE_2"
sleep 5
wget -O "Real-1000-2-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/cia.db/cat_pc_analysis&server=$NODE_2" 
sleep 5
wget -O "Real-1000-3-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/arcadia.db/daily_ad_randomized_pageid_summary&server=$NODE_2" 
sleep 5

# 10000 dirs
wget -O "Real-10000-1-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/targeting_crm_sc.db&server=$NODE_2"
sleep 5
wget -O "Real-10000-2-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/gtang01.db&server=$NODE_2" 
sleep 5
wget -O "Real-10000-3-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/targeting_pb.db&server=$NODE_2" 
sleep 5

# 100000 dirs
wget -O "Real-100000-1-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/tmp&server=$NODE_2"
sleep 5
wget -O "Real-100000-2-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/display.db/adserver_logs&server=$NODE_2" 
sleep 5
wget -O "Real-100000-2-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/smartpricing.db&server=$NODE_2" 
sleep 5
# 1000000 dirs
wget -O "Real-1000000-1.log" "http://$NODE_1:50070/movens.jsp?path=/test1/hive/targeting_real_time.db&server=$NODE_2"
sleep 5



#########################2 round #####################
# 100 dirs
wget -O "Real-100-1-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/display.db/daily_customer_signup&server=$NODE_3"
sleep 5
wget -O "Real-100-2-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/vmktg_low.db/btc_to_rfid&server=$NODE_3" 
sleep 5
wget -O "Real-100-3-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/user/agupta&server=$NODE_3" 
sleep 5

# 1000 dirs
wget -O "Real-1000-1-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/cia.db/pinterest_data.old&server=$NODE_3"
sleep 5
wget -O "Real-1000-2-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/cia.db/cat_pc_analysis&server=$NODE_3" 
sleep 5
wget -O "Real-1000-3-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/arcadia.db/daily_ad_randomized_pageid_summary&server=$NODE_3" 
sleep 5

# 10000 dirs
wget -O "Real-10000-1-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/targeting_crm_sc.db&server=$NODE_3"
sleep 5
wget -O "Real-10000-2-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/gtang01.db&server=$NODE_3" 
sleep 5
wget -O "Real-10000-3-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/targeting_pb.db&server=$NODE_3" 
sleep 5

# 100000 dirs
wget -O "Real-100000-1-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/tmp&server=$NODE_3"
sleep 5
wget -O "Real-100000-2-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/display.db/adserver_logs&server=$NODE_3" 
sleep 5
wget -O "Real-100000-2-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/smartpricing.db&server=$NODE_3" 
sleep 5
# 1000000 dirs
wget -O "Real-1000000-1-2.log" "http://$NODE_2:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/targeting_real_time.db&server=$NODE_3"
sleep 5

#########################3 round #####################
# 100 dirs
wget -O "Real-100-1-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/display.db/daily_customer_signup&server=$NODE_4"
sleep 5
wget -O "Real-100-2-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/vmktg_low.db/btc_to_rfid&server=$NODE_4" 
sleep 5
wget -O "Real-100-3-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/user/agupta&server=$NODE_4" 
sleep 5

# 1000 dirs
wget -O "Real-1000-1-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/cia.db/pinterest_data.old&server=$NODE_4"
sleep 5
wget -O "Real-1000-2-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/cia.db/cat_pc_analysis&server=$NODE_4" 
sleep 5
wget -O "Real-1000-3-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/arcadia.db/daily_ad_randomized_pageid_summary&server=$NODE_4" 
sleep 5

# 10000 dirs
wget -O "Real-10000-1-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/targeting_crm_sc.db&server=$NODE_4"
sleep 5
wget -O "Real-10000-2-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/gtang01.db&server=$NODE_4" 
sleep 5
wget -O "Real-10000-3-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/targeting_pb.db&server=$NODE_4" 
sleep 5

# 100000 dirs
wget -O "Real-100000-1-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/tmp&server=$NODE_4"
sleep 5
wget -O "Real-100000-2-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/display.db/adserver_logs&server=$NODE_4" 
sleep 5
wget -O "Real-100000-2-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/smartpricing.db&server=$NODE_4" 
sleep 5

# 1000000 dirs
wget -O "Real-1000000-1-3.log" "http://$NODE_3:50070/movens.jsp?path=/distr_from_$NODE_1/test1/hive/targeting_real_time.db&server=$NODE_4"
sleep 5
