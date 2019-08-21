enable :sessions

class App < Sinatra::Base

    get("/") do
        slim(:login)
    end

    post("/login") do
      fullname = params["full_name"]
      password = params["password"]
      login(params)
      redirect "/klasses.slim"
    end

    post("/create") do
        first_name = params["first_name"]
        last_name = params["last_name"]
        password = params["password"]
        create(params)
        redirect "/klasses.slim"
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

end

