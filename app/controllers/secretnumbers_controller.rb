class SecretnumbersController < ApplicationController
  # GET /secretnumbers
  # GET /secretnumbers.json
  def index
    @secretnumbers = Secretnumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @secretnumbers }
    end
  end

  # GET /secretnumbers/1
  # GET /secretnumbers/1.json
  def show
    @secretnumber = Secretnumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @secretnumber }
    end
  end

  # GET /secretnumbers/new
  # GET /secretnumbers/new.json
  def new
    @secretnumber = Secretnumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @secretnumber }
    end
  end

  # GET /secretnumbers/1/edit
  def edit
    @secretnumber = Secretnumber.find(params[:id])
  end

  # POST /secretnumbers
  # POST /secretnumbers.json
  def create
    @secretnumber = Secretnumber.new(params[:secretnumber])

    respond_to do |format|
      if @secretnumber.save
        format.html { redirect_to @secretnumber, notice: 'Secretnumber was successfully created.' }
        format.json { render json: @secretnumber, status: :created, location: @secretnumber }
      else
        format.html { render action: "new" }
        format.json { render json: @secretnumber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /secretnumbers/1
  # PUT /secretnumbers/1.json
  def update
    @secretnumber = Secretnumber.find(params[:id])

    respond_to do |format|
      if @secretnumber.update_attributes(params[:secretnumber])
        format.html { redirect_to @secretnumber, notice: 'Secretnumber was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @secretnumber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secretnumbers/1
  # DELETE /secretnumbers/1.json
  def destroy
    @secretnumber = Secretnumber.find(params[:id])
    @secretnumber.destroy

    respond_to do |format|
      format.html { redirect_to secretnumbers_url }
      format.json { head :no_content }
    end
  end
end
