#!/bin/bash
source parking.sh

# Main menu 

while true
 do
   echo "Parking Lot System"
   echo "1. Park a car"
   echo "2. Retrieve a car"
   echo "3. Show available parking spots"
   echo "4. Exit"

   read -p "Enter your choice: " choice
   
   case $choice in
      1)
        read -p "Enter car registration number: " car_number
        read -p "Enter parking spot number: " spot_number 

        park_car "$car_number" "$spot_number"
        ;;
 
      2) 
        read -p "Enter ticket ID: " ticket
        retrieve_car "$ticket"
        ;;

      3) 
        show_available_spots
        ;;
 
      4) 
  
         break
         ;;
      *) 
        echo "Invalid choice. Please try again. "
        ;; 
   esac
   echo 
done
