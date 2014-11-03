class PokemonsController < ApplicationController
	def capture
	    @pokemon = Pokemon.find params[:id]
	    @trainer = current_trainer
      @pokemon.trainer_id = @trainer.id
      @pokemon.save
	    redirect_to root_path
	end

  def damage
    @pokemon = Pokemon.find params[:id]
    @pokemon.health -= 10
    if @pokemon.health >= 0
      @pokemon.save
    else @pokemon.destroy
    end
    redirect_to current_trainer
  end

  def destroy
    @pokemon = Pokemon.find params[:id]
    @pokemon.destroy
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.level = 1
    @pokemon.health = 100
    @trainer = current_trainer
    @pokemon.trainer_id = @trainer.id
    if (@pokemon.save)
      redirect_to @trainer
    else
      redirect_to new_pokemon_path
      flash[:error] = @pokemon.errors.full_messages.to_sentence
    end
  end

  def edit
    @pokemon = Pokemon.find params[:id]
  end

  def update
    @pokemon = Pokemon.find params[:id]
    @pokemon.update(pokemon_params)
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name)
  end
end
