/// Beginner-friendly, no-equipment workouts. All instructions are original
/// text written for Nuvora. They are general guidance, not medical advice:
/// stop if anything hurts, and check with a qualified professional if you
/// have a health condition or injury.
enum WorkoutCategory { fullBody, upperBody, lowerBody, core, mobility, quick }

enum Difficulty { beginner, intermediate }

class Exercise {
  const Exercise({
    required this.name,
    required this.instructions,
    required this.modification,
    this.seconds,
    this.reps,
  }) : assert((seconds == null) != (reps == null),
            'Exactly one of seconds or reps is required');

  final String name;
  final String instructions;

  /// An easier option for the same movement.
  final String modification;

  /// Timed exercise length, or null when repetition based.
  final int? seconds;

  /// Target repetitions, or null when timed.
  final int? reps;

  bool get isTimed => seconds != null;
}

class Workout {
  const Workout({
    required this.id,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.restSeconds,
    required this.exercises,
  });

  final String id;
  final String name;
  final WorkoutCategory category;
  final Difficulty difficulty;
  final int restSeconds;
  final List<Exercise> exercises;

  /// Estimated total time. Repetition-based moves are counted at 3 seconds
  /// per repetition.
  int get estimatedSeconds {
    var total = 0;
    for (final e in exercises) {
      total += e.isTimed ? e.seconds! : e.reps! * 3;
    }
    return total + restSeconds * (exercises.length - 1);
  }

  int get estimatedMinutes => (estimatedSeconds / 60).ceil();
}

/// One step of a workout run: an exercise or a rest between exercises.
class WorkoutStep {
  const WorkoutStep.work(this.exerciseIndex, this.exercise)
      : isRest = false,
        restSeconds = null;
  const WorkoutStep.rest(this.exerciseIndex, int seconds)
      : isRest = true,
        restSeconds = seconds,
        exercise = null;

  /// For work steps, the exercise's index; for rest steps, the index of the
  /// exercise that follows.
  final int exerciseIndex;
  final bool isRest;
  final Exercise? exercise;
  final int? restSeconds;

  /// Seconds for timed steps, or null when the step ends when the user taps
  /// "Done" (repetition-based exercise).
  int? get durationSeconds => isRest ? restSeconds : exercise!.seconds;
}

/// Work and rest steps in order, with no rest after the final exercise.
List<WorkoutStep> buildSteps(Workout w) {
  final steps = <WorkoutStep>[];
  for (var i = 0; i < w.exercises.length; i++) {
    steps.add(WorkoutStep.work(i, w.exercises[i]));
    if (i < w.exercises.length - 1) {
      steps.add(WorkoutStep.rest(i + 1, w.restSeconds));
    }
  }
  return steps;
}

const workouts = <Workout>[
  Workout(
    id: 'full_starter',
    name: 'Full-Body Starter',
    category: WorkoutCategory.fullBody,
    difficulty: Difficulty.beginner,
    restSeconds: 20,
    exercises: [
      Exercise(
        name: 'March in place',
        instructions:
            'Stand tall and lift your knees one at a time at an easy pace. Swing your arms naturally and breathe steadily.',
        modification: 'Keep your feet low and slow the pace.',
        seconds: 40,
      ),
      Exercise(
        name: 'Bodyweight squat',
        instructions:
            'Stand with feet shoulder-width apart. Push your hips back and bend your knees as if sitting on a chair, then stand up by pressing through your heels.',
        modification: 'Squat to a chair and lightly touch it before standing.',
        reps: 12,
      ),
      Exercise(
        name: 'Wall push-up',
        instructions:
            'Place your hands on a wall at chest height, a little wider than your shoulders. Bend your elbows to bring your chest toward the wall, then press away.',
        modification: 'Stand closer to the wall for a smaller range.',
        reps: 10,
      ),
      Exercise(
        name: 'Glute bridge',
        instructions:
            'Lie on your back with knees bent and feet flat. Press through your heels to lift your hips until your body forms a line from shoulders to knees, then lower slowly.',
        modification: 'Lift only a few centimeters and pause briefly.',
        reps: 12,
      ),
      Exercise(
        name: 'Forearm plank on knees',
        instructions:
            'Rest on your forearms and knees with your back straight. Tighten your stomach lightly and keep breathing.',
        modification: 'Shorten the hold and rest when your form slips.',
        seconds: 20,
      ),
    ],
  ),
  Workout(
    id: 'upper_basics',
    name: 'Upper-Body Basics',
    category: WorkoutCategory.upperBody,
    difficulty: Difficulty.beginner,
    restSeconds: 30,
    exercises: [
      Exercise(
        name: 'Arm circles',
        instructions:
            'Extend your arms to the sides and draw small circles, then gradually make them larger. Switch direction halfway.',
        modification: 'Keep the circles small and lower your arms if tired.',
        seconds: 30,
      ),
      Exercise(
        name: 'Incline push-up',
        instructions:
            'Place your hands on a sturdy table or counter edge. Keep your body in one line and bend your elbows to lower your chest, then press up.',
        modification: 'Use a higher surface, such as a wall.',
        reps: 8,
      ),
      Exercise(
        name: 'Chair dip',
        instructions:
            'Sit on the edge of a sturdy chair, hands beside your hips. Slide forward, bend your elbows straight back to lower slightly, then press up.',
        modification: 'Keep your knees bent and feet close to the chair.',
        reps: 8,
      ),
      Exercise(
        name: 'Superman hold',
        instructions:
            'Lie face down with arms extended. Lift your arms, chest and legs a little off the floor, looking at the floor, and hold.',
        modification: 'Lift only your arms or only your legs.',
        seconds: 20,
      ),
      Exercise(
        name: 'Shoulder blade squeeze',
        instructions:
            'Stand tall with arms bent at your sides. Draw your shoulder blades together and down, hold for a moment, then relax.',
        modification: 'Do this seated with a gentler squeeze.',
        reps: 12,
      ),
    ],
  ),
  Workout(
    id: 'lower_basics',
    name: 'Lower-Body Basics',
    category: WorkoutCategory.lowerBody,
    difficulty: Difficulty.beginner,
    restSeconds: 30,
    exercises: [
      Exercise(
        name: 'Bodyweight squat',
        instructions:
            'Feet shoulder-width apart, hips back and down, chest up. Press through your heels to stand.',
        modification: 'Squat to a chair for support.',
        reps: 12,
      ),
      Exercise(
        name: 'Reverse lunge',
        instructions:
            'Step one foot back and lower until both knees bend comfortably, then push through the front foot to return. Alternate legs.',
        modification: 'Hold a wall or chair and take a shorter step.',
        reps: 10,
      ),
      Exercise(
        name: 'Calf raise',
        instructions:
            'Stand tall and rise onto the balls of your feet, pause, then lower slowly.',
        modification: 'Hold a wall for balance.',
        reps: 15,
      ),
      Exercise(
        name: 'Glute bridge',
        instructions:
            'On your back with knees bent, press your heels down to lift your hips, then lower with control.',
        modification: 'Lift lower and pause for a breath.',
        reps: 12,
      ),
      Exercise(
        name: 'Wall sit',
        instructions:
            'Slide your back down a wall until your knees bend, feet flat and hip-width apart. Hold and breathe.',
        modification: 'Slide down less so your knees bend only slightly.',
        seconds: 20,
      ),
    ],
  ),
  Workout(
    id: 'core_basics',
    name: 'Core Basics',
    category: WorkoutCategory.core,
    difficulty: Difficulty.beginner,
    restSeconds: 25,
    exercises: [
      Exercise(
        name: 'Dead bug',
        instructions:
            'Lie on your back with arms up and knees bent over hips. Lower the opposite arm and leg toward the floor while keeping your lower back steady, then switch.',
        modification: 'Move only your legs, one at a time.',
        reps: 10,
      ),
      Exercise(
        name: 'Bird dog',
        instructions:
            'On hands and knees, reach one arm forward and the opposite leg back, keeping hips level. Return and switch sides.',
        modification: 'Lift just the leg, or just the arm.',
        reps: 10,
      ),
      Exercise(
        name: 'Forearm plank on knees',
        instructions:
            'Forearms and knees on the floor, back straight, stomach lightly tight. Keep breathing.',
        modification: 'Hold for a shorter time.',
        seconds: 20,
      ),
      Exercise(
        name: 'Slow bicycle',
        instructions:
            'Lie on your back, hands lightly behind your head. Bring one knee in as the opposite elbow moves toward it, slowly alternating.',
        modification: 'Keep your head down and move your legs only.',
        reps: 16,
      ),
      Exercise(
        name: 'Side plank on knees',
        instructions:
            'Lie on one side, propped on your forearm with knees bent. Lift your hips and hold. Do half the time on each side.',
        modification: 'Keep your hips on the floor and press gently.',
        seconds: 20,
      ),
    ],
  ),
  Workout(
    id: 'mobility_flow',
    name: 'Mobility and Stretch',
    category: WorkoutCategory.mobility,
    difficulty: Difficulty.beginner,
    restSeconds: 10,
    exercises: [
      Exercise(
        name: 'Cat-cow',
        instructions:
            'On hands and knees, round your back and tuck your chin, then arch gently and look forward. Move with your breath.',
        modification: 'Do it seated, rounding and arching your back.',
        seconds: 40,
      ),
      Exercise(
        name: "Child's pose",
        instructions:
            'Sit back toward your heels with arms stretched forward and forehead down. Breathe slowly.',
        modification: 'Place a cushion between your hips and heels.',
        seconds: 30,
      ),
      Exercise(
        name: 'Hip flexor stretch',
        instructions:
            'Kneel on one knee, tuck your pelvis slightly and shift forward until you feel a gentle stretch at the front of the hip. Hold, then switch.',
        modification: 'Use a cushion under your knee.',
        seconds: 40,
      ),
      Exercise(
        name: 'Seated hamstring stretch',
        instructions:
            'Sit with one leg extended and the other bent. Hinge forward from the hips with a long back until you feel a mild stretch. Hold, then switch.',
        modification: 'Bend the extended knee slightly.',
        seconds: 40,
      ),
      Exercise(
        name: 'Shoulder rolls',
        instructions:
            'Roll your shoulders up, back and down in slow circles. Reverse the direction halfway.',
        modification: 'Make the circles smaller.',
        seconds: 30,
      ),
    ],
  ),
  Workout(
    id: 'busy_day',
    name: 'Busy Day Mini',
    category: WorkoutCategory.quick,
    difficulty: Difficulty.beginner,
    restSeconds: 15,
    exercises: [
      Exercise(
        name: 'Step jacks',
        instructions:
            'Step one foot out to the side while raising your arms, then return. Alternate sides at a steady pace.',
        modification: 'Lower your arms and slow down.',
        seconds: 30,
      ),
      Exercise(
        name: 'Bodyweight squat',
        instructions:
            'Hips back and down, chest up, press through your heels to stand.',
        modification: 'Squat to a chair.',
        reps: 10,
      ),
      Exercise(
        name: 'Incline push-up',
        instructions:
            'Hands on a sturdy counter, body in one line, bend your elbows to lower, then press up.',
        modification: 'Use a wall.',
        reps: 8,
      ),
      Exercise(
        name: 'Forearm plank on knees',
        instructions: 'Forearms and knees down, back straight, breathe steadily.',
        modification: 'Hold for a shorter time.',
        seconds: 20,
      ),
    ],
  ),
];

Workout? workoutById(String id) {
  for (final w in workouts) {
    if (w.id == id) return w;
  }
  return null;
}
