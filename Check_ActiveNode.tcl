#########################################################################
# title: Check_ActiveNode.tcl                                           #
# author: Dario Garrido                                                 #
# date: 20200417                                                        #
# description: Check if current BIG-IP has a role of active node        #
#########################################################################

# Only execute if local BIG-IP is active member
if { [exec cat /var/prompt/ps1] == "Active" } {
	tmsh::log "I'm active member!"
}
