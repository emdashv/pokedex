class PokemonController < ApplicationController
  @@types = ["bug", "dragon", "ice", "fighting", "fire", "flying", "grass", "ghost", "ground", "electric", "poison", "psychic", "rock", "water"]

  def index
      @pokemon_list = Pokemon.all
  end

  def edit
      @types = @@types
      @pokemon = Pokemon.find(params[:id])
      @types_on = { }
      for type in @pokemon.types.split(", ")
          @types_on[type.downcase()] = 1
      end
      @weaknesses_on = { }
      for weak in @pokemon.weaknesses.split(", ")
          @weaknesses_on[weak.downcase()] = 1
      end
  end

  def new
      @types = @@types
      if !(@pokemon)
          @pokemon = Pokemon.new
      end
  end

  def show
      @pokemon = Pokemon.find(params[:id])
  end

  def create
     new_pokemon = generate_pokemon(params[:pokemon])

     @pokemon = Pokemon.new(new_pokemon)
     if @pokemon.save
         redirect_to @pokemon
     else
         render 'new'
     end
  end

  def update
      @pokemon = Pokemon.find(params[:id])
      pokemon_params = generate_pokemon(params[:pokemon])

      if @pokemon.update(pokemon_params)
          redirect_to @pokemon
      else
          render 'edit'
      end
  end

  def destroy
      @pokemon = Pokemon.find(params[:id])
      if @pokemon.destroy
          redirect_to 'pokemon#index'
      end
  end

  private
  def generate_pokemon(p)
      new_pokemon = { }
      ## Fetch simple string params
      new_pokemon["name"] = p["name"]
      new_pokemon["description"] = p["description"]
      ## Generate abilities list string
      new_pokemon["abilities"] = p["abilities"].split("\r\n").join(", ")
      ## Generate types list string
      new_pokemon["types"] = ""
      isFirst = true
      @types = @@types
      for x in @types
          if (p["type_" + x] == "on")
              if (!isFirst)
                  new_pokemon["types"] += ", "
              end
              new_pokemon["types"] += x.capitalize()
              isFirst = false
          end
      end

      if (new_pokemon["types"] == "")
          new_pokemon["types"] = "Normal"
      end

      ## Generate weaknesses list string
      new_pokemon["weaknesses"] = ""
      isFirst = true
      for x in @types
          if (p["weak_" + x] == "on")
              if (!isFirst)
                  new_pokemon["weaknesses"] += ", "
              end
              new_pokemon["weaknesses"] += x.capitalize()
              isFirst = false
          end
      end
      ## Add image
      new_pokemon["image"] = p["image"]

      return new_pokemon
  end
end
