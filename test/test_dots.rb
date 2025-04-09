# frozen_string_literal: true

require_relative "test_helper"

class TestDots < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Dots::VERSION
  end

  #def test_it_does_something_useful
  #  assert false
  #end

  # Тесты для distance_between_two_points

  def test_invalid_distance_between_two_points
    assert_raises(ArgumentError) do
      ::Dots.distance_between_two_points([],[])
    end

    assert_raises(ArgumentError) do
      ::Dots.distance_between_two_points([1,1],[2,3])
    end
  end

  def test_distance_2d
    # 2D случай (расстояние между (0,0,0) и (3,4,0) должно быть 5)
    assert_in_delta 5.0, 
                    ::Dots.distance_between_two_points([0, 0, 0], [3, 4, 0]), 
                    0.001 #допустимая погрешность
  end

def test_distance_3d
  # 3D случай (расстояние между (0,0,0) и (1,2,3))
  expected = Math.sqrt(4**2 + 6**2 + 9**2)
  assert_in_delta expected, ::Dots.distance_between_two_points([0, 0, 0], [4, 6, 9]), 0.001
end

  def test_zero_distance
    # Нулевое расстояние между одинаковыми точками
    assert_equal 0.0, ::Dots.distance_between_two_points([5, 5, 5], [5, 5, 5])
  end

  def test_negative_coordinates
    # Отрицательные координаты
    assert_in_delta 5.0, 
                    ::Dots.distance_between_two_points([-1, -1, 0], [2, 3, 0]), 
                    0.001
  end

  def test_floating_point_precision
    # Проверка точности с дробными числами
    assert_in_delta 1.414, 
                    ::Dots.distance_between_two_points([0.5, 0.5, 0], [1.5, 1.5, 0]), 
                    0.001
  end

  #=======================================================================================

  # Тесты для self.lines_orthogonal?

  def test_invalid_lines_orthogonal
    assert_raises(ArgumentError) do
      ::Dots.lines_orthogonal?([],[],[],[] )
    end

    assert_raises(ArgumentError) do
      ::Dots.lines_orthogonal?([1,1],[2,3], [0,0,0], [0,0,0])
    end

    assert_raises(ArgumentError) do
      ::Dots.lines_orthogonal?([2,3], [0,0,0], [0,0,0])
    end
  end

  def test_orthogonal_lines
    # Перпендикулярные линии вдоль осей
    assert_equal true, ::Dots.lines_orthogonal?([0,0,0], [1,0,0], [0,0,0], [0,1,0])
    assert_equal true, ::Dots.lines_orthogonal?([0,0,0], [0,2,0], [0,0,0], [0,0,3])
    assert_equal true, ::Dots.lines_orthogonal?([1,1,1], [1,1,2], [1,1,1], [1,2,1])
    
    # Перпендикулярные линии не вдоль осей
    assert_equal true, ::Dots.lines_orthogonal?([0,0,0], [1,1,0], [0,0,0], [-1,1,0])
    assert_equal true, ::Dots.lines_orthogonal?([1,2,3], [2,3,4], [1,2,3], [2,1,3])
  end

  def test_non_orthogonal_lines
    # Не перпендикулярные линии
    assert_equal false, ::Dots.lines_orthogonal?([0,0,0], [1,0,0], [0,0,0], [1,1,0])
    assert_equal false, ::Dots.lines_orthogonal?([0,0,0], [1,1,1], [0,0,0], [2,2,2])
    assert_equal false, ::Dots.lines_orthogonal?([1,2,3], [2,4,6], [0,0,0], [1,1,1])
  end

  def test_parallel_lines
    # Параллельные линии (не перпендикулярны)
    assert_equal false, ::Dots.lines_orthogonal?([0,0,0], [1,0,0], [0,1,0], [1,1,0])
    assert_equal false, ::Dots.lines_orthogonal?([1,1,1], [2,2,2], [0,0,0], [1,1,1])
  end

  def test_same_line
    # Одна и та же линия (не перпендикулярна сама себе)
    assert_equal false, ::Dots.lines_orthogonal?([0,0,0], [1,0,0], [0,0,0], [1,0,0])
    assert_equal false, ::Dots.lines_orthogonal?([1,2,3], [4,5,6], [1,2,3], [4,5,6])
  end

  def test_degenerate_line
    # Вырожденные линии (длина = 0)
    assert_equal false, ::Dots.lines_orthogonal?([0,0,0], [0,0,0], [0,0,0], [0,0,0])
    assert_equal false, ::Dots.lines_orthogonal?([1,1,1], [1,1,1], [2,2,2], [2,2,2])
  end

  def test_3d_orthogonal
    # 3D перпендикулярные линии
    assert_equal true, ::Dots.lines_orthogonal?([0,0,0], [1,1,0], [0,0,0], [0,0,1])
    assert_equal false, ::Dots.lines_orthogonal?([1,1,1], [2,2,1], [1,1,1], [1,0,1])
  end

  def test_negative_coordinates
    # Линии с отрицательными координатами
    assert_equal true, ::Dots.lines_orthogonal?([-1,-1,-1], [-1,-1,0], [-1,-1,-1], [-2,-1,-1])
    assert_equal false, ::Dots.lines_orthogonal?([-1,0,0], [-2,4,0], [0,-1,0], [0,-2,0])
  end


  #=======================================================================================

  # Тесты для self.norma(vector)

  def test_invalid_vector
    assert_raises(ArgumentError) do
      ::Dots.norma([])
    end
    assert_raises(ArgumentError) do
      ::Dots.norma([1])
    end
    assert_raises(ArgumentError) do
      ::Dots.norma([1,1])
    end
    assert_raises(ArgumentError) do
      ::Dots.norma([1,1,2,3])
    end
  end

  def test_norma_for_integer
    vector = [0,0,0]
    assert_in_delta 0.0, ::Dots.norma(vector), 0.001 

    vector1 = [1,0,0]
    assert_in_delta 1.0, ::Dots.norma(vector1), 0.001 

    vector2 = [3,4,0]
    assert_in_delta 5.0, ::Dots.norma(vector2), 0.001 

    vector2 = [1,2,2]
    assert_in_delta 3.0, ::Dots.norma(vector2), 0.001 
  end

  def test_norma_for_float
    vector = [0.1,0.2,0.2]
    assert_in_delta 0.3, ::Dots.norma(vector), 0.001 

    vector1 = [0.1,0,0]
    assert_in_delta 0.1, ::Dots.norma(vector1), 0.001 

    vector2 = [0.3,0.4,0]
    assert_in_delta 0.5, ::Dots.norma(vector2), 0.001 
  end

  #=======================================================================================

  # Тесты для self.distance_between_point_and_plane(point, plane)

  def test_invalid_point_size
    # Точка с недостающим количеством координат
    assert_raises(ArgumentError) do
      ::Dots.distance_between_point_and_plane([1, 2], [1, 2, 3, 4])
    end
  end

  def test_invalid_plane_size
    # Плоскость с недостающим количеством координат
    assert_raises(ArgumentError) do
      ::Dots.distance_between_point_and_plane([1, 2, 3], [1, 2, 3])
    end
  end

  def test_zero_normal_vector
    # Не уравнение плоскости
    assert_raises(ArgumentError) do
      ::Dots.distance_between_point_and_plane([1, 2, 3], [0, 0, 0, 5])
    end
  end

  def test_normal_case_distance
    # Плоскость  = 0 и точка на оси OX
    point = [5, 0, 0]
    plane = [1, 0, 0, 0] 
    assert_equal 5.0, ::Dots.distance_between_point_and_plane(point, plane)
  end

  def test_point_in_plane
    point = [1, -1, 0]
    plane = [1, 1, 1, 0] # x + y + z = 0
    assert_equal 0.0, ::Dots.distance_between_point_and_plane(point, plane)
  end

  def test_floating_distance_point_and_plane
    plane = [2, 2, 1, -4] 
    point = [0, 0, 0]
    expected = 4.0 / 3.0 
    assert_in_delta expected, ::Dots.distance_between_point_and_plane(point, plane), 1e-6
  end
  

  #=======================================================================================

  # Тесты для self.planes_ortogonal? 

  def test_invalid_planes_size
    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?([1, 2, 3], [0, 1, 0, 5])
    end

    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?([], [0, 0, 5])
    end

    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?( [0, 0, 5], [0, 0, 5])
    end

    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?([], [])
    end
  end

  def test_is_not_plane 
    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?([1, 2, 3,1], [0, 0, 0, 5])
    end

    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?([0,0,0, 1], [0, 0, 0, 5])
    end

    assert_raises(ArgumentError) do
      ::Dots.planes_ortogonal?([0,0,0, 1], [2, 1, 0, 5])
    end
  end

  def test_is_not_ortogonal_planes
    assert_equal false, ::Dots.planes_ortogonal?([1,0,0, 1], [2, 1, 0, 5])
    assert_equal false, ::Dots.planes_ortogonal?([1,0,0, 1], [2, 0, 0, 5])
    assert_equal false, ::Dots.planes_ortogonal?([1,0,0, 1], [-1, 0, 0, 5])
  end

  def test_is_ortogonal_planes
    assert_equal true, ::Dots.planes_ortogonal?([1,0,0, 1], [0, 1, 0, 5])
    assert_equal true, ::Dots.planes_ortogonal?([-1,2,0, 1], [2, 1, 0, 5])
    assert_equal true, ::Dots.planes_ortogonal?([-1,2,2, 1], [2, -1, 2, 0])
  end

#=======================================================================================
#=======================================================================================

  # Тесты для self.distance_between_point_and_line(point, line_points)

  def test_invalid_point_size
    assert_raises(ArgumentError) do
      ::Dots.distance_between_point_and_line([1, 2], [[0, 0, 0], [1, 1, 1]])
    end
  end
  
  def test_invalid_line_size
    assert_raises(ArgumentError) do
      ::Dots.distance_between_point_and_line([1, 2, 3], [[0, 0, 0]])
    end
  end
  
  def test_zero_direction_vector
    assert_raises(ArgumentError) do
      ::Dots.distance_between_point_and_line([1, 2, 3], [[0, 0, 0], [0, 0, 0]])
    end
  end
  
  def test_normal_case_distance
    point = [1, 1, 1]
    line_points = [[0, 0, 0], [0, 0, 1]]
    assert_equal Math.sqrt(2), ::Dots.distance_between_point_and_line(point, line_points)
  end
  
  def test_point_on_line
    point = [1, 1, 1]
    line_points = [[1, 1, 1], [2, 2, 2]]
    assert_equal 0.0, ::Dots.distance_between_point_and_line(point, line_points)
  end 

#=======================================================================================

  # Тесты для self.line_and_plane_orthogonal?(line_points, plane)

  def test_invalid
    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_orthogonal?([[1, 2, 3]], [1, 0, 0, 0])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_orthogonal?([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [1, 0, 0, 0])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_orthogonal?([[1, 2], [3, 4, 5]], [1, 0, 0, 0])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_orthogonal?([[1, 2, 3], [4, 5]], [1, 0, 0, 0])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_orthogonal?([[1, 2, 3], [4, 5, 6]], [1, 0, 0])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_orthogonal?([[1, 2, 3], [1, 2, 3]], [1, 0, 0, 0])
    end
  end

  def test_is_not_orthogonal
    assert_equal false, ::Dots.line_and_plane_orthogonal?([[1, 2, 3], [4, 5, 7]], [1, -1, 1, -3])
  end

  def test_is_orthogonal
    assert_equal true, ::Dots.line_and_plane_orthogonal?([[1, 2, 3], [1, 2, 4]], [1, 1, 0, -3])
  end
  
 #=======================================================================================

  # Тесты для self.line_and_plane_parallel?(line_points, plane)

  def test_parallel_lines_and_plane
    assert_equal true, ::Dots.line_and_plane_parallel?([[1, 2, 3], [4, 5, 6]], [1, 1, 1, -6])
  end

  def test_not_parallel_lines_and_plane
    assert_equal false, ::Dots.line_and_plane_parallel?([[1, 2, 3], [4, 5, 6]], [1, -1, 1, -3])
  end

  def test_invalid
    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_parallel?([[1, 2, 3], [1, 2, 3]], [1, 1, 1, -6])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_parallel?([[1, 2, 3]], [1, 1, 1, -6])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_parallel?([[1, 2, 3], [4, 5, 6]], [1, 1, 1])
    end

    assert_raises(ArgumentError) do
      ::Dots.line_and_plane_parallel?([[1, 2, 3], [1, 2, 3]], [1, -1, 1, -3])
    end
  end

  #=======================================================================================
  #=======================================================================================

  # Тесты для self.planes_parallel?

  def test_planes_parallel
    assert_equal true, ::Dots.planes_parallel?([1, 2, 3, 4], [2, 4, 6, 8])
  end

  def test_planes_not_parallel
    assert_equal false, ::Dots.planes_parallel?([1, 0, 0, 1], [0, 1, 0, 2])
  end

  def test_planes_parallel_invalid
    assert_raises(ArgumentError) do
      ::Dots.planes_parallel?([1, 2, 3], [1, 2, 3, 4])
    end

    assert_raises(ArgumentError) do
      ::Dots.planes_parallel?([1, 2, 3, 4], [1, 2])
    end
  end
  #=======================================================================================

  # Тесты для self.distance_between_planes

  def test_distance_between_parallel_planes
    plane1 = [0, 0, 1, -5]  # z = 5
    plane2 = [0, 0, 1, -10] # z = 10
    assert_in_delta 5.0, ::Dots.distance_between_planes(plane1, plane2), 0.0001
  end

  def test_distance_between_same_plane
    plane1 = [1, 0, 0, -3]
    plane2 = [1, 0, 0, -3]
    assert_in_delta 0.0, ::Dots.distance_between_planes(plane1, plane2), 0.0001
  end

  def test_distance_between_non_parallel_planes
    plane1 = [1, 0, 0, -1]
    plane2 = [0, 1, 0, -1]
    assert_equal 0, ::Dots.distance_between_planes(plane1, plane2)
  end

#=======================================================================================

  # Тесты для self.lines_parallel?

  def test_lines_parallel
    line1 = [[0, 0, 0], [1, 1, 1]]
    line2 = [[2, 2, 2], [3, 3, 3]]
    assert_equal true, ::Dots.lines_parallel?(line1, line2)
  end

  def test_lines_not_parallel
    line1 = [[0, 0, 0], [1, 0, 0]]
    line2 = [[0, 0, 0], [0, 1, 0]]
    assert_equal false, ::Dots.lines_parallel?(line1, line2)
  end

  def test_lines_parallel_invalid
    assert_raises(ArgumentError) do
      ::Dots.lines_parallel?([[0, 0, 0], [0, 0, 0]], [[1, 1, 1], [2, 2, 2]])
    end

    assert_raises(ArgumentError) do
      ::Dots.lines_parallel?([[1, 2, 3]], [[4, 5, 6], [7, 8, 9]])
    end

    assert_raises(ArgumentError) do
      ::Dots.lines_parallel?([[1, 2], [3, 4, 5]], [[4, 5, 6], [7, 8, 9]])
    end
  end

#=======================================================================================
  
# Тесты для self.distance_between_line_and_plane(line_points, plane)
  # расстояние между прямой и плоскости

  def test_invalid_line
    
    assert_raises(ArgumentError) do
      line = [[],[0,0,0]]
      plane = [0,1,0,0]
      ::Dots.distance_between_line_and_plane(line, plane)
    end

    assert_raises(ArgumentError) do
      line = [[0],[0,0,0]]
      plane = [0,1,0,0]
      ::Dots.distance_between_line_and_plane(line, plane)
    end

    assert_raises(ArgumentError) do
      line = [[0,0,0],[0,0,0]]
      plane = [0,1,0,0]
      ::Dots.distance_between_line_and_plane(line, plane)
    end

  end

  def test_invalid_plane
    
    assert_raises(ArgumentError) do
      line = [[1,0,0],[0,0,0]]
      plane = [0,0,0,0]
      ::Dots.distance_between_line_and_plane(line, plane)
    end

    assert_raises(ArgumentError) do
      line = [[1,0,0],[0,0,0]]
      plane = []
      ::Dots.distance_between_line_and_plane(line, plane)
    end

    assert_raises(ArgumentError) do
      line = [[1,0,0],[0,0,0]]
      plane = [0,0]
      ::Dots.distance_between_line_and_plane(line, plane)
    end

    assert_raises(ArgumentError) do
      line = [[1,0,0],[0,0,0]]
      plane = [0,0,0,5]
      ::Dots.distance_between_line_and_plane(line, plane)
    end

  end

  def test_line_in_plane
    line = [[2,0,0],[0,0,0]]
    plane = [1,0,0,0]
    assert_equal 0, ::Dots.distance_between_line_and_plane(line, plane)
  end  

  def test_line_in_plane
    line = [[2,0,0],[0,0,0]]
    plane = [1,0,0,0]
    assert_equal 0, ::Dots.distance_between_line_and_plane(line, plane)
  end

  def test_distance_between_line_and_plane
    line = [[0,2,0],[0,0,0]]
    plane = [1, 0, 0, -3]
    assert_in_delta 3.0, ::Dots.distance_between_line_and_plane(line, plane), 0.0001

    line1 = [[0,0,3],[0,0,0]]
    plane1 = [1, 1, 0, -3]
    assert_in_delta 3/ Math.sqrt(2), ::Dots.distance_between_line_and_plane(line1, plane1), 0.0001
  end

end
