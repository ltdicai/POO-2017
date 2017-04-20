'From Cuis 5.0 of 7 November 2016 [latest update: #3068] on 20 April 2017 at 2:14:17 am'!
'Description Please enter a description for this package'!
!provides: 'Games' 1 1!
!classDefinition: #Judge category: #Games!
Object subclass: #Judge
	instanceVariableNames: 'first second'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Games'!
!classDefinition: 'Judge class' category: #Games!
Judge class
	instanceVariableNames: ''!

!classDefinition: #Move category: #Games!
Object subclass: #Move
	instanceVariableNames: 'moveType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Games'!
!classDefinition: 'Move class' category: #Games!
Move class
	instanceVariableNames: ''!

!classDefinition: #Player category: #Games!
Object subclass: #Player
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Games'!
!classDefinition: 'Player class' category: #Games!
Player class
	instanceVariableNames: ''!

!classDefinition: #RandomMoveGenerator category: #Games!
Object subclass: #RandomMoveGenerator
	instanceVariableNames: 'random'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Games'!
!classDefinition: 'RandomMoveGenerator class' category: #Games!
RandomMoveGenerator class
	instanceVariableNames: ''!


!Judge methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:16:57'!
addPlayer: aPlayer addPlayer: anotherPlayer 
	first := aPlayer.
	second := anotherPlayer.
	^self! !

!Judge methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 02:09:40'!
play
	| firstMove secondMove |
	firstMove _ first getMove.
	secondMove _ second getMove.
	firstMove compareTo:secondMove 
		ifWin:[^'{1} wins because {2} beat {3}' format: {first getName. firstMove getType. secondMove getType}.] 
		ifLose:[^'{1} wins because {2} beat {3}' format: {second getName. secondMove getType. firstMove getType}.] 
		ifTie:[^'{1} and {2} tie with {3}' format: {first getName. second getName. firstMove getType}.]! !

!Move methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:53:15'!
compareTo: aMove ifTrue: aBlockClosure ifFalse: aBlockClosure3
	(moveType = (aMove getType)) ifTrue:aBlockClosure value ifFalse:aBlockClosure3 value.! !

!Move methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 01:14:04'!
compareTo: aMove ifWin: aBlockClosure ifLose: aBlockClosure3 ifTie: aBlockClosure4 
	moveType = aMove getType ifTrue:aBlockClosure4 ifFalse:[
		moveType = 'Rock' ifTrue:[
			aMove getType = 'Scissors' ifTrue:aBlockClosure ifFalse:aBlockClosure3
			].
		moveType = 'Scissors' ifTrue:[
			aMove getType = 'Paper' ifTrue:aBlockClosure ifFalse:aBlockClosure3
			].
		moveType = 'Paper' ifTrue:[
			aMove getType = 'Rock' ifTrue:aBlockClosure ifFalse:aBlockClosure3
			]
		].
	! !

!Move methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:53:43'!
getType
	^moveType! !

!Move methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:40:44'!
type: aString 
	moveType := aString.
	^self! !

!Move class methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 01:54:07'!
getOne
	| aMove |
	aMove _ Move new.
	^aMove type:(RandomMoveGenerator init getRandomMove)! !

!Player methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:37:45'!
getMove
	^Move getOne.! !

!Player methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 01:00:37'!
getName
	^name! !

!Player methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:05:31'!
setName: aString 
	name := aString.
	^self! !

!Player class methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 00:02:57'!
withName: aString
	|a| 
	a _ self new.
	^a setName: aString! !

!RandomMoveGenerator methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 02:05:59'!
getRandomMove
	| randomNumber |
	randomNumber _ ((random next) * 1000) integerPart mod:3.
	randomNumber = 0 ifTrue:[
		^'Rock'
		] ifFalse: [
			randomNumber = 1 ifTrue:[^'Paper'] ifFalse:[^'Scissors']
		]! !

!RandomMoveGenerator methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 01:40:19'!
withRandom: aRandom
	random := aRandom.
	^self! !

!RandomMoveGenerator class methodsFor: 'as yet unclassified' stamp: 'DIC 4/20/2017 01:39:29'!
init
	| a |
	a _ self new.
	^a withRandom: Random new! !
