extends Node
class_name PanaBehavior

@export var maxOs : int = 5
@export var maxWords = 5
@export var maxSentence = 3

var enderArray : Array[String] = [".", "!", "?", "!?", "!!!", "..."]
var badWords : Array[String] = ["sex", "penis", "vagina", "pussy", "cunt", "bitch", "cum", "fuck", "cock", "horny", "goon", "67", "69", "ohio"]
var questionWords : Array[String] = ["can", "talk", "speak", "english", "human"]

var saidBadWord = false
var explained = false
var reacted = false

func getMessage(input : String) -> String:
	var msg = ""
	
	if (checkForSwears(input) and !saidBadWord):
		saidBadWord = true
		return "aw hell nah"
	
	if (saidBadWord and !reacted and !explained):
		reacted = true
		if (checkForQuestion(input)):
			explained = true
			reacted = false
			return "I only know how to say that previous message and this one explaining it."
	if (saidBadWord and !reacted and explained):
		reacted = true
		return "Moo?"
	
	var funkyNumber = randi_range(0, 100)
	if (funkyNumber == 1):
		return "Moo."
	elif (funkyNumber == 0):
		msg = "OINK MOO"
		for i in range(30):
			msg += "OOO"
		return msg
	
	var sentenceCount = randi_range(1, maxSentence)
	for i in range(sentenceCount):
		var oink = false
		if (i == 0):
			oink = true
		msg += generateSentence(oink)
		if (i != sentenceCount - 1):
			msg += " "
	
	return msg

func generateSentence(oink = false) -> String:
	var sentence = ""
	
	if (oink):
		var oinkVariation = randi_range(0, 1)
		if (oinkVariation == 0):
			sentence += "Oink"
		else:
			sentence += "Oink, oink"
		sentence += " "
	
	var wordCount = randi_range(1, maxWords)
	
	var capitalizeFirst = false
	if (oink == false):
		capitalizeFirst = true
	
	for i in (wordCount):
		if (i > 0 and capitalizeFirst):
			capitalizeFirst = false
		
		sentence += generateMoo(capitalizeFirst)
		if (i != wordCount - 1):
			sentence += " "
	
	var enderId = randi_range(0, enderArray.size() - 1)
	sentence += enderArray[enderId]
	
	return sentence

func generateMoo(capitalize = false) -> String:
	var moo = "moo"
	if (capitalize):
		moo = "Moo"
	
	var OCount = randi_range(0, maxOs)
	
	for i in (OCount):
		moo += "o"
	
	return moo

func checkForSwears(input : String) -> bool:
	for word in badWords:
		if (input.containsn(word)):
			return true
	return false

func checkForQuestion(input : String) -> bool:
	for word in questionWords:
		if (input.containsn(word)):
			return true
	return false
