#!/usr/bin/env ruby
# Parameters
# This file contains Ruby code for parameters.

# frozen_string_literal: true
#!/usr/bin/ruby

# variable number of parameters
def sampledata(*data)
  p "The number of parameters is #{data.length}"
  for i in 0..data.length - 1
    p "The parameter is #{data[i]}"
  end
end

sampledata('Carlos', 57, 'M')
