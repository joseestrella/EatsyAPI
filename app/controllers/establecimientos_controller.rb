class EstablecimientosController < ApplicationController
  # GET /establecimientos
  # GET /establecimientos.json
  def index
    json=Validation.validateLista params
    auxEst=[]
    auxComent=[]
    if(json == false)
      render json: {:eatsy_status => "error"}
    else                                           #return [izq, der, abajo, arriba]
      paredes=Operaciones.paredes(json['latitud'],json['longitud'],json['radio'])
      establecimientos = Establecimiento.where("longitud >= ? AND longitud <= ? AND latitud >= ? AND latitud <= ?",paredes[0],paredes[1],paredes[2],paredes[3])
      #puts establecimientos
      establecimientos.each{|estab|
        auxComent=[]
        dist=Operaciones.distancia(estab.latitud,estab.longitud,json['latitud'],json['longitud'])
        if(dist<=json['radio'])
          if(json['categoria']!=nil)
            if(json['keyword'] != nil)
              if(estab.nombre.include?json['keyword'] && estab.categoria.equal?(json['categoria']))
                coment=Comentario.where("idEstablecimiento=?",estab.id)
                aux={"comentarios"=>
                  coment.map{ |c| aux2= {"coment"=>c['coment']}  }
                }
                auxComent<<estab
                auxComent<<aux
                auxEst<<auxComent
              end
            else
              if(estab.categoria == json['categoria'])
                coment=Comentario.where("idEstablecimiento=?",estab.id)
                aux={"comentarios"=>
                  coment.map{ |c| aux2= {"coment"=>c['coment']}  }
                }
                auxComent<<estab
                auxComent<<aux
                auxEst<<auxComent
              end
            end
          else
            if(json['keyword'] != nil)
              if(estab.nombre.include?json['keyword'])
                coment=Comentario.where("idEstablecimiento=?",estab.id)
                aux={"comentarios"=>
                  coment.map{ |c| aux2= {"coment"=>c['coment']}  }
                }
                auxComent<<estab
                auxComent<<aux
                auxEst<<auxComent
              end
            else
              coment=Comentario.where("idEstablecimiento=?",estab.id)
              aux={"comentarios"=>
                coment.map{ |c| aux2= {"coment"=>c['coment']}  }
              }
              auxComent<<estab
              auxComent<<aux
              auxEst<<auxComent
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

  def lista
    @establecimientos = Establecimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @establecimientos }
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
  def create
    json=Validation.validateCreate params
    if(json == false)
      render json: {:eatsy_status => "Error"}
    else
      #puts json
      data=JSON.parse(json)
      establecimiento = Establecimiento.new(data)
      if establecimiento.save
        render json:{ :eatsy_status => "Ok"}
      else
        render json:{ :eatsy_status => "Error"}
      end
    end
  end

  # PUT /establecimientos/1
  # PUT /establecimientos/1.json
  def update
    #parametros = params
    respuesta=Validation.validateUpdate params
    parametros = JSON.parse(params[:actualizar])
    #parametros = params[:actualizar]
    if(respuesta==false)
      render json: {:eatsy_status => "error"}
    else
      if(!parametros['calificacion'].blank?)
        #establecimiento = Establecimiento.where("id=?",parametros['idEstablecimiento'])
        #band=false
        begin
          establecimiento=Establecimiento.find(parametros['idEstablecimiento'])
        rescue ActiveRecord::RecordNotFound => e
          establecimiento = nil
        end
        if(establecimiento!=nil)
          promedio=(establecimiento.calificacion+parametros['calificacion'])/2
          if establecimiento.update_attributes(:calificacion => promedio)
            if(!parametros['comentario'].blank?)
              comentario = Comentario.new(:idEstablecimiento => parametros['idEstablecimiento'],:coment => parametros['comentario'])
              if !comentario.save
                render json: {:eatsy_status => "error"}
              end
            end
            render json: {:eatsy_status => "Actualizado"}
          else
            render json: {:eatsy_status => "error"}
          end
        else
          render json: {:eatsy_status => "No hay"}
        end
      else
        comentario = Comentario.new(:idEstablecimiento => parametros['id'],:coment => parametros['comentario'])
        if comentario.save
          render json: {:eatsy_status => "Actualizado"}
        else
          render json: {:eatsy_status => "error"}
        end
      end
    end

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
