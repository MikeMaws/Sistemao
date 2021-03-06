class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy, :like, :dislike, :report]

  # GET /answers
  # GET /answers.json
  def index
   @answers = Answer.where(user_id: current_user.id)
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to request.referer, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @answer.update(like: @answer.like+1)
    Like.create({user_id: current_user.id, answer_id: @answer.id})
    redirect_to request.referer
  end

  def dislike
    @answer.update(dislike: @answer.dislike+1)
    Like.create({user_id: current_user.id, answer_id: @answer.id})
    redirect_to request.referer
  end

  def report
    @answer.update(report: @answer.report+1)
    redirect_to request.referer
  end
  
  def nivel
    correcao = Answer.find(params[:id])
    correcao.nivel = params[:nivel]
    correcao.save
    
    habs = Habilidade.where(subtask_id: correcao.subtask_id)
    avaliar = Avaliar.find(correcao.user_id)
    
    pontos = correcao.nivel
    
    if correcao.nivel == 1
       avaliar.novato += 1
      else if correcao.nivel == 2   
         avaliar.competente += 1
        else if correcao.nivel == 3
          avaliar.mestre += 1
        end
      end
    end  
    avaliar.save
    
    habs.each do |h|
      if h.nome == "Colaboracao"
         avaliar.colaboracao += pontos
        else if h.nome == "Construcao"   
           avaliar.construcao += pontos
          else if h.nome == "Pensamento Critico"   
             avaliar.pcritico += pontos
            else if h.nome == "Compromisso"   
               avaliar.compromisso += pontos
              else if h.nome == "Criatividade"   
                avaliar.criatividade += pontos
                else if h.nome == "Comunicacao"   
                  avaliar.criatividade += pontos
                end 
              end 
            end   
          end  
        end
      end 
      avaliar.save
    end
  
    redirect_to request.referer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:subtask_id, :link, :like, :dislike, :report, :user_id, :nivel)
    end
end
