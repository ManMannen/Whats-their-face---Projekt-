def import()
    Dir.glob("import/*.jpg") do |img|
        split_info = img.split(" ")
        db = database()
        db.execute(INSERT INTO students Values ?,?)




        
        
        
        #extract klass, name from image filename
        #SQL insert into students klass, name
        #SQL select latest inserted students id
        #rename (move) image to students id
    end
end