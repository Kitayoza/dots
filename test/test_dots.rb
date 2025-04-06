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
end
