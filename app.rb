enable :sessions

class App < Sinatra::Base

include AppModule
    helpers do
        def get_error_login()
            msg = session[:msg_login_failed].dup
            session[:msg_login_failed] = nil
            return msg
        end
        def get_error_create()
            msg = session[:msg_create_failed].dup
            session[:msg_create_failed] = nil
            return msg
        end
        def get_error_review()
            msg = session[:msg_review_failed].dup
            session[:msg_review_failed] = nil
            return msg
        end
        def get_validate_error_login()
            msg = session[:validate_login_error_msg].dup
            session[:validate_login_error_msg] = nil
            return msg
        end
        def get_no_info_error_login()
            msg = session[:no_info_error_msg].dup
            session[:no_info_error_msg] = nil
            return msg
        end 
    end
    # configure do
    #     set :unsecured_paths, ['/', '/login', '/new', '/create']
    # end

    # before do
    #     unless settings.unsecured_paths.include?(request.path)
    #         if session[:user_id].nil?
    #             redirect('/')
    #         end
    #     end
    # end

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

end

