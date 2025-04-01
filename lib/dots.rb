# frozen_string_literal: true

require_relative "dots/version"

module Dots
  class Error < StandardError; end
  
  #расстояние между точками в пространстве
  def distance_between_two_points(x1, y1, z1, x2, y2, z2)
    Math.sqrt((x2 - x1)**2 + (y2 - y1)**2 + (z2 - z1)**2)
  end

  
  #проверка на ортогональность прямых
  def orthogonal?(vector1, vector2)
    raise ArgumentError, "Векторы должны быть трехмерными" unless vector1.size == 3 && vector2.size == 3
    scal = vector1[0] * vector2[0] + vector1[1] * vector2[1] + vector1[2] * vector2[2]
    scal.zero?
  end

  def direction_vector(point_a, point_b)
    [point_b[0] - point_a[0], point_b[1] - point_a[1], point_b[2] - point_a[2]]
  end
  
  def lines_orthogonal?(line1_a, line1_b, line2_a, line2_b)
    vec1 = direction_vector(line1_a, line1_b)
    vec2 = direction_vector(line2_a, line2_b)
    vectors_orthogonal?(vec1, vec2)
  end
  
end
