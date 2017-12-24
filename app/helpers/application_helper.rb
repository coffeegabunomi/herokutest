module ApplicationHelper
	def befor_month(calc_month)

		#当月計算(1-14日＝前月　15-月末＝当月)
		today = calc_month.strftime('%Y%m%d') 
		day = calc_month.strftime('%e').to_i

		temp_year = today.slice(0..3)
		temp_month = today.slice(4..5)

		if day >= 15 then
			#当月
			calc_month = today.slice(0..5)
		else
			#前月
			if temp_month == '01' then
				before_month = '12'
				before_year =  (temp_year.to_i - 1).to_s
			else
				temp_month = (data_month.to_i - 1).to_s
				before_year =  temp_year 
			end
			calc_month = before_year + before_month
		end
	end
end
