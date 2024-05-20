#!/bin/bash
# File paths
parking_data="parking_data.txt"
if [ ! -f "$parking_data" ]
 then
     touch "parking_data"
fi


# Initializing available spots
initialize_spots() {
 local i=1
 while [ $i -le 50 ]
  do
   echo $i
   i=$((i + 1))
 done > available_spots.txt
}

# if available_spots file doesnt exist run initialization
if [ ! -f "available_spots.txt" ]
 then
     initialize_spots
fi

#show available parking spots
show_available_spots() {
 echo " Available parking spots:"
 cat available_spots.txt
}
