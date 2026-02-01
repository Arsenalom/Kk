fun main() {
    println("=== Тест первичного конструктора ===")
    val laptop1 = Laptop("Lenovo")
    laptop1.model = "ThinkPad X1 Carbon"
    laptop1.price = 185000.0
    laptop1.diagonal = 14.0

    laptop1.printInfo()
    println(laptop1.diagonalInfo)

    println("\n=== Тест вторичного конструктора ===")
    val laptop2 = Laptop("Apple", "MacBook Pro 16", 320000.0, 16.2)
    laptop2.printInfo()
    println(laptop2.diagonalInfo)

    println("\n=== Тест проверок сеттеров (некорректные и корректные значения) ===")
    val laptop3 = Laptop("ASUS", "ROG Strix", 210000.0, 17.3)

    laptop3.makerChecked = "  ASUS   "     // → обрежется до "ASUS"
    laptop3.modelChecked = ""                     // → ошибка
    laptop3.priceChecked = -15000.0               // → ошибка
    laptop3.diagonalChecked = 15.6          // нормально

    laptop3.printInfo()
    println(laptop3.diagonalInfo)                 // Диагональ экрана: 15.6 дюймов

    println("\n=== Массив из 3 ноутбуков ===")
    val laptops = arrayOf(
        Laptop("Dell", "XPS 13", 145000.0, 13.4),
        Laptop("HP", "Pavilion 15", 78000.0, 15.6),
        Laptop("Lenovo", "Legion 5", 165000.0, 15.6)
    )

    // Пример поиска: ноутбуки с диагональю 15.6 дюймов
    println("Ноутбуки с диагональю 15.6\":")
    laptops.filter { it.diagonal == 15.6 }
        .forEach { it.printInfo() }

    // Альтернативный поиск: ноутбуки дороже 100000
    println("\nНоутбуки дороже 100 000 ₽:")
    laptops.filter { it.price > 100000 }
        .forEach { it.printInfo() }
}
