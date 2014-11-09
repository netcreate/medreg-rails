# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teachers = Teacher.create([
  {
    code: 'REA',
    name: 'Anne',
    surname: 'Reitsma',
  },
  {
    code: 'VUH',
    name: 'Hans',
    surname: 'Vuurman',
  },
  {
    code: 'VEF',
    name: 'Foekje',
    infix: 'van der',
    surname: 'Velde',
  }
])

students = Student.create([
  {
    code: '100001',
    name: 'Manon',
    surname: 'Vermeulen',
  },
  {
    code: '100002',
    name: 'Feike',
    surname: 'Hof',
  },
  {
    code: '100003',
    name: 'Bas',
    infix: 'van der',
    surname: 'Hoek',
  }
])

groups = Group.create([
  {
    code: 'G1A',
    description: 'Gymnasium 1A',
    teacher: teachers[0],
    students: [
      students[0],
      students[1],
    ],
  },
  {
    code: 'G2A',
    description: 'Gymnasium 2A',
    teacher: teachers[1],
  },
])
