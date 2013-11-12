class EstablecimientosController < ApplicationController
  # GET /establecimientos
  # GET /establecimientos.json
  def index
    @establecimientos = Establecimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @establecimientos }
    end
  end

  def lista
    json=Validation.validateLista params
    auxEst=[]
    if(json == false)
      render json: {:eatsy_status => "error"}
    else
      establecimientos = Establecimiento.all
      establecimientos.each{|estab|
        dist=Operaciones.distancia(estab.latitud,estab.longitud,json['latitud'],json['longitud'])
        if(dist<=json['radio'])
          if(json['categoria']!=nil)
            if(json['keyword'] != nil)
              if(estab.nombre.include?json['keyword'] && estab.categoria.equal?(json['categoria']))
                auxEst<<estab
              end
            else
              if(estab.categoria == json['categoria'])
                auxEst<<estab
              end
            end
          else
            if(json['keyword'] != nil)
              if(estab.nombre.include?json['keyword'])
                auxEst<<estab
              end
            else
              auxEst<<estab
            end
          end
        end
      }
      perro=auxEst.to_json
      render json:{
          :Establecimientos => perro
      }, :status => 200
    end
  end


  # GET /establecimientos/1
  # GET /establecimientos/1.json
  def show
    @establecimiento = Establecimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @establecimiento }
    end
  end

  # GET /establecimientos/new
  # GET /establecimientos/new.json
  def new
    @establecimiento = Establecimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @establecimiento }
    end
  end

  # GET /establecimientos/1/edit
  def edit
    @establecimiento = Establecimiento.find(params[:id])
  end

  # POST /establecimientos
  # POST /establecimientos.json
  def crear
    json=Validation.validateCreate params
    if(json == false)
      render json: {:eatsy_status => "error"}
    else
      #puts json
      data=JSON.parse(json)
      establecimiento = Establecimiento.new(data)
      if establecimiento.save
        render json:{ :eatsy_status => "Guardado satisfactorio"}
      else
        format.json { render json: establecimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /establecimientos/1
  # PUT /establecimientos/1.json
  def actualizar
    #parametros = params
    respuesta=Validation.validateUpdate params
    parametros = JSON.parse(params[:actualizar])
    #parametros = params[:actualizar]
    if(respuesta==false)
      render json: {:eatsy_status => "error"}
    else
      if(!parametros['calificacion'].blank?)
        establecimiento = Establecimiento.find(parametros['id'])
        #puts establecimiento
        #parametros = parametros.to_json
        promedio=(establecimiento.calificacion+parametros['calificacion'])/2
        if establecimiento.update_attributes(:calificacion => promedio)
          #    format.html { redirect_to @establecimiento, notice: 'Establecimiento was successfully updated.' }
          render json: {:eatsy_status => "Actualizado"}
          #    format.json { head :no_content }
        else
          #    format.html { render action: "edit" }
          render json: {:eatsy_status => "error"}
          #    format.json { render json: @establecimiento.errors, status: :unprocessable_entity }
        end
      end
      #render json: {:eatsy_status => "error"}
      #puts parametros
      #render json: {:eatsy_status => "entra"}
    end

    #@establecimiento = Establecimiento.find(params[:id])

    #respond_to do |format|
    #  if @establecimiento.update_attributes(params[:establecimiento])
    #    format.html { redirect_to @establecimiento, notice: 'Establecimiento was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @establecimiento.errors, status: :unprocessable_entity }
    #  end
    #end
    #casa= params
    #print casa
  end

  # DELETE /establecimientos/1
  # DELETE /establecimientos/1.json
  def destroy
    @establecimiento = Establecimiento.find(params[:id])
    @establecimiento.destroy

    respond_to do |format|
      format.html { redirect_to establecimientos_url }
      format.json { head :no_content }
    end
  end
end
