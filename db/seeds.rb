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
	type_name: "Bike Muscular Enhancement", 
	description: "This workout is from <a href='https://read.amazon.com/kp/embed?asin=B006986EWA&preview=newtab&linkCode=kpe&ref_=cm_sw_r_kb_dp_vV-fzb33HE8HZ&tag=routinetrack-20'>Weight Training for Triathlon</a> by Ben Greenfield. 
	It is designed to strengthen cycling-specific muscles. Prior to this workout, it is recommended to do 3-5 minutes of 
	aerobic exercise, followed by dynamic stretching and foam rolling. The exercises should be done in a sequence,
	one after another with 10-20 seconds of rest in between. A sequence consists of one set of each exercise.
	Repeat the sequence for as many sets as specified in the routine. Descriptions of each exercise can be easily found on Youtube. 
	The load is specified as the percentage 
	of the maximum weight you can lift in one rep. Testing your one rep max directly is too risky and is never
	recommended, but there are a number of easy formulas and online calculators that can be used to estimate it.
	For example, you can use the calculator at <a href='http://www.bodybuilding.com/fun/other7.htm'>http://www.bodybuilding.com/fun/other7.htm</a>",
	public: true,
	is_visible: true
})

bike_exercise_names = ['Alternating Bent Dumbbell Row in Lunge', 'Alternating Dumbbell Press',
'Alternating Biceps Curl', 'Cable Triceps Dips', 'Split Squat or Single Leg Squat', 
'Lateral Lunges']

bike_bodyweight_exercise_names = ['Front Plank Reaches']

bike_exercise_names.each do |name|
	@bike_workout_type.exercise_types.create(
			name: name,
			sets: 4,
			reps: 10,
			load: '75-80%',
		)
end

bike_bodyweight_exercise_names.each do |name|
	@bike_workout_type.exercise_types.create(
			name: name,
			sets: 4,
			reps: 10,
			load: 'body weight',
		)
end

@run_workout_type = WorkoutType.create({
	user_id: 1, 
	type_name: "Running Foundational Strength", 
	description: "This workout is from <a href='https://www.amazon.com/dp/B006986EWA/ref=cm_sw_r_tw_dp_x_vV-fzb33HE8HZ'>Weight Training for Triathlon</a> by Ben Greenfield.  
	It is designed to strengthen running-specific muscles. Prior to this workout, it is recommended to do 3-5 minutes of 
	aerobic exercise, followed by dynamic stretching and foam rolling. The exercises should be done in a sequence,
	one after another with 10-20 seconds of rest in between. A sequence consists of one set of each exercise.
	Repeat the sequence for as many sets as specified in the routine. Descriptions of each exercise can be easily found on Youtube. The load is specified as the percentage 
	of the maximum weight you can lift in one rep. Testing your one rep max directly is too risky and is never
	recommended, but there are a number of easy formulas and online calculators that can be used to estimate it.
	For example, you can use the calculator at <a href='http://www.bodybuilding.com/fun/other7.htm'>http://www.bodybuilding.com/fun/other7.htm</a>",
	public: true,
	is_visible: true
})

run_exercise_names = ['Single Leg Overhead Press With Knee Drive', 'Running Man Row',
'Walking Lunge']

run_bodyweight_exercise_names = ['Single Leg Bridge', 'Hip Hikes', 'Fire Hydrants']

run_exercise_names.each do |name|
	@run_workout_type.exercise_types.create(
			name: name,
			sets: 4,
			reps: 10,
			load: '75-80%',
		)
end

run_bodyweight_exercise_names.each do |name|
	@run_workout_type.exercise_types.create(
			name: name,
			sets: 4,
			reps: 10,
			load: 'body weight',
		)
end

@ten_to_one_workout_type = WorkoutType.create({
	user_id: 1, 
	type_name: "10-1 Full Body Workout", 
	description: "This workout is from Jen Eddins at <a href='http://www.peanutbutterrunner.com'>peanutbutterrunner.com</a>. The exercises in each set are meant to be done as a circuit. Start with 10 reps of each exercise in a set and work down to 1. The original workout had front squats, which I replaced with one-legged squats here.",
	public: true,
	is_visible: true
})

ten_to_one_exercise_names = ['One-legged Squats', 'Pull Ups (may be assisted)', 'Box Jumps or Step Ups', 'Push Ups']

ten_to_one_exercise_names.each do |name|
	@ten_to_one_workout_type.exercise_types.create(
			name: name,
			sets: 10,
			reps: 10,
			load: '',
		)
end

