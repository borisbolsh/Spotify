struct Track {
	let imageName: String
	let title: String
	let artist: String
}

extension Track {
	static let track1 = Track(imageName: "40", title: "2112 (40 Anniversary)", artist: "Rush")
	static let track2 = Track(imageName: "2019", title: "2019", artist: "by Jonathan Rasmusson")
	static let track3 = Track(imageName: "2020", title: "2020", artist: "by Jonathan Rasmusson")
	static let track4 = Track(imageName: "album", title: "The Album", artist: "ABBA")
	static let track5 = Track(imageName: "apollo", title: "Apollo 11", artist: "Matt Morton")
	static let track6 = Track(imageName: "arrival", title: "Arrival", artist: "ABBA")
	static let track7 = Track(imageName: "blade", title: "Blade Runner", artist: "Vangelis")
	static let track8 = Track(imageName: "eric", title: "Eric Prydz - Ops", artist: "by Jonathan Rasmusson")
	static let track9 = Track(imageName: "favorites", title: "Liked Songs", artist: "572 songs")
	static let track10 = Track(imageName: "halt", title: "Halt and Catch Fire", artist: "Paul Haslinger")
	static let track11 = Track(imageName: "inside", title: "Inside Out", artist: "Michael Giacchino")
	static let track12 = Track(imageName: "jazzy", title: "Jazzy Dinner", artist: "by Spotify")
	static let track13 = Track(imageName: "masters", title: "Bach - 100", artist: "Johann Sebastian Bach")
	static let track14 = Track(imageName: "otron", title: "Tron", artist: "Various Artists")
	static let track15 = Track(imageName: "pixar", title: "Pixar", artist: "by Jonathan Rasmusson")
	static let track16 = Track(imageName: "svenska", title: "Svenska", artist: "Various Artists")
	static  let track17 = Track(imageName: "todd", title: "Album Time", artist: "Todd Terje")
	static let track18 = Track(imageName: "toto", title: "The Definitive Collection", artist: "TOTO")
	static let track19 = Track(imageName: "tron", title: "TRON: Legacy", artist: "Daft Punk")
	static let track20 = Track(imageName: "live", title: "Yes Live At The Apollo", artist: "Yes")
	static let track21 = Track(imageName: "visitors", title: "The Visitors", artist: "ABBA")
	static let track22 = Track(imageName: "vol1", title: "Greatest Hits Vol1", artist: "ABBA")
	static let track23 = Track(imageName: "vol2", title: "Greatest Hits Vol2", artist: "ABBA")
	static let track24 = Track(imageName: "yes", title: "90126", artist: "Yes")

	static let tracks = [track1, track2, track3, track4, track5, track6, track7, track8, track9, track10, track11, track12, track13, track14, track15, track16, track17, track18, track19, track20, track21, track22, track23, track24]

	static let playlists = [track1, track2, track3, track4, track5, track6, track7, track8, track9, track10, track11, track12, track13, track14, track15, track16, track17, track18, track19, track20, track21, track22, track23, track24]

	static let artists = [track9, track10, track11, track12, track13, track14, track15, track16, track17, track18, track19, track20, track21, track22, track23, track24]

	static let albums = [track16, track17, track18, track19, track20, track21, track22, track23, track24]
}
