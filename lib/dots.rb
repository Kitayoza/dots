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


  # норма вектора
  # vector = [x,y,z]
  def norma(vector)
    raise ArgumentError, "Вектор должен быть трехмерным" unless vector.size == 3
    Math.sqrt(vector[0] ** 2 + vector[1]**2 + vector[2]**2)
  end

  # расстояние между точкой и плоскостью
  # point = [x,y,z] - точка, задается трехмерным массивом
  # plane = [A,B,C,D] - плоскость, задается четырехмерным массивом, где
  # A * x + B * y + C * z+ D = 0 - уравнение плоскости
  def distance_between_point_and_plane(point, plane)
    raise ArgumentError, "Точка должна содержать 3 координаты" unless point.size == 3 
    raise ArgumentError, "Плоскость должна задаваться 4 цифрами" unless plane.size == 4 
    norma_plane = norma(plane[0..2])
    raise ArgumentError, "Хотя бы одно из чисел A, B, C должно быть ненулевым" if normal_plane.zero? 
    (plane[0] * point[0] + plane[1] * point[1] + plane[2]* point[2] + plane[3]).abs / normal_plane 
  end
  
  # Перпендикулярность плоскостей
  # plane1 = [A1,B1,C1,D1] - плоскость, задается четырехмерным массивом, где
  # A1 * x + B1 * y + C1 * z+ D1 = 0 - уравнение плоскости
  # plane2 = [A2,B2,C2,D2] - плоскость, задается четырехмерным массивом, где
  # A2 * x + B2 * y + C2 * z+ D2 = 0 - уравнение плоскости
  def planes_ortogonal? ( plane1,  plane2)
    raise ArgumentError, "Плоскость должна задаваться 4 цифрами" unless plane1.size == 4 && plane2.size == 4 
    raise ArgumentError, "Хотя бы одно из чисел A, B, C должно быть ненулевым для каждой плоскости" if norma(plane1[0..2]).zero? || norma(plane2[0..2]).zero?
    orthogonal?(plane1[0..2], plane2[0..2])
  end



end
