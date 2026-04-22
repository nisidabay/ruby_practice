#!/usr/bin/env ruby

cars= {toyota: "Camry", chevrolet: "Aveo", ford: "F150", kia: 
"Soul"}

p cars.include?(:toyota)    # Checks if the hash contains the given key
p cars.has_value?("Camry")  # Checks if the hash contains the given value
p cars.value?("Camry")      # Alias for has_value?, checks if the value exists
p cars.has_key?(:toyota)    # Checks if the hash contains the given key
p cars.key?(:toyota)        # Alias for has_key?, checks if the key exists

