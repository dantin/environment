#! /bin/bash

############################################################
# Print OS summary (OS, ARCH, VERSION)
############################################################
function show_os_arch_version {
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
if [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	OS=$DISTRIB_ID
	VERSION=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
	# Work on Debian and Ubuntu alike
																	OS=$(lsb_release -si)
																			VERSION=$(lsb_release -sr)
																				elif [ -f /etc/redhat-release ]; then
																							# Add code for Red Hat and CentOS here
																									OS=Redhat
																											VERSION=$(uname -r)
																												else
																															# Pretty old OS? fallback to compatibility mode
																																	OS=$(uname -s)
																																			VERSION=$(uname -r)
																																				fi

																																					OS_SUMMARY=$OS
																																						OS_SUMMARY+=" "
																																							OS_SUMMARY+=$VERSION
																																								OS_SUMMARY+=" "
																																									OS_SUMMARY+=$ARCH
																																										OS_SUMMARY+="bit"

																																											print_info "$OS_SUMMARY"
																																										}
