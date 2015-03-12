class PokemonController < ApplicationController
  def index
      @pokemon_list = Pokemon.all
  end

  def create
     new_pokemon = { }
     p = params[:pokemon]
     ## Fetch simple string params
     new_pokemon["name"] = p["name"]
     new_pokemon["description"] = p["description"]
     ## Generate abilities list string
     new_pokemon["abilities"] = p["abilities"].split("\r\n").join(", ")
     ## Generate types list string
     ti = ["bug", "dragon", "fairy", "fighting"]
     new_pokemon["types"] = ""
     isFirst = true
     for x in ti
         if (p["type_" + x] == "1")
             if (!isFirst)
                 new_pokemon["types"] += ", "
             end
             new_pokemon["types"] += x.capitalize()
             isFirst = false
         end
     end
     ## Generate weaknesses list string
     wi = ["bug", "dragon", "fairy", "fighting"]
     new_pokemon["weaknesses"] = ""
     isFirst = true
     for x in wi
         if (p["weak_" + x] == "1")
             if (!isFirst)
                 new_pokemon["weaknesses"] += ", "
             end
             new_pokemon["weaknesses"] += x.capitalize()
             isFirst = false
         end
     end

     @pokemon = Pokemon.new(new_pokemon)

     if @pokemon.save
         redirect_to @pokemon
     else
         render 'new'
     end
  end

  def new
  end

  def show
      @pokemon = Pokemon.find(params[:id])
  end
end
