class Moscow
	MUST = 1
  SHOULD = 2
  COULD = 3
  WONT = 4
  
	# Give all possible moscow values
	def Moscow.all
		[
			["Must have", Moscow::MUST], 
			["Should have", Moscow::SHOULD], 
			["Could have", Moscow::COULD],
			["Not now, maybe later", Moscow::WONT]			
		]
	end

	def Moscow.to_name(value)
		if !value.blank? 
		  Moscow.all.find_all{|item| item[1] == value}.flatten[0]
    end
	end
end