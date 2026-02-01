fun main() {
    println("=== Тест первичного конструктора ===")
    val laptop1 = Laptop("Lenovo")
    laptop1.model = "Legion 5 Pro"
    laptop1.price = 149990.0
    laptop1.diagonal = 16.0

    laptop1.printInfo()
    println(laptop1.diagonalInfo)

    println("\n=== Тест вторичного конструктора + проверки ===")
    val laptop2 = Laptop("Apple", "MacBook Pro", 289000.0, 14.2)
    laptop2.diagonal = -1.0          // → ошибка, значение не изменится
    laptop2.maker = "  "             // → ошибка
    laptop2.model = "MacBook Pro 16\""  // нормально
    laptop2.printInfo()

    println("\n=== Массив ноутбуков ===")
    val laptops = arrayOf(
        Laptop("ASUS", "ROG Zephyrus", 199990.0, 15.6),
        Laptop("MSI", "GF63 Thin", 74990.0, 15.6),
        Laptop("Acer", "Nitro 5", 114990.0, 17.3)
    )

    // Поиск: ноутбуки с диагональю 15.6"
    println("Ноутбуки с диагональю 15.6 дюймов:")
    laptops.filter { it.diagonal == 15.6 }
        .forEach { it.printInfo() }
}
