#!/usr/bin/env ruby
# Define an add_thirty_days method that accepts an array.
# The array will consist of strings representing a date.
# The dates will be in MM**DD**YYYY format (i.e. 12**02**2023).
# Add 30 days to each date.
# Return an array of strings with the new date in the
# same MM**DD**YYYY format.
#
# Examples:
# The => indicates the expected return value
#
# add_thirty_days(["05**28**2023", "09**12**1991", "02**08**2002"])
#  => ["06**27**2023", "10**12**1991", "03**10**2002"]
# add_thirty_days(["01**01**2023", "03**01**2025", "05**01**2027"])
#  => ["01**31**2023", "03**31**2025", "05**31**2027"]
require 'time'
def add_thirty_days(array)
  date_format = '%m**%d**%Y'
  array.map do |value|
    date_obj = Date.strptime(value, date_format)
    new_date = date_obj + 30
    new_date.strftime(date_format)
  end
end
p add_thirty_days(['05**28**2023', '09**12**1991', '02**08**2002'])
p add_thirty_days(['01**01**2023', '03**01**2025', '05**01**2027'])
