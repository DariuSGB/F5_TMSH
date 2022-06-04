#########################################################################
# title: Check_External_Web.tcl                                         #
# author: Dario Garrido                                                 #
# date: 20200609                                                        #
# description: Modify config based on a external web resource           #
#########################################################################

if { [exec cat /var/prompt/ps1] == "Active" } {
	set query [exec sh -c {curl --connect-timeout 2 -sXGET http://1.1.1.1/service/status | jq ".status"}]
	set virtual [lindex [tmsh::get_config /ltm virtual myvirtual pool] 0]
	set pool [tmsh::get_field_value $virtual "pool"]
	switch $pool {
		pool_A {
			if { $query eq "Pool_B" } {
				tmsh::modify /ltm virtual myvirtual pool Pool_B
				tmsh::save sys config
			}
		}
		pool_B {
			if { $query eq "Pool_A" } {
				tmsh::modify /ltm virtual myvirtual pool Pool_A
				tmsh::save sys config
			}
		}
		default {
			tmsh::log "ERROR: Query - $query ; Pool - $pool"
		}
	}
}
