class CommutesController < ApplicationController
  # GET /commutes
  # GET /commutes.json
  def index
    @commutes = Commute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commutes }
    end
  end

  # GET /commutes/1
  # GET /commutes/1.json
  def show
    @commute = Commute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commute }
    end
  end

  # GET /commutes/new
  # GET /commutes/new.json
  def new
    @commute = Commute.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commute }
    end
  end

  # GET /commutes/1/edit
  def edit
    @commute = Commute.find(params[:id])
  end

  # POST /commutes
  # POST /commutes.json
  def create
    @commute = Commute.new(params[:commute])

    respond_to do |format|
      if @commute.save
        format.html { redirect_to @commute, notice: 'Commute was successfully created.' }
        format.json { render json: @commute, status: :created, location: @commute }
      else
        format.html { render action: "new" }
        format.json { render json: @commute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /commutes/1
  # PUT /commutes/1.json
  def update
    @commute = Commute.find(params[:id])

    respond_to do |format|
      if @commute.update_attributes(params[:commute])
        format.html { redirect_to @commute, notice: 'Commute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commutes/1
  # DELETE /commutes/1.json
  def destroy
    @commute = Commute.find(params[:id])
    @commute.destroy

    respond_to do |format|
      format.html { redirect_to commutes_url }
      format.json { head :no_content }
    end
  end

  def test
    mileage = 12
    commute_type = "bike"

    @baseline = CommuteAttribute.where("commute_type = ?", "car").first
    @result = CommuteAttribute.where("commute_type = ?", commute_type).first

    # person + passengers
    # 2 * 10 miles

    # calculate cash score
    #   car cash value - other cash value
    if @result.cash_fr == true
      @cash_score = @baseline.cash - @result.cash
    else
      @cash_score = (@baseline.cash * mileage) - (@result.cash * mileage)
    end

    # calculate calories score
    if @result.calories_fr == true
      @cal_score = @result.calories
    else
      @cal_score = @result.calories * mileage
    end

    # calculate envfp score
    if @result.envfp_fr == true
      @envfp_score = @result.envfp
    else
      @envfp_score = @result.envfp * mileage
    end

  end

end
