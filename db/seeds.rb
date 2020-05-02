# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Hamburguesa.create(nombre: 'De la casa', precio: 5990, 
descripcion: 'Exquisita hamburguesa con queso y salsa BBQ, la especialidad de la casa',
imagen: 'https://cdn.hswstatic.com/gif/cheeseburger-1.jpg')

Ingrediente.create(nombre: 'Queso Cheddar', descripcion: 'Cheddar de la mejor calidad')