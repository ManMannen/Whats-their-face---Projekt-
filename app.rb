enable :sessions

class App < Sinatra::Base

    get("/") do
        slim(:login)
    end

    get("/register") do
        slim(:loggedin)
    end

    post("/login") do
        result = login(params)
        if result[:validate_login_error]
            session[:validate_login_error_msg] = result[:validate_login_error_msg]
            redirect back
        elsif result[:error_login]
            session[:msg_login_failed] = result[:message_login]
            redirect back
        elsif
            result[:no_info_error]
            session[:no_info_error_msg] = result[:no_info_error_msg]
            redirect back
        else
            session[:user_id] = result[:user_id]
            session[:user] = result[:user]
            redirect('/')
        end
    end

    post("/search") do
        search = params['search']
        
    end

    get("/klass/:klass") do
        slim(:klass)
    end

    #Ny sida för en ny elev
    get("/new") do
        slim(:new)
    end

    #profil för folk på sidan
    get("/profile") do
        slim(:profile)
    end
end

