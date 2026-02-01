class Laptop {
    var maker: String = ""   // Производитель
    var model: String = ""          // Модель
    var price: Double = 0.0         // Цена (в рублях или любой валюте)
    var diagonal: Double = 0.0  // Диагональ экрана в дюймах

    // Первичный конструктор — первый параметр из списка = Производитель
    constructor(maker: String) {
        this.maker = maker
    }

    // Вторичный конструктор — все параметры
    constructor(
        maker: String,
        model: String,
        price: Double,
        diagonal: Double
    ) : this(maker) {
        this.model = model
        this.price = price
        this.diagonal = diagonal
    }

    // Блок init — общая инициализация
    init {
        if (price < 0) price = 0.0
        if (diagonal < 0) diagonal = 0.0
    }

    // Метод для вывода всей информации
    fun printInfo() {
        println("Ноутбук: $maker $model")
        println("Цена: ${String.format("%.2f", price)} ₽")
        println("Диагональ экрана: ${String.format("%.1f", diagonal)} дюймов")
        println("-----------------------------")
    }

    // Свойство только для чтения — последнее поле из списка
    val diagonalInfo: String
        get() = "Диагональ экрана: ${String.format("%.1f", diagonal)} дюймов"

    // Кастомные сеттеры с проверками (геттеры можно оставить дефолтными, но для единообразия тоже переопределили)

    var makerChecked: String
        get() = maker
        set(value) {
            val trimmed = value.trim()
            if (trimmed.isNotEmpty()) {
                maker = trimmed
            } else {
                println("Ошибка: производитель не может быть пустым")
            }
        }

    var modelChecked: String
        get() = model
        set(value) {
            val trimmed = value.trim()
            if (trimmed.isNotEmpty()) {
                model = trimmed
            } else {
                println("Ошибка: модель не может быть пустой")
            }
        }

    var priceChecked: Double
        get() = price
        set(value) {
            if (value >= 0) {
                price = value
            } else {
                println("Ошибка: цена не может быть отрицательной")
            }
        }

    var diagonalChecked: Double
        get() = diagonal
        set(value) {
            if (value >= 0) {
                diagonal = value
            } else {
                println("Ошибка: диагональ не может быть отрицательной")
            }
        }
}
