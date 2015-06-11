class BowlsController < ApplicationController
  before_action :set_bowl, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /bowls
  # GET /bowls.json
  def index
    @p1_bowls = Bowl.where(player_id: 1)
    @p2_bowls = Bowl.where(player_id: 2)
    @bowls = Bowl.all
    @bowl = Bowl.new
    @total_score_p1 = @bowls.total_score(1)
    @total_score_p2 = @bowls.total_score(2)
    @total_turns_p1 = @bowls.where(player_id: 1).map(&:turn).reduce(:+)
    @total_turns_p2 = @bowls.where(player_id: 2).map(&:turn).reduce(:+)
    @frame_p1 = @bowl.frame_number(1)
    @frame_p2 = @bowl.frame_number(2)
  end

  def reset
    Bowl.destroy_all
    redirect_to root_path
  end

  # GET /bowls/1
  # GET /bowls/1.json
  def show
  end

  # GET /bowls/new
  def new
    @bowl = Bowl.new
  end

  # GET /bowls/1/edit
  def edit
  end

  # POST /bowls
  # POST /bowls.json
  def create
    @bowl = Bowl.new(bowl_params)
    # params[:player_id]
    # player = Player.find(params[:player_id])
    @bowl.player = Player.find(params[:player_id])
    @bowl.roll(params[:player_id])


    respond_to do |format|
      if @bowl.save
        format.html { redirect_to root_path, notice: 'Bowl was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bowl }
      else
        format.html { render action: 'new' }
        format.json { render json: @bowl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bowls/1
  # PATCH/PUT /bowls/1.json
  def update
    respond_to do |format|
      if @bowl.update(bowl_params)
        format.html { redirect_to @bowl, notice: 'Bowl was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bowl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowls/1
  # DELETE /bowls/1.json
  def destroy
    @bowl.destroy
    respond_to do |format|
      format.html { redirect_to bowls_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowl
      @bowl = Bowl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowl_params
      
      params.fetch(:bowl, {}).permit(:score, :total_score, :turn)
    end
end
