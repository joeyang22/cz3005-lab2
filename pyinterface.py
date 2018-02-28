from pyswip.prolog import Prolog
import easygui
import random

# A listing of prefixes and suffixes to say to the user
positivePrefix = ['That\'s great!', 'Nice!', 'Great!', 'Sounds good!']
positiveSuffix = ['as well?', 'too?', 'also?']
negativePrefix = ['Oh!', 'Nevermind!', 'Hmm,', 'Aww, ']
negativeSuffix = ['instead?', 'maybe?', 'hopefully?']

def query(item, begin, end):
	# Creates a GUI for asking a question based on the specific item and prefix/suffix
	return easygui.ynbox('{} Was there {} today {}'.format(begin, item, end), '', ('Yes', 'No'))

def askFollow(item):
	# Asks a followup question
	return easygui.ynbox('Was it {}?'.format(item), '', ('Yes', 'No'))

def main():
    # Initialize the prolog code
	prolog = Prolog()
	prolog.consult("talking_to_kid.pl")
	item = 'slides'
	stop = False
	first = True
	positive = True

	# Main program loop
	while not stop:
		#Ask someone a question based on their previous answer
		if first:
            # If this is the first question, we have a neutral statement
			first = False
			response = query(item, 'Hello!', '?')
		else:
			if positive:
                # We pick a random positive prefix and suffix if they answered positively previously
				response = query(item, random.choice(positivePrefix), random.choice(positiveSuffix))
			else:
                # We pick a random negative prefix and suffix if they answered 'no' to the previous queries
				response = query(item, random.choice(negativePrefix), random.choice(negativeSuffix))
		if response:
			#If the response is True, ask a followup
			followup = list(prolog.query('followup({}, Y)'.format(item)))
			# Retrieve a random followup question related to the item (Since some items can have multiple followups)
			followup_item = random.choice(followup)['Y']
			followup_true = askFollow(followup_item)
			# If the followup is true, then we can say that they like the item. Otherwise they dislike it
            # We add the item to the knowledge base as something that is liked or disliked by asserting this to the prolog script.
            if followup_true:
				prolog.assertz('like({})'.format(item))
				positive = True # Remember the positivity of the statement to change the statement
			else:
				prolog.assertz('dislike({})'.format(item))
				positive = False

		else:
			# We assume immediately they dislike something if they didn't do it
			prolog.assertz('dislike({})'.format(item))
			positive = False
        # We add the item to the prolog history of items
		prolog.assertz('history({})'.format(item))
        # Next, we try to get the next item that we should ask
		queryResult = list(prolog.query('ask(X, {})'.format(item)))
		if len(queryResult) == 0:
            # If there are no results, we know that there are no more possible answers
			easygui.msgbox('Glad you had a good day!')
			stop = True
			break
        # We just get the first item in the query result.
		item = queryResult[0]['X']

# Run the main program
if __name__ == "__main__":
	main()
