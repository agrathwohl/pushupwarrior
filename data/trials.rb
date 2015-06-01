class PushupTrials
	def initialize(gender,age,result)
		@gender,@age,@result,@placement = gender,age,result.to_i,1
		@gl = {
			"M" => 4,
			"F" => 2
		}
		@stages = []
		@placement = @placement + @gl["#{@gender}"]
		@stages.push("tri")
		@al = {
			16  => 5,
			21  => 9,
			25  => 6,
			32  => 4,
			50  => 2
		}
		@al.each_pair do |akey,aval| 	#beginner
			next if @age > akey.to_i
			if @age < akey.to_i
				@placement = @placement + aval
			end
		end
		@stages.push("beg") if @placement.to_i <  @result
		return "#{@stages.length}".to_i
	end
end