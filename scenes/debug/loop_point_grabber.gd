extends Node2D

func _on_file_dialog_file_selected(path: String) -> void:
	var sampleRate := 44100
	
	var bytes := FileAccess.get_file_as_bytes(path)
	var size : int = (
	(bytes[0] << 24) |
	(bytes[1] << 16) |
	(bytes[2] << 8) |
	bytes[3])
	var decompressed := bytes.slice(4).decompress(size, FileAccess.CompressionMode.COMPRESSION_DEFLATE)
	var xml := XMLParser.new()
	xml.open_buffer(decompressed)
	var bpm := -1
	while xml.read() != ERR_FILE_EOF:
		if xml.get_node_type() == 1:
			if xml.get_node_name() == "timeline":
				if not xml.get_named_attribute_value("lpstate") == "1":
					print("Looping is disabled, but ill still print it for you anyways :)")
				var lp0 := xml.get_named_attribute_value("lp0pos").to_int()
				var lp1 := xml.get_named_attribute_value("lp1pos").to_int()
				var loopPoint0 := (lp0 * sampleRate * 60) / (48 * bpm)
				var loopPoint1 := (lp1 * sampleRate * 60) / (48 * bpm)
				print(str("Loop points: ", loopPoint0, " to ", loopPoint1))
			elif xml.get_node_name() == "bpm":
				bpm = xml.get_named_attribute_value("value").to_int()
	$FileDialog.visible = true
