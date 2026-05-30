extends Control


var coreografia = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	carregar_coreografia()

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func carregar_coreografia():

	var file = FileAccess.open(
		"res://data/cansocorpus.json",
		FileAccess.READ
	)

	if file == null:
		print("No s'ha pogut obrir el fitxer")
		return

	var text_json = file.get_as_text()
	file.close()

	var json = JSON.new()

	var error = json.parse(text_json)

	if error != OK:
		print("Error JSON: ", json.get_error_message())
		print("Línia: ", json.get_error_line())
		return

	coreografia = json.data

	print("Títol: ", coreografia["Titul"])
	print("Durada: ", coreografia["Durada"])

	llegir_gegants()
	llegir_frases()
	llegir_coreografia()


func llegir_gegants():

	for gegant in coreografia["Gegants"]:

		print(
			gegant["id"],
			" - ",
			gegant["nom"]
		)


func llegir_frases():

	for frase in coreografia["Frases"]:

		print(
			frase["id"],
			" ",
			frase["titul"],
			" ",
			frase["inici"]
		)





func llegir_coreografia():

	for pista in coreografia["Coreografia"]:

		var gegant = pista["gegant"]

		print("=== ", gegant, " ===")

		for pas in pista["pasos"]:

			print(
				pas["pass"],
				" inici=",
				pas["inici"],
				" temps=",
				pas["temps"]
			)