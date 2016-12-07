class MaterialsController < ApplicationController
  before_action :set_material, only: [:show, :edit, :update, :destroy]
  
  def new
    @material = Material.new
  end
  def create
    @material = Material.new(material_params)



    logger.debug "--- M #{@material.errors.messages}"
    @material.valid?
    logger.debug "--- M #{@material.errors.messages}"

    @erros = "";
    @ArrErros = Array.new
    @material.errors.messages.each do |message|
      message.each_with_index do |erros,index|
        logger.debug "#{index} --> #{erros}"
        if index==1
          erros.each do |erro|
            logger.debug "------ #{erro}"
            @ArrErros.push(erro)
          end
        end
      end
    end

    if @material.invalid?
      logger.debug "----- ERROR material"
      redirect_to new_material_path(erro: @ArrErros)
    else
      @material.save
      redirect_to @material
    end
    
  end
  def show
    
  end
  def entrar

    @material = Material.find(material_params_estoque[:MatId])
    t = Time.now
    logger.debug "----------------- SEMANA ------ #{t.wday} ---------"
    if t.wday!=0 && t.wday!=6
      if t.hour>9 && t.hour<18
        @material.qnt = @material.qnt.to_i + material_params[:qnt].to_i
        if @material.save
          @log = Log.new(qnt: material_params[:qnt].to_i, user: current_user, material: @material, logtype: "Entrada")
          @log.save
          redirect_to @material      
        end
      else
        redirect_to material_path(@material, error: "003")
      end
    else
      redirect_to material_path(@material, error: "003")
    end
  end
  def retirar

    @material = Material.find(material_params_estoque[:MatId])
    t = Time.now
    logger.debug "----------------- SEMANA ------ #{t.wday} ---------"
    if t.wday!=0 && t.wday!=6
      if t.hour>9 && t.hour<18
        @material.qnt = @material.qnt.to_i - material_params[:qnt].to_i
        if @material.qnt<0
          redirect_to material_path(@material, error: "001")
        else
          if @material.save
            @log = Log.new(qnt: material_params[:qnt].to_i, user: current_user, material: @material, logtype: "Retirada")
            @log.save
            redirect_to @material      
          end
        end
      else
        redirect_to material_path(@material, error: "003")
      end
    else
      redirect_to material_path(@material, error: "003")
    end
  end
  def edit

  end
  def matlogs
    logger.debug 8888888888888888888
    logger.debug "params #{material_params_log[:MatId]}"
    @logs = Log.where(material: material_params_log[:MatId])
    @material = Material.find(material_params_log[:MatId])

  end
  def update
    @material.update(material_params)
    @material.save
    redirect_to @material
  end
  def destroy
    if @log = Log.find_by(material: @material.id)
      redirect_to material_path(@material, error: "002")
    else
      @material.destroy
      redirect_to '/home/index'
    end
  end
  private
    def set_material
      @material = Material.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:nome, :qnt)
    end
    def material_params_estoque
      params.require(:material).permit(:MatId, :qnt)
    end
    def material_params_log
      params.permit(:MatId)
    end

end