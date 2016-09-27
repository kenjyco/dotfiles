mdview () {
	pandoc $@ | lynx -stdin
}

mdless () {
	pandoc -t plain $@ | less -FX
}
