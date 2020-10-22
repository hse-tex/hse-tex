# hse-tex
Репозиторий создан для публикации затеханых материалов для студентов Факультета компьютерных наук с образовательной программы Прикладная математика и информатика, НИУ ВШЭ, Москва.

Версия этого документа доступна на сайте [hse-tex.me](https://hse-tex.me/).

Актуальные новости публикуются в Telegram-канале [@hsetex](https://t.me/hsetex).

---

При нахождении опечатки можно создать [issue](https://docs.github.com/en/enterprise/2.15/user/articles/creating-an-issue) или исправить её самостоятельно в [pull request'e](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

# Навигация

- [1 курс](#1-курс)
- [2 курс](#2-курс)
- [Благодарность](#благодарность)
- [Style guide](#style-guide)

# Материалы

## 1 курс

### Алгебра

- [Экзамен](https://hse-tex.me/course-1/algebra-exam.pdf)

### Дискретная математика

- [Коллоквиум I](https://hse-tex.me/course-1/discrete-mathematics-colloquium-1.pdf)
- [Коллоквиум II](https://hse-tex.me/course-1/discrete-mathematics-colloquium-2.pdf)

### Линейная алгебра

- [Конспект](https://hse-tex.me/course-1/linear-algebra.pdf)
- [Коллоквиум I](https://hse-tex.me/course-1/linear-algebra-colloquium-1.pdf)
- [Коллоквиум II](https://hse-tex.me/course-1/linear-algebra-colloquium-2.pdf)
- [Экзамен II: определения](https://hse-tex.me/course-1/linear-algebra-exam-definitions-2.pdf)

### Математический анализ

- [Коллоквиум I](https://hse-tex.me/course-1/mathematical-analysis-colloquium-1.pdf)
- [Коллоквиум II](https://hse-tex.me/course-1/mathematical-analysis-colloquium-2.pdf)
- [Коллоквиум III](https://hse-tex.me/course-1/mathematical-analysis-colloquium-3.pdf)
- [Коллоквиум IV](https://hse-tex.me/course-1/mathematical-analysis-colloquium-4.pdf)
- [Экзамен I](https://hse-tex.me/course-1/mathematical-analysis-exam-1.pdf)

## 2 курс

### Математический анализ

- [Конспект](https://hse-tex.me/course-2/mathematical-analysis.pdf)
- [Коллоквиум I](https://hse-tex.me/course-2/mathematical-analysis-colloquium-1.pdf)
- [Коллоквиум I [альтернативная версия]](https://docs.google.com/viewer?url=https://raw.githubusercontent.com/DKozl50/Matan2-tex/master/Colloquiums/colloq1.pdf)

### Дискретная математика

- [Конспект](https://hse-tex.me/course-2/discrete-mathematics.pdf)
- [Конспект [альтернативная версия]](https://hse-tex.me/course-2/discrete-math-02-lecture-notes.pdf)

### Теория вероятностей и математическая статистика

- [Коллоквиум I](https://hse-tex.me/course-2/probability-theory-colloquium-1.pdf)

# Благодарность

## Преподаватели

Благодарность выражается

- Авдееву Роману Сергеевичу за прекрасный курс по линейной алгебре
- Косову Егору Дмитриевичу за предоставленный исходный код записей с лекций
- Рубцову Александру Александровичу за PDF с конспектом лекций

## Контрибьюторы

Люди, которые помогали пополнять материалы и улучшать их качество:

- [Игорь Балюк](https://github.com/lodthe)
- [Вячеслав Бобень](https://github.com/darkkeks)
- [Андрей Филиппов](https://github.com/AIWMUS)
- [Денис Козлов](https://github.com/DKozl50)
- [Сергей Лоптев](https://github.com/beastSL)
- Даниил Казанцев
- [Сергей Рахманов](https://github.com/shoraii)
- [Болонин Денис](https://github.com/BoloniniD)


Не стесняйтесь добавлять себя в этот список в pull request'ах.

# Style guide

На данный момент в CI нет линтера. В этой секции собраны советы, как сделать TeX чище и читабельнее.

- Не думайте "Ну это же TeX, а не код, тут не надо писать красиво". Надо.

- Самое важное: **сделайте свой TeX консистентным**. Старайтесь писать в одном стиле. Чтобы одинаковые места в разных частях документа оформлялись схожим образом.

- Не используйте стандартное оформление для гиперссылок. Красные прямоугольники в тексте выглядят ужасно. Например, вместо этого можно выделять ссылки синим цветом:
    ```
    \usepackage[unicode=true, colorlinks=true, linkcolor=blue, urlcolor=blue]{hyperref}
    ```

    Было

    ![Красные ссылки](https://i.imgur.com/nVDsk2t.png)

    Стало 

    ![Синие ссылки](https://i.imgur.com/hcgLZiC.png)

- Старайтесь не писать много операторов подряд без пробельных символов, чтобы TeX читался лучше. 
    Например, вместо `F\simeq\FF_{p^m}\implies\RR^n\simeqS` лучше написать `F \simeq \FF_{p^m} \implies \RR^n \simeq S`.

- Для того, чтобы начать новый абзац, вместо `\\` можно оставить следующую строку пустой.

    Было
    ```
    ... мы доказали первый пункт теоремы. \\
    Чтобы дказать следующий пункт, вспомним теорему Пифагора.
    ```
    Стало
    ```
    ... мы доказали первый пункт теоремы.

    Чтобы дказать следующий пункт, вспомним теорему Пифагора.
    ```

- Вместо `\Longrightarrow` и `\Rightarrow` лучше использовать `\implies`, вместо `\Leftrightarrow` &mdash; `\iff`, когда это подходит по контексту.

- Вместо `tan`, `cos`, `tg`, `sup`, `lim` используйте `\tan`, `\cos`, `\tg`, `\sup`, `\lim` и так далее.

- Мы используем `\leqslant` вместо `\leq`. Поэтому в репозитории `\leq` будет переопределен как `\leqslant`, чтобы не было соблазна не использовать `\leqslant`.

- Ставьте пробел после запятой.

- Если в скобки надо обернуть выражение, которое по размеру выше стандартных скобок, используйте конструкции вида `\left( ... \right)`, `\left[ ... \right]` и так далее, а не просто `(...)`, `[...]`.

- Если необходимо быстро найти обозначение какого-то математического символа, можно использовать [detexify](https://detexify.kirelabs.org/classify.html), [этот](https://oeis.org/wiki/List_of_LaTeX_mathematical_symbols) и [этот](http://tug.ctan.org/info/symbols/comprehensive/symbols-a4.pdf) ресурсы.



## Лицензия

В репозитории используется лицензия MIT.

>Эта лицензия — разрешительная, без копилефта. Она разрешает использование и изменение кода практически любым образом, при условии, что текст самой лицензии и указание авторства никуда не исчезнут, даже если вы разобьете изначальный проект на части.
