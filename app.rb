class App < Sinatra::Base
    enable :sessions

    get("/") do
        slim(:login)
    end

    get("/create") do
        slim(:create)
    end

    #Ny sida för elever
    get("/new") do
        slim(:new)
    end

    #profil för folk på sidan
    get("/profile") do
        slim(:profile)
    end

    get("/show_students") do
        student_info = print_students()
        slim(:show_students, locals:{student_info: student_info})
    end

    post("/login") do
        fullname = params["full_name"]
        password = params["password"]
        login(params)
        redirect "/klasses"
    end
  
    post("/register") do
        first_name = params["first_name"]
        last_name = params["last_name"]
        password = params["password"]
        create(params)
        redirect "/klasses"
    end

    post("/show_students") do
    redirect "/show_students"
    end
end

