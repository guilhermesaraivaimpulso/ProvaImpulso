class UsuariosController < ApplicationController
  def loginusu
    @usuario = Usuario.find_by(login: user_params[:login], senha: user_params[:senha])
    logger.debug "-------------- RESULT ----------------"
    if @usuario
      logger.debug "-------------- USUARIO EXISTE ----------------"
    else
      logger.debug "-------------- USUARIO NAO EXITE ----------------"
    end
  end

  def new
    @usuario = Usuario.new
  end

  def create
    if user_params_create[:senha]==user_params_create[:password_confirmation]
      @usuario = Usuario.new
      @usuario.login = user_params_create[:login]
      @usuario.senha = user_params_create[:senha]
      @usuario.save

      redirect_to home_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:usuario).permit(:login, :senha)
    end

    def user_params_create
      params.require(:usuario).permit(:login, :senha, :password_confirmation)
    end
end