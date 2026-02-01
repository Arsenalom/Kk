class Laptop {
    var maker: String = ""
        set(value) {
            val trimmed = value.trim()
            if (trimmed.isNotEmpty()) {
                field = trimmed
            } else {
                println("Ошибка: производитель (maker) не может быть пустым")
            }
        }

    var model: String = ""
        set(value) {
            val trimmed = value.trim()
            if (trimmed.isNotEmpty()) {
                field = trimmed
            } else {
                println("Ошибка: модель не может быть пустой")
            }
        }

    var price: Double = 0.0
        set(value) {
            if (value >= 0) {
                field = value
            } else {
                println("Ошибка: цена не может быть отрицательной (было: $value)")
            }
        }

    var diagonal: Double = 0.0
        set(value) {
            if (value >= 0) {
                field = value
            } else {
                println("Ошибка: диагональ не может быть отрицательной (было: $value)")
            }
        }

    // Первичный конструктор — первый параметр (maker)
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

    // Вывод всей информации об объекте
    fun printInfo() {
        println("Ноутбук: $maker $model")
        println("Цена: ${"%.2f".format(price)} ₽")
        println("Диагональ экрана: ${"%.1f".format(diagonal)} дюймов")
        println("-----------------------------")
    }

    // Свойство только для чтения — последнее поле из списка (диагональ)
    val diagonalInfo: String
        get() = "Диагональ экрана: ${"%.1f".format(diagonal)} дюймов"
}
