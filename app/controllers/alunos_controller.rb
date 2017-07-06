class AlunosController < ApplicationController
  before_action :authenticate_user!
  def linha_do_tempo
    @tasks    = Task.where("DATE(?) BETWEEN abertura AND fechamento", Time.now)
    @answers  = Answer.where(subtask_id: Subtask.where(task_id: Task.where("DATE(?) <= date(fechamento, '+7 day')", Time.now)))
  end
  def missao
  end
  def privilegio
  end
  def grafico_progresso
  end
  def grafico_habilidade
  end
  def profile
  end
  def resolver_task

      @current_task = Task.where(id: params[:task_id])  #alterar para o id da task selecionada
      @resps = Answer.where(user_id: current_user.id)
      @resp = Answer.new
  end
end
