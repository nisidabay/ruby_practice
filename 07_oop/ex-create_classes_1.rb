# Define a Cookie class within the file.
# Declare a create_cookie method that returns a Cookie object/instance
# Declare a multiple_cookies method that returns an array of
# two separate Cookie objects
#
class Cookie
end

def create_cookie
  Cookie.new
end

def multiple_cookies
  [Cookie.new, Cookie.new]
end

cookie= create_cookie
p cookie
cookies= multiple_cookies
p cookies
