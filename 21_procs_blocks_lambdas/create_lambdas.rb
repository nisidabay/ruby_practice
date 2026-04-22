#!/usr/bin/env ruby

# Lambda must receive all the arguments
my_lambda = ->(name, age) { p "#{name} you're #{age} years old" }

# Proc will return the available arguments without break
my_proc = proc { |name, age| p "#{name} you're #{age} years old" }

def lambda_user(&code)
  code.call('Carlos', 61)
end

def proc_user(&code)
  code.call('Carlos')
end

lambda_user(&my_lambda)
proc_user(&my_proc)
