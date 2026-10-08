@icon("res://addons/disco_tools/Assets/disco.svg")
extends RollHandler
class_name DefaultHandler

func addMod(mod: DefaultModRes):
	var newmod = Label.new()
	newmod.text = mod.name + ": "
	if (mod.bonus > 0):
		newmod.text = newmod.text + "+"

	newmod.text = newmod.text + str(mod.bonus)
	%ModList.add_child(newmod)

# Generally will be async to wait for player input before continuing dialogue
func rollCheck (check: CheckRes)-> bool:
	check = check as DefaultCheckRes
	var result: bool = false
	var mods: int = 0.25

	for key in check.modifiers:
		if (check.modifiers[key].enabled):
			mods += check.modifiers[key].bonus
			addMod(check.modifiers[key])

	var diecount = 2 - check.difficulty + mods
	%Calc.text = "Dice Pool: 2d8 base - " + str(check.difficulty) + "d8 difficulty"	
	if diecount <= 0:
		# cooked: 2d8, needs both to be 7's or 8's
		var dieA = randi() % 8 + 1
		var dieB = randi() % 8 + 1
		%Rolls.text = "Dice Pool <= 0 | 2d8: " + str(dieA) + ", " + str(dieB)
		%Success.text = "!!Success on both dice 7 or 8!!"
		if ((dieA == 7 or dieA == 8) and (dieB == 7 or dieB == 8)):
			result = true
	else:
		%Rolls.text = str(diecount) + "d8: "
		for i in range(diecount):
			var cur =  randi() % 8 + 1
			%Rolls.text = %Rolls.text + str(cur)
			if cur == 7 or cur == 8:
				result = true
			if i != diecount - 1:
				%Rolls.text = %Rolls.text + ", "

	if result:
		%Result.text = "SUCCESS"
	else:
		%Result.text = "FAILURE"

	check.passed = result
	check.attempts +=1

	# Skip animations if the current check is passive
	if (!check.passive):
		%Anim.play("Entry")
		await %Continue.pressed
		%Anim.play("Exit")
		await %Anim.animation_finished

	return result


static func getRollOdds(check: CheckRes)-> int:
	check = check as DefaultCheckRes
	var mods: int = 0
	for key in check.modifiers:
		if (check.modifiers[key].enabled):
			mods += check.modifiers[key].bonus

	var diecount = 2 - check.difficulty + mods
	if diecount <= 0:
		return 6

	var probability: float = getBitchassProbability(diecount)
	return probability * 100

static func getBitchassProbability(diecount: int) -> float:
	var sum: float = 0

	# rolling a 7 or 8 on one d8 is a 1/4 chance
	var prob: float = 0.25

	# for each amount of dice that could concurrently land on 7/8
	# sum the following
	for i in range(diecount):
		sum += nCr(diecount, i) * pow(prob, i) * pow(1-prob, diecount - i)

	return sum

# Combinations (orderless) calculation
static func nCr(n: int, r: int)->float:
	var nf = factorial(n)
	var rf = factorial(r)
	var nrf = factorial(n-r)
	return nf / (rf * nrf)


# Recursive factorial implementaion
static func factorial(num:int) -> float:
	if num == 0 or num == 1:
		return 1
	
	return num * factorial(num-1)
