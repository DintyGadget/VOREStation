//
// Load the list of available music tracks for the jukebox (or other things that use music)
//

// Music track available for playing in a media machine.
/datum/track
	var/url			// URL to load song from
	var/title		// Song title
	var/artist		// Song's creator
	var/duration	// Song length in deciseconds
	var/secret		// Show up in regular playlist or secret playlist?
	var/lobby		// Be one of the choices for lobby music?
	var/jukebox		// Does it even show up in the jukebox?

/datum/track/New(var/url, var/title, var/duration, var/artist = "", var/secret = 0, var/lobby = 0, var/jukebox = 0)
	src.url = url
	src.title = title
	src.artist = artist
	src.duration = duration
	src.secret = secret
	src.lobby = lobby
	src.jukebox = jukebox

/datum/track/proc/display()
	var str = "\"[title]\""
	if(artist)
		str += " [artist]"
	return str

/datum/track/proc/toTguiList()
	return list("ref" = "\ref[src]", "title" = title, "artist" = artist, "duration" = duration)


// Global list holding all configured jukebox tracks
var/global/list/all_jukebox_tracks = list()
var/global/list/all_lobby_tracks = list()

// Read the jukebox configuration file on system startup.
/hook/startup/proc/load_jukebox_tracks()
	var/jukebox_track_file = "config/jukebox.json"
	var/jukebox_track_file_private = "config/jukebox_private.json" // Uncommitted

	if(!fexists(jukebox_track_file))
		warning("File not found: [jukebox_track_file]")
		return 1

	var/list/jsonData = json_decode(file2text(jukebox_track_file))

	if(!istype(jsonData))
		warning("Failed to read tracks from [jukebox_track_file], json_decode failed.")
		return 1

	// Optional
	if(fexists(jukebox_track_file_private))
		var/list/jsonData_private = json_decode(file2text(jukebox_track_file_private))
		if(istype(jsonData_private))
			jsonData += jsonData_private // Pack more tracks in
		else
			warning("Failed to read tracks from [jukebox_track_file_private], json_decode failed.")
			//return 1 // Not worth failing over, as this file is optional

	for(var/entry in jsonData)
		if(!istext(entry["url"]))
			warning("Jukebox entry [entry]: bad or missing 'url'")
			continue
		if(!istext(entry["title"]))
			warning("Jukebox entry [entry]: bad or missing 'title'")
			continue
		if(!isnum(entry["duration"]))
			warning("Jukebox entry [entry]: bad or missing 'duration'")
			continue
		var/datum/track/T = new(entry["url"], entry["title"], entry["duration"])
		if(istext(entry["artist"]))
			T.artist = entry["artist"]
		T.secret = entry["secret"] ? 1 : 0
		T.lobby = entry["lobby"] ? 1 : 0
		T.jukebox = entry["jukebox"] ? 1 : 0
		all_jukebox_tracks += T
		if(T.lobby)
			all_lobby_tracks += T
	return 1
