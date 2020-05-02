class IngredientesController < ApplicationController
  before_action :set_ingrediente, only: [:show, :update, :destroy]

  # GET /ingredientes
  def index
    @ingredientes = Ingrediente.all

    render json: @ingredientes
  end

  # GET /ingredientes/1
  def show
    render json: @ingrediente
  end

  # POST /ingredientes
  def create
    if params[:nombre] == nil || params[:descripcion] == nil
      render :status => 400, json: {message: "Input invalido"}
      return
    end
    @ingrediente = Ingrediente.new(ingrediente_params)
    if @ingrediente.save
      render json: @ingrediente, status: :created, location: @ingrediente
    end
  end

  # PATCH/PUT /ingredientes/1
  def update
    if @ingrediente.update(ingrediente_params)
      render json: @ingrediente
    else
      render json: @ingrediente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ingredientes/1
  def destroy
    if HamburguesaIngrediente.where(ingrediente_id: params[:id]).length != 0
      render :status => 409, json: {message: "Ingrediente no se puede borrar, se encuentra presente en una hamburguesa"}
      return
    end
    @ingrediente.destroy
    render :status => 200, json: {message: "Ingrediente eliminado"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingrediente
      if params[:id].to_i == 0
        render :status => 400, json: {message: "Id invalido"}
        return
      end
      if Ingrediente.exists?(params[:id])
        @ingrediente = Ingrediente.find(params[:id])
      else
        render :status => 404, json: {message: "Ingrediente inexistente"}
      end
    end

    # Only allow a trusted parameter "white list" through.
    def ingrediente_params
      params.require(:ingrediente).permit(:id, :nombre, :descripcion)
    end
end
