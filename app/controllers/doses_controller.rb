class DosesController < ApplicationController
  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    # @ingredient = Ingredient.find(params[:dose][:ingredient_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to @cocktail
    else
      render "cocktail/show"
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktails = @dose.cocktail
    @dose.destroy
    redirect_to @cocktails
  end

  private
  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
