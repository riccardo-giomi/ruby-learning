# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#

# I loved this solution from
# http://stackoverflow.com/questions/3834203/ruby-koan-151-raising-exceptions.
def triangle(a, b, c)
  x, y, z = [a, b, c].sort

  # All sides must be positive,
  # if the smallest side is then the other will be as well.
  raise TriangleError if x <= 0
  # The sum of any 2 sides must be longer than the 3rd side.
  # If it's true for the 2 smaller sides than it for the other combinations as well.
  raise TriangleError if x + y <= z

  [:equilateral, :isosceles, :scalene].fetch([a, b, c].uniq.size - 1)
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
