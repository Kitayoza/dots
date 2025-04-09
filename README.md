# Dots

Гем `Dots` предоставляет функции для вычисления некоторых функций с базовыми стереометрическими объектами (точка, прямая, плоскость):
- расстояние между ними,
- определение параллельности и ортогональности, 
- вычисление нормы вектора.

## Установка
Добавить в Gemfile
```
bundle add dots --git=https://github.com/Kitayoza/dots.git
```
Или установить напрямую
```
gem install specific_install
gem specific_install -l https://github.com/Kitayoza/dots.git
```

## Использование

### Задание базовых объектов
1. Точка задается трехмерным массивом
    ```
    point = [x0, y0, z0]
    ```
1. Прямая задается массивом двух точек
    ```
    line_points = [[x1, y1, z1], [x2, y2, z2]]
    ```
1. Плоскость задается массивом коэффициентов $ A,B,C,D $, где $ Ax + By + Cz + D = 0 $ - уравнение плоскости
    ```
    plane = [A, B, C, D]
    ```

### Функции
1. Вычисление расстояния между
    - точками
    ```
    point1 = [0, 0, 0]
    point2 = [3, 4, 0]
    p ::Dots.distance_between_two_points(point1, point2) 
    # 5.0
    ```
    - точкой и прямой
    ```
    point = [1, 1, 1]
    line_points = [[0, 0, 0], [0, 0, 1]]
    p ::Dots.distance_between_point_and_line(point, line_points) 
    # 1.4142..
    ```
    - точкой и плоскостью
    ```
    point = [5, 0, 0]
    plane = [1, 0, 0, 0] 
    p ::Dots.distance_between_point_and_plane(point, plane)  
    # 5.0
    ```
    - прямой и плоскостью
    ```
    line = [[0,2,0],[0,0,0]]
    plane = [1, 0, 0, -3]
    p ::Dots.distance_between_line_and_plane(line, plane)
    # 3.0
    ```
    - плоскостями
    ```
    plane1 = [1, 0, 0, -3]
    plane2 = [1, 0, 0, -3]
    p ::Dots.distance_between_planes(plane1, plane2)
    # 0.0
    ```
2. Определение параллельности между
    - прямыми
    ```
    line1 = [[0, 0, 0], [1, 1, 1]]
    line2 = [[2, 2, 2], [3, 3, 3]]
    p ::Dots.lines_parallel?(line1, line2)
    # true
    ```
    - прямой и плоскостью
    ```
    line = [[1, 2, 3], [4, 5, 6]]
    plane = [1, 1, 1, -6]
    p ::Dots.line_and_plane_parallel?(line, plane)
    # true
    ```
    - плоскостями
    ```
    plane1 = [1, 0, 0, 4]
    plane2 = [0, 1, 0, -3]
    p ::Dots.planes_parallel?(plane1, plane2)
    # false
    ```
3. Определение перпендикулярности между
    - прямыми
    ```
    line1_a = [0,0,0]
    line1_b = [1,0,0]
    line2_a = [0,0,0] 
    line2_b = [0,1,0]
    p ::Dots.lines_orthogonal?(line1_a, line1_b, line2_a, line2_b)
    # true
    ```
    - прямой и плоскостью
    ```
    
    ```
    - плоскостями
    ```
    p ::Dots.planes_ortogonal?([1,0,0, 1], [2, 1, 0, 5])
    # false 
    ```
4. Вычисление нормы вектора
    ```
    vector = [0.1,0.2,0.2]
    p ::Dots.norma(vector)
    # 0.3
    ```

## Contributing

Сообщения об ошибках и пул-реквесты приветствуются на GitHub https://github.com/Kitayoza/dots.

## Лицензия

Гем доступен как открытое программное обеспечение на условиях [MIT License](https://opensource.org/licenses/MIT).
