module AppModule

    def database()
        db = SQLite3::Database.new("db/db.db")
        db.results_as_hash = true
        db
    end
    
    def login(params)
    db = database()
    result = db.execute("SELECT first_name, last_name, password, student_id, authority FROM users WHERE first_name = ?", params["first_name"])
        if result.length > 0
            if BCrypt::Password.new(result[0]["password"]) == params["password"] && result[0]["first_name"] == params["first_name"]
                {
                student_id: result[0]["student_id"],
                first_name: params["first_name"]
                }
            else
                flash[:wrong_password] = "Incorrect Password"
            end
        end
        flash[:no_student] = "No student found"
    end

    def create(params)
    db = database()
    first_name = params["first_name"] 
    last_name = params["last_name"]
    password = params["password"]
    klass = params["klass"]
    password_hash = BCrypt::Password.create(password)
    db.execute("INSERT INTO users 
    (first_name, last_name, password, class, authority) 
    VALUES (?,?,?,?,?)"
    first_name, last_name, password_hash, klass, 1)
    result = db.execute("SELECT * FROM users")
    if result > 0
    return {
        student_id: result[0]["student_id"],
        first_name: params["first_name"]
        last_name: params["last_name"]
        klass: params["klass"]
        authority: result[0]["authority"]
    }
    else
        flash[:notice_create] = "There was an error creating the account"
    end 

    def insert_img_to_db(studen) 
        db = database()
        session[:images_3A].each do |query|
        request = <<-SQL 
        INSERT INTO images
        img, student_id
        VALUES ?,?
        query, student_id
        db.execute(query)
        SQL
    end 

    def sort_by_class()
    db = database()
    query = <<-SQL
    SELECT id FROM
    students
    WHERE class = ?
    params[]
    SQL


    


    def change_username(params, student_id) 
        db = database()
        db.execute("UPDATE users SET username = ? WHERE student_id = ?", params['change_username'], student_id)
    end
    
    def change_password(params, student_id) 
        db = database()
        db.execute("UPDATE users SET password = ? WHERE student_id = ?", params['change_password'], student_id)
    end


end 

