# Pendubot
The repository includes a software implementation of an asymptotic observer and controls for a two-link robot called Pendubot.

Данный проект является реализацией разработанного алгоритма синтеза нелинейного асимтотического наблюдателя, т.е. 
восстановления информации о состоянии нелинейной динамической системы по её измеряемому выходу. Для демонстрации метода
используется его приложение к двухзвенному роботу-манипулятору.

Программы на языке среды MATLAB:
- delta_pol - вычисление эталонных полиномов.
- finding_l0 - вычисление значения lambda_{mdelta}, т.е. оптимальной матрицы L.
- gg2, gg4, grad2, grad4 - различные представления градиентов для компонент липшицевой вектор-функции g(x).
- lips_func - липшицевая вектор-функция g(x).
- lipschitz_const_check - проверка найденной константы Липшица.
- lipschitzconst - нахождение константы Липшица.
- matrix_A - матрица состояния линейной части в отклонениях от нижнего полож. равнов.
- matrix_B - матрица управления линейной части в отклонениях от нижнего полож. равнов.
- observ_func - вектор-функция f(y, u) измеряемых переменных.
- pb_model - Simulink-модель рассматриваемого объекта.
- PENDUBOT - стартовые процедуры симуляции.
- pendubot_animation - функция анимации объекта.
- pendubot_control - функция, формирующая управляющее воздействие.
- phis_param2theta - перевод физ. параметров в сгруппированный набор theta1 ... theta5.
- pole_del - вычисление значений lambda_{m0}.
- x_dot - правай часть исходных уравнений динамики робота.
- x_dot_lower_eq - правай часть уравнений динамики робота в отклонениях от нижнего полож. равнов.
- z_dot - правая часть уравнений нелинейного асимптотического наблюдателя для робота.

Помимо указанных программ, рассмотрим следующие:
- Папка "Упрощенная система" содержит аналогичные функции и скрипты, но для системы с упрощенной мат. моделью
- Папка "Положения равновесия" содержит скрипты выделения линейной части из нелинейных уравнений робота в отклонении от полож. равн.
- Папка "Анализ устойчивости" содержит функции и скрипты для анализа устойчивости нулевого положения ошибки наблюдения.

Есть вопросы? Пиши http://t.me/gden7s
