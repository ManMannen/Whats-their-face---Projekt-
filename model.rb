module AppModule
    def database()
        db = SQLite3::Database.new("db/db.db")
        db.results_as_hash = true
        db
    end
    
    def login(params)
        if validate_info_login(params)
            db = database()
            result = db.execute("SELECT username, password, user_id, authority, nickname FROM users WHERE username = ?", params["username"])
            if result.length > 0
                if BCrypt::Password.new(result[0]["password"]) == params["password"] && result[0]["username"] == params["username"]
                    return{
                        error_login: false,
                        user_id: result[0]["user_id"],
                        user: params["username"]
                    }
                else
                    return {
                        error_login: true,
                        message_login: "Password did not match username"
                    }
                end
            else
                return {
                    no_info_error: true,
                    no_info_error_msg: "No such user"
                }
            end
        else
            return{
                validate_login_error: true,
                validate_login_error_msg: "Password has to be longer than 2 charachters and smaller than 10 charachters, same goes for username"
            }
        end
    end

    def create(params)
        if validate_info_create(params)
            db = database()
            new_name = params["username"] 
            new_password = params["password1"]
            new_nickname = params["nickname"]
            new_password_hash = BCrypt::Password.create(new_password)
            db.execute("INSERT INTO users (username, password, authority, nickname) VALUES (?,?,?,?)", new_name, new_password_hash, 1, new_nickname)
            result = db.execute("SELECT * FROM users")
            return {
                error_create: false,
                user_id: result[0]["user_id"],
                nickname: params["nickname"],
                user: params["username"]
            }
        else
            return {
                error_create: true,
                message_create: "Invalid credentials for creating an account"
            }
        end  
    end
    def change_username(params, user_id) 
        if validate_info_change_username(params)
            db = database()
            db.execute("UPDATE users SET username = ? WHERE user_id = ?", params['change_username'], user_id)
        end
    end

    def change_password(params, user_id) 
        if validate_info_change_password(params)
            db = database()
            db.execute("UPDATE users SET password = ? WHERE user_id = ?", params['change_password'], user_id)
        end
    end
end