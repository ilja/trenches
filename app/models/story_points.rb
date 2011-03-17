class StoryPoint
  UNKNOWN = 0
  ACE = 1
  TWO = 2
  THREE = 3
  FIVE = 5
  EIGHT = 8
  TEN = 10
  KING = 20

	# Give all possible Points.
	def StoryPoint.all
		[
		  ["?", StoryPoint::UNKNOWN],
			["Ace", StoryPoint::ACE], 
			["Two", StoryPoint::TWO], 
			["Three", StoryPoint::THREE],
			["Five", StoryPoint::FIVE],
			["Eight", StoryPoint::EIGHT],
			["Ten", StoryPoint::TEN],
			["King", StoryPoint::KING]
		]
	end
end