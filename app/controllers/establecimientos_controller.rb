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
    #parametros = params
    json=Validation.validateLista params
    auxEst=[]
    if(json == false)
      render json: {:eatsy_status => "error"}
    else
      #json=JSON.parse(parametros[:lista])

      establecimientos = Establecimiento.all
      establecimientos.each{|estab|
        dist=Operaciones.distancia(estab.latitud,estab.longitud,json['latitud'],json['longitud'])
        #puts "Ahi va la distanciiiiia"
        #puts dist
        if(dist<=json['radio'])
          if(json['categoria'] != "ALL")
            if(json['keyword'] != nil)
              if(estab.nombre.include?json['keyword'] && estab.categoria == json['categoria'])
                auxEst<<estab
              end
            else
              if(estab.categoria == json['categoria'])
                auxEst<<estab
              end
            end
          else
            if(json['keyword'] != nil)
              #puts "EEEEEEENTRRRRAAAAAA: "+json['keyword']
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
      #render json: establecimientos
    end

    #respond_to do |format|
    #format.html # index.html.erb
    #  format.json { render json: @establecimientos }
    #end
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
      render json: json
    end
    #@establecimiento = Establecimiento.new(params[:establecimiento])

    #respond_to do |format|
      #if @establecimiento.save
        #format.html { redirect_to @establecimiento, notice: 'Establecimiento was successfully created.' }
        #format.json { render json: @establecimiento, status: :created, location: @establecimiento }
      #else
        #format.html { render action: "new" }
        #format.json { render json: @establecimiento.errors, status: :unprocessable_entity }
      #end
    puts json
    #end
  end

  # PUT /establecimientos/1
  # PUT /establecimientos/1.json
  def update
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
    casa= params
    print casa
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
