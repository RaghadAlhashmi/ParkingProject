#!/bin/bash

source data.sh

# generating parking tickets
generate_ticket_id() {
  local last_ticket=$(tail -1 "parking_data" | awk -F, '{print $1}' | sed 's/TICKET//')
  last_ticket=$((last_ticket + 1))
  echo "TICKET$last_ticket"
}

# park a car

