from pyswip.prolog import Prolog

def main():
	prolog = Prolog()
	prolog.consult("example.pl")
	prolog.assertz("sibling(robert, fred)")
	print list(prolog.query('sibling(bob, fred)'))
if __name__ == "__main__":
	main()
