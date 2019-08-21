enable :sessions

class App < Sinatra::Base

include AppModule
    configure do
        set :unsecured_paths, [ '/login', '/create',]
     end

    before do
       unless settings.unsecured_paths.include?(request.path)
            if session[:student_id].nil?
              redirect('/')
            end
        end
    end

    get("/") do
    slim(:login)
    end

    get("/layout") do
    slim(:layout)
    end

    #Ny sida för elever
    get("/new") do
    slim(:new)
    end

    #profil för folk på sidan
    get("/profile") do
    slim(:profile)
    end

    get("/logout") do
    slim(:logout)
    end

    post("/login") do
        result = login(params)
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

end

