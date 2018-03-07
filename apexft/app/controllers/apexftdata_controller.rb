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
    @apexftdatum = Apexftdatum.new(apexftdatum_params);

    respond_to do |format|
      if @apexftdatum.save
        @cPrice = calCallPrice();
        # puts "Call Price : #{@cPrice}"

        @pPrice = calPutPrice(@cPrice);
        # puts "Put Price : #{@pPrice}"

        # save call price and put price into database
        @apexftdatum.update_attribute(:callprice, @cPrice) 
        @apexftdatum.update_attribute(:putprice, @pPrice)
        format.html { redirect_to apexftdata_path, notice: 'Apexftdatum was successfully created.' }
        format.json { render :index, status: :created, location: @apexftdatum }
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
        @cPrice = calCallPrice();
        #puts "Call Price : #{@cPrice}"

        @pPrice = calPutPrice(@cPrice);
        #puts "Put Price : #{@pPrice}"

        # save call price and put price into database
        @apexftdatum.update_attribute(:callprice, @cPrice) 
        @apexftdatum.update_attribute(:putprice, @pPrice)

        format.html { redirect_to apexftdata_path, notice: 'Apexftdatum was successfully updated.' }
        format.json { render :index, status: :ok, location: @apexftdatum }
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
      params.require(:apexftdatum).permit(:callprice, :putprice, :stockprice, :strikeprice, :timetomaturity, :interest, :volatility)
    end

    # calculateCallPrice 
    def calCallPrice()
      @callPrice = Apexftdatum.calculateCallPrice(apexftdatum_params);
    end

    # calPutPrice 
    def calPutPrice(cPrice)
      @putPrice = Apexftdatum.calculatePutPrice(cPrice, apexftdatum_params);
    end
end
