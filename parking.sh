#!/bin/bash

source data.sh

# generating parking tickets
generate_ticket_id() {
  local last_ticket=$(tail -1 "parking_data.txt" | awk -F, '{print $1}' | sed 's/TICKET//')
  local ticket_number=$((last_ticket + 1))
  echo "TICKET$ticket_number"
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
    echo "$ticket_id,$car,$spot,$(date +%s)" >> "$parking_data"
    sed -i "/^$spot$/d" available_spots.txt #Removes spot from available spots
    echo "Parked car: $car at spot: $spot with Ticket ID: $ticket_id"
}


# Retrieve a car part of code
retrieve_car(){
    local ticket_id=$1
    local record=$(grep "^$ticket_id," "$parking_data")
    if [ -z "$record" ]; then
        echo "Invalid ticket ID"
        return 1
    fi
    local spot=$(echo "$record" | cut -d',' -f3)
    local parked_time=$(echo "$record" | cut -d',' -f4)
    local current_time=$(date +%s)
    local parked_duration=$(( (current_time - parked_time) / 60 ))
    local cost=$(awk "BEGIN {print $parked_duration * 0.50}")

    sed -i "/^$ticket_id,/d" "$parking_data"
    echo "$spot" >> available_spots.txt #Adds spot back to available spots
    echo "Retrieved car from spot: $spot. Parked duration: $parked_duration minutes.Cost: $cost SAR"

}

