#!/bin/bash


# Jump host
echo "Token: "
read token


# Level=""
echo "alert - critical - error - warning - notification - information - notice"
read lvl


declare -A VRF_MAP
VRF_MAP=( [VRF1]=vrf1 [VRF2]=vrf2 [VRF3]=vrf3)


vrf=$(info.sh $1 | grep -i 'management' | awk '{print $5}')


case $vrf in
	"Default")
		short="${1:0:3}"
	;;
	*)
		echo "Check Router?"
	;;
esac


if [[ ${VRF_MAP[${short^^}]+_} ]]; then
	output=$(./info.exp $1 $token $lvl ${VRF_MAP[${short^^}]})
else
	echo "Site not in list of VRF's."
fi


v1=$(echo "$output" | grep -Eo '(tz="[-+0-9]+")' | grep -Eo '([-+0-9]+)')
v2=$(echo "$output" | grep -Eo '(logdesc="[A-Z a-z 0-9]+")')
v3=$(echo "$output" | grep -Eo '(eventtime=[0-9]+)' | grep -Eo '([0-9]{10})')
v4=$(echo "$output" | grep -Eo '( time=[0-9:]+)' | grep -Eo '([0-9:]+)')
v5=$(echo "$output" | grep -Eo '( date=[0-9-]+)' | grep -Eo '([0-9-]+)')


# read -ra ar1 <<< "$v1"
# read -ra ar2 <<< "$v2"
read -ra ar3 <<< "$v3"
# read -ra ar4 <<< "$v4"
# echo "${ar1[0]}"
# echo "${ar2[0]}"
echo "${ar3[0]}"
# echo "${ar4[0]}"


# Converts epoch time
date -d'@'$ar3''
