#!/bin/bash

source data.sh

# generating parking tickets
generate_ticket_id() {
  local last_ticket=$(tail -1 "parking_data" | awk -F, '{print $1}' | sed 's/TICKET//')
  last_ticket=$((last_ticket + 1))
  echo "TICKET$last_ticket"
}

# park a car
park_car(){
    local car=$1
    local spot=$2

    if ! grep -qx "$spot" available_spots.txt; then
        echo "Spot $spot is not available."
        return 1
    fi

    local ticket_id=$(generate_ticket_id)
    echo "$ticket_id,$car,$spot,$(data +%s)" >> "$parking_data"
    sed -i "/^$spot$/d" available_spot.txt #Removes spot from available spots
    echo "Parked car: $car at spot: $spot with Ticket ID: $ticket_id"
}



