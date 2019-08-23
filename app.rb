class App < Sinatra::Base
    enable :sessions

    get("/") do
        import()
        slim(:login)
    end

    get("/create") do
        slim(:create)
    end

    get("/klasses") do
        slim(:klasses)
    end

    get("/klasses/1A.slim") do
        #funktion som hämtar baserat på klass
        students = print_class("1A")
        slim(:a1, locals:{students: students})
    end

    get("/klasses/2A.slim") do
        students = print_class("2A")
        slim(:a2, locals:{students: students})
       
    end

    get("/klasses/3A.slim") do
        students = print_class("3A")
        slim(:a3, locals:{students: students})
       
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
        create(params)
        redirect "/klasses"
    end

    post("/show_students") do
    redirect "/show_students"
    end
end

