# frozen_string_literal: true

require_relative "dots/version"

module Dots
  class Error < StandardError; end
  
  #расстояние между точками в пространстве
  # point = [x,y,z] - точка, задается трехмерным массивом
  def self.distance_between_two_points(point_a, point_b)
    Math.sqrt(
      (point_b[0] - point_a[0])**2 +
      (point_b[1] - point_a[1])**2 +
      (point_b[2] - point_a[2])**2
    )
  end

  
  #проверка на ортогональность прямых

  # vector = [x,y,z]
  def self.orthogonal?(vector1, vector2)
    raise ArgumentError, "Векторы должны быть трехмерными" unless vector1.size == 3 && vector2.size == 3
    scal = vector1[0] * vector2[0] + vector1[1] * vector2[1] + vector1[2] * vector2[2]
    scal.zero?
  end

  # point = [x,y,z]
  def self.direction_vector(point_a, point_b)
    [point_b[0] - point_a[0], point_b[1] - point_a[1], point_b[2] - point_a[2]]
  end
  
  #line1_ = [x,y,z]
  def self.lines_orthogonal?(line1_a, line1_b, line2_a, line2_b)
    vec1 = direction_vector(line1_a, line1_b)
    vec2 = direction_vector(line2_a, line2_b)

      # Проверка на вырожденные линии
    if vec1.all?(&:zero?) || vec2.all?(&:zero?)
      return false
    end
    
    orthogonal?(vec1, vec2)
  end


  # норма вектора
  # vector = [x,y,z]
  def self.norma(vector)
    raise ArgumentError, "Вектор должен быть трехмерным" unless vector.size == 3
    Math.sqrt(vector[0] ** 2 + vector[1]**2 + vector[2]**2)
  end

  # расстояние между точкой и плоскостью
  # point = [x,y,z] - точка, задается трехмерным массивом
  # plane = [A,B,C,D] - плоскость, задается четырехмерным массивом, где
  # A * x + B * y + C * z+ D = 0 - уравнение плоскости
  def self.distance_between_point_and_plane(point, plane)
    raise ArgumentError, "Точка должна содержать 3 координаты" unless point.size == 3 
    raise ArgumentError, "Плоскость должна задаваться 4 цифрами" unless plane.size == 4 
    norma_plane = norma(plane[0..2])
    raise ArgumentError, "Хотя бы одно из чисел A, B, C должно быть ненулевым" if norma_plane.zero? 
    (plane[0] * point[0] + plane[1] * point[1] + plane[2]* point[2] + plane[3]).abs / norma_plane 
  end
  
  # Перпендикулярность плоскостей
  # plane1 = [A1,B1,C1,D1] - плоскость, задается четырехмерным массивом, где
  # A1 * x + B1 * y + C1 * z+ D1 = 0 - уравнение плоскости
  # plane2 = [A2,B2,C2,D2] - плоскость, задается четырехмерным массивом, где
  # A2 * x + B2 * y + C2 * z+ D2 = 0 - уравнение плоскости
  def self.planes_ortogonal?( plane1,  plane2)
    raise ArgumentError, "Плоскость должна задаваться 4 цифрами" unless plane1.size == 4 && plane2.size == 4 
    raise ArgumentError, "Хотя бы одно из чисел A, B, C должно быть ненулевым для каждой плоскости" if norma(plane1[0..2]).zero? || norma(plane2[0..2]).zero?
    orthogonal?(plane1[0..2], plane2[0..2])
  end

  # Расстояние между точкой и прямой
  # point = [x0, y0, z0] - точка, задается трехмерным массивом
  # line_points = [[x1, y1, z1], [x2, y2, z2]] - две точки, задающие прямую
  def self.distance_between_point_and_line(point, line_points)
    raise ArgumentError, "Точка должна содержать 3 координаты" unless point.size == 3
    raise ArgumentError, "Прямая должна задаваться двумя точками" unless line_points.size == 2 && line_points.all? {|p| p.size == 3}

    p_a, p_b = line_points
    d_vec = direction_vector(p_a, p_b)

    raise ArgumentError, "Направляющий вектор должен быть ненулевым" if d_vec.all?{|p| p.zero?} #если p_a, p_b одинаковые точки

    vec = direction_vector(p_a, point)

    norma([
      vec[1] * d_vec[2] - vec[2] * d_vec[1],
      vec[2] * d_vec[0] - vec[0] * d_vec[2],
      vec[0] * d_vec[1] - vec[1] * d_vec[0]
    ])/norma(d_vec) 

  end

end
