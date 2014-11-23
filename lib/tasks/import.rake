namespace :import do
  desc 'Handles importing legacy stuff.'
  task :legacy => :environment do
    @db = SQLite3::Database.new 'legacy/legacy.sqlite3'

    puts 'Please configure this command manually.'
    puts 'Use with care.'

    # import_students
    # import_groups
    # import_students_groups
    # import_teachers
    # import_clusters
  end

  def import_clusters
    @db.execute 'SELECT * FROM clusters' do |row|
      group = Group.find_or_create_by!({
        code: row[1],
        type: 'cluster'
      })

      student = Student.find_by(code: row[0])

      unless student
        student = Student.create!({
          code: row[0],
          surname: row[2],
          infix: row[3],
          name: row[4],
        })
      end

      puts "Assigning student ##{student.code} to group ##{group.code}"

      group.students << student
    end
  end

  def import_groups
    @db.execute 'SELECT DISTINCT(klas) FROM leerlingen' do |row|
      group = Group.new({
        code: row[0]
      })

      group.save!
    end
  end

  def import_teachers
    # A teacher can be listed multiple times (code != UNIQUE).
    # This indicates that the teacher is a mentor to multiple groups.
    @db.execute 'SELECT * FROM docenten GROUP BY afkorting' do |row|
      teacher = Teacher.new({
        surname: row[1],
        infix: row[2],
        name: row[3],
        code: row[4]
      })

      teacher.save!

      determine_group_mentors(teacher)
    end
  end

  def determine_group_mentors(teacher)
    sql = "SELECT * FROM docenten WHERE mentorklas != '' AND afkorting = '#{teacher.code}'"

    @db.execute sql do |row|
      mentor_group = row[5]
      group = Group.find_by(code: mentor_group)

      if group
        group.teacher = teacher
        group.save!
      else
        puts "Mentor Group not found: #{mentor_group}"
      end
    end
  end

  def import_students_groups
    @db.execute 'SELECT * FROM leerlingen' do |row|
      student = Student.find_by(code: row[0])
      group = Group.find_by(code: row[1])
      group.students << student
    end
  end

  def import_students
    @db.execute 'SELECT * FROM leerlingen' do |row|
      student = Student.new({
        code: row[0],
        # group: row[1],
        surname: row[2],
        infix: row[3],
        name: row[4],
        password: row[5]
      })

      path = "legacy/pictures/#{student.code}"
      file_name = false

      if File.exists?(path + '.jpg')
        file_name = path + '.jpg'
      elsif File.exists?(path + '.JPG')
        file_name = path + '.JPG'
      end

      if file_name
        file = File.open(file_name)
        student.picture = file
        file.close
      end

      student.save!

      puts "#{student.name}: #{student.id}"
    end
  end
end
