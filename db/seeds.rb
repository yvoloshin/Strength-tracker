# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@user = User.create({id: 1, email: 'yvoloshin@yahoo.com', username: 'george'})

@workout_type = WorkoutType.create({
	user_id: 1, 
	type_name: "Ben Greenfied's Bike Muscular Enhancement", 
	description: "This workout is from 'Weight Training for Traiathlon' by Ben Greenfield. 
	It is designed to strengthen cycling-specific muscles. The exercises should be done in a sequence,
	one after another with 10-20 seconds of rest in between. A sequence consists of one set of each exercise.
	Repeat the sequence for as many sets as specified in the routine.",
	public: true
})

exercise_names = ['Alternating Bent Dumbbell Row in Lunge', 'Alternating Dumbbell Press',
'Alternating Biceps Curl', 'Cable Triceps Dips', 'Split Squat or Single Leg Squat', 
'Lateral Lunges', 'Front Plank Reaches']

exercise_names.each do |name|
	@workout_type.exercise_types.create(
			name: name,
			sets: 4,
			reps: 10,
			load: 30,
		)
end

