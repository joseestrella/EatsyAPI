class ClientesController < ApplicationController
  # GET /clientes
  # GET /clientes.json



  def ver
    json=Validation.validateVerUsuario params
    if(json == false)
      render json: {:eatsy_status => "error"}
    else
      cliente=Cliente.where(:nombre_usuario => json['nombre_usuario'])
      render json:{
          :Cliente => cliente.to_json
      }, :status => 200
    end
  end
  def actualizar
    json=Validation.validateActualizarUsuario params
    if(json == false)
      render json: {:eatsy_status => "error"}
    else

    end
  end

  def index
    @clientes = Cliente.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clientes }
    end
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cliente }
    end
  end

  # GET /clientes/new
  # GET /clientes/new.json
  def new
    @cliente = Cliente.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cliente }
    end
  end

  # GET /clientes/1/edit
  def edit
    @cliente = Cliente.find(params[:id])
  end

  # POST /clientes
  # POST /clientes.json
  def create
    json=Validation.validateCreateCliente params

    if(json == false)
      render json: {:eatsy_status => "error"}
    else
      #puts json
      data=JSON.parse(json)
      cliente = Cliente.new(data)
      if cliente.save
        render json:{ :eatsy_status => "Ok"}
      else
        render json:{ :eatsy_status => "Error"}
      end
    end
  end

  # PUT /clientes/1
  # PUT /clientes/1.json
  def update
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      if @cliente.update_attributes(params[:cliente])
        format.html { redirect_to @cliente, notice: 'Cliente was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url }
      format.json { head :no_content }
    end
  end
end
