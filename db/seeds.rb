# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.create({id: 1, email: 'yvoloshin@yahoo.com', username: 'george'})

@bike_workout_type = WorkoutType.create({
	user_id: 1, 
	type_name: "Ben Greenfied's Bike Muscular Enhancement", 
	description: "This workout is from 'Weight Training for Triathlon' by Ben Greenfield. 
	It is designed to strengthen cycling-specific muscles. Prior to this workout, it is recommended to do 3-5 minutes of 
	aerobic exercise, followed by dunamic stretching and foam rolling. The exercises should be done in a sequence,
	one after another with 10-20 seconds of rest in between. A sequence consists of one set of each exercise.
	Repeat the sequence for as many sets as specified in the routine. The load is specified as the percentage 
	of the maximum weight you can lift in one rep. Testing your one rep max directly is too risky and is never
	recommended, but there are a number of easy formulas and online calculators that can be used to estimate it.
	For example, you can use the calculator at http://www.bodybuilding.com/fun/other7.htm",
	public: true
})

bike_exercise_names = ['Alternating Bent Dumbbell Row in Lunge', 'Alternating Dumbbell Press',
'Alternating Biceps Curl', 'Cable Triceps Dips', 'Split Squat or Single Leg Squat', 
'Lateral Lunges', 'Front Plank Reaches']

bike_exercise_names.each do |name|
	@bike_workout_type.exercise_types.create(
			name: name,
			sets: 4,
			reps: 10,
			load: '70%',
		)
end

