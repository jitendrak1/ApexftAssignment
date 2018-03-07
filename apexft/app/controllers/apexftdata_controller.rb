class ApexftdataController < ApplicationController
  before_action :set_apexftdatum, only: [:show, :edit, :update, :destroy]

  # GET /apexftdata
  # GET /apexftdata.json
  def index
    @apexftdata = Apexftdatum.all
  end

  # GET /apexftdata/1
  # GET /apexftdata/1.json
  def show
  end

  # GET /apexftdata/new
  def new
    @apexftdatum = Apexftdatum.new
  end

  # GET /apexftdata/1/edit
  def edit
  end

  # POST /apexftdata
  # POST /apexftdata.json
  def create
    @cPrice = calCallPrice();
    puts "Call Price : #{@cPrice}"

    #@pPrice = calPutPrice(@cPrice);

    #puts "Put Price : #{@pPrice}"

    @apexftdatum = Apexftdatum.new(apexftdatum_params);

    respond_to do |format|
      if @apexftdatum.save
        format.html { redirect_to @apexftdatum, notice: 'Apexftdatum was successfully created.' }
        format.json { render :show, status: :created, location: @apexftdatum }
      else
        format.html { render :new }
        format.json { render json: @apexftdatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apexftdata/1
  # PATCH/PUT /apexftdata/1.json
  def update
    respond_to do |format|
      if @apexftdatum.update(apexftdatum_params)
        format.html { redirect_to @apexftdatum, notice: 'Apexftdatum was successfully updated.' }
        format.json { render :show, status: :ok, location: @apexftdatum }
      else
        format.html { render :edit }
        format.json { render json: @apexftdatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apexftdata/1
  # DELETE /apexftdata/1.json
  def destroy
    @apexftdatum.destroy
    respond_to do |format|
      format.html { redirect_to apexftdata_url, notice: 'Apexftdatum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apexftdatum
      @apexftdatum = Apexftdatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apexftdatum_params
      params.require(:apexftdatum).permit(:stockprice, :strikeprice, :timetomaturity, :interest, :volatility)
    end

    # calculateCallPrice 
    def calCallPrice()
      @callPrice = Apexftdatum.calculateCallPrice(params.require(:apexftdatum).permit(:stockprice, :strikeprice, :timetomaturity, :interest, :volatility));
    end

    # calPutPrice 
    def calPutPrice(cPrice)
      #@putPrice = Apexftdatum.calculatePutPrice(params.require(:apexftdatum).permit(:callprice => cPrice, :stockprice, :strikeprice, :timetomaturity, :interest));
    end
end
