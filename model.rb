module AppModule

    def database()
        db = SQLite3::Database.new("db/db.db")
        db.results_as_hash = true
        db
    end
    
    def login(params)
    db = database()
    result = db.execute("SELECT username, password, user_id, authority, nickname FROM users WHERE username = ?", params["username"])
        if result.length > 0
            if BCrypt::Password.new(result[0]["password"]) == params["password"] && result[0]["username"] == params["username"]
                return{
                    user_id: result[0]["user_id"],
                    user: params["username"]
                }
            else
                notice_login: "There was an error when logging in"
            end
        end
    end

    def create(params)
    db = database()
    new_name = params["username"] 
    new_password = params["password"]
    new_password_hash = BCrypt::Password.create(new_password)
    db.execute("INSERT INTO users (username, password, authority, nickname) VALUES (?,?,?,?)", new_name, new_password_hash, 1)
    result = db.execute("SELECT * FROM users")
        return {
            user_id: result[0]["user_id"],
            user: params["username"]
        }
    else
        notice_create: "There was an error creating the account"
        }
    end 

    def import_img_1A()
        Dir.glob('/public/img/1A/*.jpg') do |img|
            next if img = ".." || img = "."
            images_1A = []
            session[:images_1A] = images_1A.append(img)
        end
    end

    def import_img_2A()
        Dir.glob('/public/img/2A/*.jpg') do |img|
            session[:images_2A] = images_2A.append(img)
        end
    end

    def import_img_3A()
        Dir.glob('/public/img/3A/*.jpg') do |img|
            session[:images_3A] = images_3A.append(img)
        end
    end

    def insert_img_to_db(student_id) 
        session[:images_1A].each do |query|
        query = <<-SQL 
        INSERT INTO images
        img, student_id
        VALUES ?,?
        query, student_id
        db.execute(query, session[:student_id])
        SQL
    end 

    def insert_img_to_db(student_id) 
        session[:images_2A].each do |query|
        query = <<-SQL 
        INSERT INTO images
        img, student_id
        VALUES ?,?
        query, student_id
        db.execute(query, session[:student_id])
        SQL
    end 

    def insert_img_to_db(student_id) 
        session[:images_3A].each do |query|
        query = <<-SQL 
        INSERT INTO images
        img, student_id
        VALUES ?,?
        query, student_id
        db.execute(query, session[:student_id])
        SQL
    end 




    
        





    


        
            
            




                

    def change_username(params, user_id) 
        db = database()
        db.execute("UPDATE users SET username = ? WHERE user_id = ?", params['change_username'], user_id)
    end
    
    def change_password(params, user_id) 
        db = database()
        db.execute("UPDATE users SET password = ? WHERE user_id = ?", params['change_password'], user_id)
    end

    

end 

