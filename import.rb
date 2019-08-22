def import()
    Dir.glob("import/*.jpg") do |img|
        split_info = img.split(" ") #Splittar upp informationen från bilden
        db = database()
        db.execute(
        "INSERT INTO
        students
        (klass, first_name, last_name)
        Values (?,?,?)",
        split_info[0], split_info[1], split_info[2]
        ) #Skickar in informationen från bild till Server
        result = db.execute("
        SELECT student_id
        FROM 
        students
        WHERE 
        student_id = (SELECT MAX(student_id) 
        FROM students)
        ") # Hittar senaste student_id
        begin
            File.exist?("/import")
                FileUtils.mv("img/import, img/class")
        rescue 
            "The file couldn't be moved"
        end
        File.rename(img, "#{result}" + ".jpg") # Byter namn till senaste student_id
    end
end