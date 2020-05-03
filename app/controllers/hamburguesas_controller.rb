class HamburguesasController < ApplicationController
  before_action :set_hamburguesa, only: [:show, :update, :destroy]

  # GET /hamburguesas
  def index
    @hamburguesas = Hamburguesa.all

    render json: @hamburguesas
  end

  # GET /hamburguesa/1
  def show
    if @hamburguesa == nil
      render :status => 404, json: {message: "Hamburguesa inexistente"}
      return
    end
    render :status => 200, json: @hamburguesa
  end

  # POST /hamburguesa
  def create # chequear input invalido
    if params[:nombre] == nil || params[:descripcion] == nil || params[:precio] == nil || params[:imagen] == nil
      render :status => 400, json: {message: "Input invalido"}
      return
    end
    @hamburguesa = Hamburguesa.new(hamburguesa_params)
    if @hamburguesa.save
      render json: @hamburguesa, status: :created, location: @hamburguesa
    else
      render json: @hamburguesa.errors, status: :unprocessable_entity
    end
  end

  # PATCH /hamburguesa/1
  def update
    if params[:nombre] == nil && params[:descripcion] == nil && params[:precio] == nil && params[:imagen] == nil
      render :status => 400, json: {message: "Parametros invalidos"}
      return
    end
    if @hamburguesa.update(hamburguesa_params)
      render json: @hamburguesa
    else
      render json: @hamburguesa.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hamburguesa/1
  def destroy
    if @hamburguesa == nil
      render :status => 404, json: {message: "Hamburguesa inexistente"}
      return
    end
    @hamburguesa.destroy
    render :status => 200, json: {message: "Hamburguesa eliminada"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hamburguesa
      if params[:id].to_i == 0
        render :status => 400, json: {message: "Id invalido"}
        return
      end
      @hamburguesa = Hamburguesa.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hamburguesa_params
      params.require(:hamburguesa).permit(:nombre, :precio, :descripcion, :imagen)
    end
end
