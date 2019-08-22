class App < Sinatra::Base
    enable :sessions

    get("/") do
        slim(:login)
    end

    post("/login") do
      login(params)
      redirect "/klasses"
    end

    post("/register") do
        create(params)
        redirect "/klasses"
    end

    get("/klasses/1A") do
        slim(:a1)
    end

    get("/klasses/2A") do
        slim(:a2)
    end

    get("/klasses/3A") do
        slim(:a3)
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

