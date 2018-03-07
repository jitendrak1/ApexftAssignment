class Apexftdatum < ApplicationRecord
	validates :stockprice, :strikeprice, :timetomaturity, :interest, :volatility, :presence => true
	validates :stockprice, :strikeprice, :timetomaturity, :interest, :volatility, :numericality => true

	def self.cnd(x)
	    a1, a2, a3, a4, a5 = 0.31938153, -0.356563782, 1.781477937, -1.821255978, 1.330274429;
	    l = x.abs;
	    k = 1.0 / (1.0 + 0.2316419 * l);
	    w = 1.0 - 1.0 / Math.sqrt(2*Math::PI)*Math.exp(-l*l/2.0) * (a1*k + a2*k*k + a3*(k**3) + a4*(k**4) + a5*(k**5));
	    w = 1.0 - w if x < 0
    	return w;
	end

	# calculate put price on the bases of call price and give parameters.
	def self.calculatePutPrice(cprice, put_price_params) 
        call_price = cprice.to_f;
        stockprice = put_price_params['stockprice'].to_f; 
        strikeprice = put_price_params['strikeprice'].to_f; 
        timetomaturity = put_price_params['timetomaturity'].to_f / 252.0; 
        interestrate = put_price_params['interest'].to_f / 100.0; 

		put_price = call_price + (strikeprice / (Math.exp( interestrate * interestrate)) ) - stockprice;

		return put_price;   
	end


	# calculate call price on the bases of parameters passed.
	def self.calculateCallPrice(call_price_params) 
		stockprice = call_price_params[:stockprice].to_f; 
        strikeprice = call_price_params[:strikeprice].to_f; 
        timetomaturity = call_price_params[:timetomaturity].to_f / 252.0; 
        interestrate = call_price_params[:interest].to_f / 100.0; 
        volatility = call_price_params[:volatility].to_f / 100.0; 

	    # calculate d1 and d2.
	    d1 = ( Math::log(stockprice / strikeprice) + (interestrate + (volatility ** 2) / 2.0) * timetomaturity) / (volatility * Math.sqrt(timetomaturity));
	    d2 = d1 - (volatility * Math.sqrt(timetomaturity));

	    # Calculate c = current equilibrium value of the call option.
	     call_price = (stockprice * cnd(d1)) - ( strikeprice / Math.exp(interestrate * timetomaturity) ) * cnd(d2);

	    return call_price;    
	end

end
