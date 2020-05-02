class HamburguesaIngredientesController < ApplicationController
  before_action :set_hamburguesa_ingrediente, only: [:show, :update, :destroy]

  # GET /hamburguesa_ingredientes
  def index
    @hamburguesa_ingredientes = HamburguesaIngrediente.all

    render json: @hamburguesa_ingredientes
  end

  # GET /hamburguesa_ingredientes/1
  def show
    render json: @hamburguesa_ingrediente
  end

  # POST /hamburguesa_ingredientes
  def create
    @hamburguesa_ingrediente = HamburguesaIngrediente.new(hamburguesa_ingrediente_params)

    if @hamburguesa_ingrediente.save
      render json: @hamburguesa_ingrediente, status: :created, location: @hamburguesa_ingrediente
    else
      render json: @hamburguesa_ingrediente.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hamburguesa_ingredientes/1
  def update
    if @hamburguesa_ingrediente.update(hamburguesa_ingrediente_params)
      render json: @hamburguesa_ingrediente
    else
      render json: @hamburguesa_ingrediente.errors, status: :unprocessable_entity
    end
  end

  def addingredient
    # Reviso si la hamburguesa existe
    if Hamburguesa.exists?(params[:hid])
      @hamburguesa = Hamburguesa.find(params[:hid])
    else
      render :status => 400, json: {message: "Id de hamburguesa invalido"}
      return
    end
    # Reviso si el ingrediente existe
    if Ingrediente.exists?(params[:iid])
      @ingrediente = Ingrediente.find(params[:iid])
    else
      render :status => 404, json: {message: "Ingrediente inexistente"}
      return
    end

    # Cargo todos los ingredientes de la hamburguesa
    @ingredientes_hamburguesa = HamburguesaIngrediente.where(hamburguesa_id: params[:hid])
    # Reviso si el ingrediente ya está
    @ingredientes_hamburguesa.each do |ingrediente|
      if ingrediente.ingrediente_id.to_i == params[:iid].to_i
        render :status => 400, json: {message: "Ingrediente ya está en la hamburguesa"}
        return
      end
    end
    # Creo la entrada en la tabla intermedia
    @hamburguesa_ingrediente = HamburguesaIngrediente.new
    @hamburguesa_ingrediente.hamburguesa_id = params[:hid]
    @hamburguesa_ingrediente.ingrediente_id = params[:iid]
    @hamburguesa_ingrediente.save

    # Agrego el ingrediente a la lista de ingredientes de la hamburguesa
    hash = {path: $global_url + "/ingrediente/" + params[:iid]}
    @hamburguesa.ingredientes.push(hash)
    @hamburguesa.update_attribute("ingredientes", @hamburguesa.ingredientes)
    render :status => 201, json: {message: "Ingrediente agregado"}
  end

  # DELETE /hamburguesa/1/ingrediente/1
  def deleteingredient
    # Reviso si la hamburguesa existe
    if Hamburguesa.exists?(params[:hid])
      @hamburguesa = Hamburguesa.find(params[:hid])
    else
      render :status => 400, json: {message: "Id de hamburguesa invalido"}
      return
    end

    # Reviso si el ingrediente existe
    if Ingrediente.exists?(params[:iid])
      @ingrediente = Ingrediente.find(params[:iid])
    else
      render :status => 404, json: {message: "Ingrediente inexistente"}
      return
    end

    # Reviso si el ingrediente está en la hamburguesa
    @ingredientes_hamburguesa = HamburguesaIngrediente.where(hamburguesa_id: params[:hid])
    if @ingredientes_hamburguesa.where(ingrediente_id: params[:iid]).length == 0
        render :status => 404, json: {message: "Ingrediente inexistente en la hamburguesa"}
        return
    end
    # Quito el ingrediente de la hamburguesa en la tabla intermedia
    @ingredientes_hamburguesa.where(ingrediente_id: params[:iid])[0].destroy 
    # Quito el ingrediente del modelo de la hamburguesa
    @hamburguesa.ingredientes.each do |ingrediente|
      if ingrediente["path"].split("/")[-1] == params[:iid]
        @hamburguesa.ingredientes.delete(ingrediente)
        @hamburguesa.update_attribute("ingredientes", @hamburguesa.ingredientes)
      end
    end
    render :status => 200, json: {message: "Ingrediente retirado"}
  end

  # DELETE /hamburguesa_ingredientes/1
  def destroy
    @hamburguesa_ingrediente.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hamburguesa_ingrediente
      @hamburguesa_ingrediente = HamburguesaIngrediente.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hamburguesa_ingrediente_params
      params.require(:hamburguesa_ingrediente).permit(:hid, :iid)
    end
end
