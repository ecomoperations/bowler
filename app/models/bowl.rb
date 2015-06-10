class Bowl < ActiveRecord::Base
	belongs_to :player
   

    
	def roll  	
		pins_hit = rand(1..10)
		
		if first_roll? && pins_hit == 10
			self.score = 10
			self.turn += 2
		elsif first_roll? 
			self.score = pins_hit
			self.turn += 1
		else
			self.score = 0
			pins_hit = rand(1..pins_left)
	   		self.score += pins_hit
			self.turn += 1

		end			
		self.strike_spare = spare_points
		self.strike_spare += strike_points


		# !spare_points.nil? ? self.strike_spare = spare_points : self.strike_spare = 0
		# strike_points.nil? ? self.strike_spare = 0 : self.strike_spare = strike_points
	end

	def first_roll?
		turn_array.reduce(:+).nil? ? true : first_roll
	end

	def self.total_score
		if Bowl.new.num_rolls > 2
			Bowl.all.map(&:strike_spare).reduce(:+) + Bowl.all.map(&:score).reduce(:+)
		else 
			Bowl.all.map(&:score).reduce(:+)
		end
	end

	def spare?
		 scores_array.last(2).reduce(:+) == 10 && first_roll unless scores_array.length <= 1
	end

	def first_roll
		num_rolls % 2 == 0
	end

	def spare_points
		if num_rolls > 3
			was_spare = scores_array[-3..-2].reduce(:+) == 10 && !first_roll
		elsif num_rolls == 3 
			was_spare = scores_array[0..1].reduce(:+) == 10
		else
			was_spare = false
		end
		was_spare ? scores_array[-1] : 0
				
	end

	def strike?
		scores_array.last == 10 
	end

	def strike_points
		was_strike = scores_array[-3] == 10 if num_rolls >= 3 
		was_strike ? scores_array[-2..-1].reduce(:+) : 0
	end

	def last_frame
		strike? ? scores_array.last : scores_array.last(2).reduce(:+)
	end


	def frame_number
		if num_rolls >= 20
			10
		elsif num_rolls.nil?
			0
		else
			num_rolls / 2 + 1
		end
	end

	def num_rolls
		turn_array.empty? ? 0 : turn_array.reduce(:+)
	end

	def turn_array
		Bowl.all.map(&:turn) # array of turns
	end

	def scores_array
		Bowl.all.map(&:score)
	end

	def pins_left 
		10 - (scores_array.last)
	end

    
end
