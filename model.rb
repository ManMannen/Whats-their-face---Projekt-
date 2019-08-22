# module AppModule

    def database()
        db = SQLite3::Database.new("db/db.db")
        db.results_as_hash = true
        db
    end
    
    def login(params)
        first_name = params["full_name"].split[0]
        last_name = params["full_name"].split[1]
        db = database()
        result = db.execute("SELECT * FROM teachers WHERE first_name = ?", params["first_name"])
        if result.length > 0
            if BCrypt::Password.new(result[0]["password"]) == params["password"] && result[0]["first_name"] == params["first_name"]
                {
                teacher_id: result[0]["teacher_id"],
                first_name: params["first_name"]
                }
            else
                flash[:wrong_password] = "Incorrect Password"
            end
        end
    end

    def create(params)
        db = database()
        first_name = params["first_name"] 
        last_name = params["last_name"]
        password = params["password"]
        password_hash = BCrypt::Password.create(password)
        result = db.execute("SELECT * FROM teachers")
        if result > 0
            flash[:notice_create] = "There was an error creating the account"
        else
            db.execute("INSERT INTO teachers (first_name, last_name, password) VALUES (?,?,?)", first_name, last_name, password_hash)
        end
    end

    def change_username(params, teacher_id) 
        db = database()
        db.execute("UPDATE teachers SET first_name = ? WHERE teacher_id = ?", params['change_username'], teacher_id)
    end
    
    def change_password(params, teacher_id) 
        db = database()
        db.execute("UPDATE teacher SET password = ? WHERE teacher_id = ?", params['change_password'], teacher_id)
    end